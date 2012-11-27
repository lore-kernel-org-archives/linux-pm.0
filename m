From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 3/6 v5] cpufreq: tolerate inexact values when collecting stats
Date: Tue, 27 Nov 2012 09:04:31 -0600
Message-ID: <1354028674-23685-4-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354028674-23685-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp207.dfw.emailsrvr.com ([67.192.241.207]:60072 "EHLO
	smtp207.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab2K0PEg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Nov 2012 10:04:36 -0500
In-Reply-To: <1354028674-23685-1-git-send-email-mark.langsdorf@calxeda.com>
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

