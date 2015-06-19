From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: [PATCH 1/4] extcon: Remove duplicate header file in extcon.h
Date: Fri, 19 Jun 2015 15:35:48 +0900
Message-ID: <1434695751-25631-2-git-send-email-cw00.choi@samsung.com>
References: <1434695751-25631-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:32869 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbbFSGgB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 02:36:01 -0400
Received: by pdjn11 with SMTP id n11so84093677pdj.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 23:36:00 -0700 (PDT)
In-Reply-To: <1434695751-25631-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: cwchoi00@gmail.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com

This patch removes the duplicate header file in extcon.h.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 include/linux/extcon.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index b16d929..1656c98 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -27,8 +27,6 @@
 #define __LINUX_EXTCON_H__
 
 #include <linux/device.h>
-#include <linux/notifier.h>
-#include <linux/sysfs.h>
 
 /*
  * Define the unique id of supported external connectors
-- 
2.2.0.GIT

