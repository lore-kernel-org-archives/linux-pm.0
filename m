From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/4] x86 smpboot: optimize cpu_up() a bit more...
Date: Sun, 16 Aug 2015 11:45:44 -0400
Message-ID: <1439739948-21028-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36576 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbHPPqb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 16 Aug 2015 11:46:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

This set of patches optimizes cpu_up() speed.
Patch 3/4 depends on init_udelay, which was recently added to smpboot.

(and yes, it should havde been in Usec all along --
 it seems we somehow checked-in part of an old version of that patch)

cheers,
-Len


