From: Len Brown <lenb@kernel.org>
Subject: [PATCH v4 0/1] suspend: make sync() on suspend-to-RAM optional
Date: Tue, 14 Jul 2015 22:24:50 -0400
Message-ID: <1436927091-32520-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35304 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbbGOCZH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 22:25:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Based on discussion resulting from...
https://lkml.org/lkml/2015/5/8/82 [PATCH 1/1] suspend: delete sys_sync(),
this patch makes sys_sync() optional, rather than deleting it entirely.

This is an update to the original patch for this issue from Jan, 2014:
patch https://lkml.org/lkml/2014/1/23/73
[PATCH v3] suspend: make sync() on suspend-to-RAM optional

Aside from applying to Linux 4.1, rather than 3.13...
the change is that suspend always checks the flag from the
sysfs attribute before invoking sys_sync(); and the config option
just sets the default value.  Before the config option deleted all code.
Also, the config dependency is corrected, and some varialbes re-named.

