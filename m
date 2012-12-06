From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 3/6 v9] cpufreq: tolerate inexact values when collecting stats
Date: Thu,  6 Dec 2012 16:42:50 -0600
Message-ID: <1354833773-22845-4-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354833773-22845-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp127.dfw.emailsrvr.com ([67.192.241.127]:39739 "EHLO
	smtp127.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901Ab2LFWmn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Dec 2012 17:42:43 -0500
In-Reply-To: <1354833773-22845-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>

This patch is withdrawn due to a need for severe rework.

Changes from v4
        Withdrawn.      
Changes from v3, v2
        None.
Changes from v1
        Implemented a simple round-up algorithm instead of the over/under
method that could cause errors on Intel processors with boost mode.

