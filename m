From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/1] cap11xx: add runtime PM support
Date: Thu, 25 Jun 2015 21:20:22 -0700
Message-ID: <1435292423-20895-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:32938 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbbFZETV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 00:19:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

Important Notes:
* Depends on v6 of "cap11xx: add LED support" patchset to applied first

Changes from v1:
* ifdef CONFIG_PM to prevent "unused functions" warning from compiler
* Added cap11xx_set_sleep() stub for systems built without PM

Matt Ranostay (1):
  cap11xx: add runtime PM support

 drivers/input/keyboard/cap11xx.c | 84 +++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 18 deletions(-)

-- 
1.9.1

