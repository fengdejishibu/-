-- ========================================
-- 徒步社区平台 - MySQL 初始化脚本
-- 版本: v3.0 (Sprint1 专用)
-- 更新: 2026-04-02
-- 说明: 严格按 Sprint1 用户故事设计，不做超前设计
--
-- 用户故事覆盖:
--   US-03 资料编辑 → MongoDB user_profiles
--   US-06 身份标识 → MongoDB user_profiles
--   US-07 生成邀请码 → hiking_invite_code
--   US-08 管理员注册 → hiking_invite_code
--   US-10 授予身份 → MongoDB user_profiles
--
-- 技术栈:
--   MySQL 8.0+ → 结构化数据（邀请码）
--   MongoDB 5.0+ → 用户资料（灵活扩展）
--   Redis 6.0+ → 验证码、登录失败计数
-- ========================================

CREATE DATABASE IF NOT EXISTS hiking_db
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;

USE hiking_db;

-- ========================================
-- 注意: sys_user, sys_role, sys_menu, sys_user_role, sys_role_menu, sys_log
-- 等表已由 Pig 框架提供，此处直接使用，不重复创建。
-- 如需初始化，请执行 Platform/db/pig.sql
-- ========================================

-- ========================================
-- Sprint1 业务表
-- ========================================

-- ------------------------------------
-- 邀请码表
-- 用户故事: US-07 生成邀请码, US-08 管理员注册
-- ------------------------------------
CREATE TABLE IF NOT EXISTS hiking_invite_code (
    id BIGINT UNSIGNED AUTO_INCREMENT COMMENT '主键ID',
    code VARCHAR(32) NOT NULL COMMENT '邀请码（唯一） -- US-07/US-08',
    creator_id BIGINT NOT NULL COMMENT '创建人ID（关联sys_user.user_id） -- US-07',
    expire_time DATETIME NOT NULL COMMENT '过期时间 -- US-07',
    status TINYINT DEFAULT 1 COMMENT '状态（1-有效，0-已失效） -- US-07',

    PRIMARY KEY (id),
    UNIQUE KEY uk_code (code),
    INDEX idx_creator_id (creator_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='邀请码表';

-- ========================================
-- 初始数据
-- ========================================

-- 插入测试邀请码（可选，用于开发测试）
-- INSERT INTO hiking_invite_code (code, creator_id, expire_time, status) VALUES
-- ('TEST-CODE-2026', 1, '2026-12-31 23:59:59', 1);
