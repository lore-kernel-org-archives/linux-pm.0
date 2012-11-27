From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 0/6 v6] cpufreq: add support for Calxeda ECX-1000 (highbank)
Date: Tue, 27 Nov 2012 14:04:26 -0600
Message-ID: <1354046672-7392-1-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp117.dfw.emailsrvr.com ([67.192.241.117]:36051 "EHLO
	smtp117.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab2K0UEe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Nov 2012 15:04:34 -0500
In-Reply-To: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch series adds cpufreq support for the Calxeda
ECX-1000 (highbank) SoCs. The driver is based on the 
cpufreq-cpu0 driver. Because of the unique way that 
highbank uses the EnergyCore Management Engine to manage
voltages, it was not possible to use the cpufreq-cpu0 driver.

--Mark Langsdorf

