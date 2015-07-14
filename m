From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V3 19/19] ARM: tegra: select PM_GENERIC_DOMAINS
Date: Tue, 14 Jul 2015 12:59:50 +0100
Message-ID: <55A4F9B6.1070904@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com> <1436791197-32358-20-git-send-email-jonathanh@nvidia.com> <20150713135047.GR6287@tbergstrom-lnx.Nvidia.com> <55A3C53F.8090003@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17798 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbbGNL76 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 07:59:58 -0400
In-Reply-To: <55A3C53F.8090003@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Prashant Gaikwad <pgaikwad@nvidia.com>, =?windows-1252?Q?Terje_Bergstr?= =?windows-1252?Q?=F6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org



On 13/07/15 15:03, Jon Hunter wrote:
> 
> 
> On 13/07/15 14:50, Peter De Schrijver wrote:
>> On Mon, Jul 13, 2015 at 01:39:57PM +0100, Jon Hunter wrote:
>>> From: Vince Hsu <vinceh@nvidia.com>
>>>
>>> We have added generic power domain support for Tegra SoCs. So now the
>>> option M_GENERIC_DOMAINS must be enabled by default to have proper power
>>
>> Missing P :)
> 
> Ooops. I think introduced that error. Will fix.

Updated version ...


>From f7b951cd05973d74fc25e33a1aaec5a6e77bfdc0 Mon Sep 17 00:00:00 2001
From: Vince Hsu <vinceh@nvidia.com>
Date: Wed, 11 Mar 2015 13:40:46 +0800
Subject: [PATCH 19/19] ARM: tegra: select PM_GENERIC_DOMAINS

We have added generic power domain support for Tegra SoCs. So now the
option PM_GENERIC_DOMAINS must be enabled by default to have proper power
sequence.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 0fa4c5f8b1be..fdf86cae3b32 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -9,6 +9,7 @@ menuconfig ARCH_TEGRA
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
 	select PM_OPP
+	select PM_GENERIC_DOMAINS if PM
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 	select SOC_BUS
-- 
2.1.4

