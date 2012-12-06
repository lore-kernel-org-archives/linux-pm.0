From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 0/6 v9] cpufreq: add support for Calxeda ECX-1000 (highbank)
Date: Thu,  6 Dec 2012 16:42:47 -0600
Message-ID: <1354833773-22845-1-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp127.dfw.emailsrvr.com ([67.192.241.127]:38335 "EHLO
	smtp127.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964849Ab2LFWmm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Dec 2012 17:42:42 -0500
In-Reply-To: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch series adds cpufreq support for the Calxeda
ECX-1000 (highbank) SoCs. The EnergyCore Management Engine (ECME) on
the ECX-1000 manages the voltage for the part and communications with
Linux through a pl320 mailbox. clk notifications are used to control
when to send messages to the ECME.

--Mark Langsdorf
Calxeda, Inc.

