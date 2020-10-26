Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D0C8300F
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 00:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F2B21707
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 00:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603758872;
	bh=CrB6/OrwiBYznvNDffIExnezDMuDC+LEIk22ZuZdcIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bGQ9D/M+aytTiXS/K6bC8bv1GFGNtYBuJYfAGanuwcQFyJDHQ9piCm5JKyUsFEkts
	 ejZyEUiANDIQ9x44IKUvq6KDKHAoVBH3bgbWSVaZ1eivqYxGHRlfEGRtdKc5VVz4px
	 BS5xRPUsAFBZL6x3Ce8djK304kxqywOuWxksv0DI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409142AbgJZXvH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409308AbgJZXvH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Oct 2020 19:51:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AABCB21BE5;
        Mon, 26 Oct 2020 23:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756266;
        bh=CrB6/OrwiBYznvNDffIExnezDMuDC+LEIk22ZuZdcIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xfC6mpCoDStY8v4UzkSXHNjJkOheVWGBUyNK8P9XW2ATzGOogRmQpTlQyCWJMJGfu
         Ryjojms0O6pggmOXKaKvW/Fd17Nj99yyvUVf03MSss1Ar10Z9XM0vz02eV9DGymtNV
         WiFpgI9c5ObBj0yWS2AR16XQiXHX0NK3CFFwrsqA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 099/147] power: supply: test_power: add missing newlines when printing parameters by sysfs
Date:   Mon, 26 Oct 2020 19:48:17 -0400
Message-Id: <20201026234905.1022767-99-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026234905.1022767-1-sashal@kernel.org>
References: <20201026234905.1022767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

[ Upstream commit c07fa6c1631333f02750cf59f22b615d768b4d8f ]

When I cat some module parameters by sysfs, it displays as follows.
It's better to add a newline for easy reading.

root@syzkaller:~# cd /sys/module/test_power/parameters/
root@syzkaller:/sys/module/test_power/parameters# cat ac_online
onroot@syzkaller:/sys/module/test_power/parameters# cat battery_present
trueroot@syzkaller:/sys/module/test_power/parameters# cat battery_health
goodroot@syzkaller:/sys/module/test_power/parameters# cat battery_status
dischargingroot@syzkaller:/sys/module/test_power/parameters# cat battery_technology
LIONroot@syzkaller:/sys/module/test_power/parameters# cat usb_online
onroot@syzkaller:/sys/module/test_power/parameters#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/test_power.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
index 04acd76bbaa12..4895ee5e63a9a 100644
--- a/drivers/power/supply/test_power.c
+++ b/drivers/power/supply/test_power.c
@@ -353,6 +353,7 @@ static int param_set_ac_online(const char *key, const struct kernel_param *kp)
 static int param_get_ac_online(char *buffer, const struct kernel_param *kp)
 {
 	strcpy(buffer, map_get_key(map_ac_online, ac_online, "unknown"));
+	strcat(buffer, "\n");
 	return strlen(buffer);
 }
 
@@ -366,6 +367,7 @@ static int param_set_usb_online(const char *key, const struct kernel_param *kp)
 static int param_get_usb_online(char *buffer, const struct kernel_param *kp)
 {
 	strcpy(buffer, map_get_key(map_ac_online, usb_online, "unknown"));
+	strcat(buffer, "\n");
 	return strlen(buffer);
 }
 
@@ -380,6 +382,7 @@ static int param_set_battery_status(const char *key,
 static int param_get_battery_status(char *buffer, const struct kernel_param *kp)
 {
 	strcpy(buffer, map_get_key(map_status, battery_status, "unknown"));
+	strcat(buffer, "\n");
 	return strlen(buffer);
 }
 
@@ -394,6 +397,7 @@ static int param_set_battery_health(const char *key,
 static int param_get_battery_health(char *buffer, const struct kernel_param *kp)
 {
 	strcpy(buffer, map_get_key(map_health, battery_health, "unknown"));
+	strcat(buffer, "\n");
 	return strlen(buffer);
 }
 
@@ -409,6 +413,7 @@ static int param_get_battery_present(char *buffer,
 					const struct kernel_param *kp)
 {
 	strcpy(buffer, map_get_key(map_present, battery_present, "unknown"));
+	strcat(buffer, "\n");
 	return strlen(buffer);
 }
 
@@ -426,6 +431,7 @@ static int param_get_battery_technology(char *buffer,
 {
 	strcpy(buffer,
 		map_get_key(map_technology, battery_technology, "unknown"));
+	strcat(buffer, "\n");
 	return strlen(buffer);
 }
 
-- 
2.25.1

