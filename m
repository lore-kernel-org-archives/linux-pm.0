From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: [PATCH 0/4] extcon: Clean-up the minor issue and fix the NULL pointer error
Date: Fri, 19 Jun 2015 15:35:47 +0900
Message-ID: <1434695751-25631-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33327 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbbFSGf5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 02:35:57 -0400
Received: by padev16 with SMTP id ev16so78695884pad.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 23:35:57 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: cwchoi00@gmail.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com

This patch-set clean-up the minor issue and fix the NULL pointer error of
extcon-palmas driver. And extcon driver don't support the bit operation to
identify the external connectors from Linux v4.2. So, patch4 removes the bit
data of mutually_exclusvie array.

Chanwoo Choi (4):
  extcon: Remove duplicate header file in extcon.h
  extcon: Remove optional print_state() function pointer of struct extcon_dev
  extcon: palmas: Fix NULL pointer error
  extcon: palmas: Remove the mutually_exclusive array

 drivers/extcon/extcon-gpio.c   | 18 ------------------
 drivers/extcon/extcon-palmas.c | 10 ----------
 drivers/extcon/extcon.c        |  8 --------
 include/linux/extcon.h         |  7 -------
 4 files changed, 43 deletions(-)

-- 
2.2.0.GIT

