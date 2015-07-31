From: Len Brown <lenb@kernel.org>
Subject: [PATCH v5 0/1] suspend: make sync() on suspend-to-RAM build-time optional
Date: Fri, 31 Jul 2015 12:46:16 -0400
Message-ID: <1438361177-23201-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35011 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbGaQqn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 12:46:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Based on discussion resulting from...

https://lkml.org/lkml/2015/5/8/82
[PATCH 1/1] suspend: delete sys_sync()

https://lkml.org/lkml/2015/7/14/896
[PATCH v4 0/1] suspend: make sync() on suspend-to-RAM optional

this patch makes sys_sync() optional at build time,
rather than deleting it entirely.

cheers,
Len Brown, Intel Open Source Technology Center


