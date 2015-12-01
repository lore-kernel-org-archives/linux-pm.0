From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFD] PM_GENERIC_DOMAINS && !PM
Date: Tue, 1 Dec 2015 15:38:14 +0000
Message-ID: <565DBEE6.5030704@nvidia.com>
References: <565C7C86.7030801@nvidia.com> <1517697.Xq8gZV3Xnd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12754 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbLAPiU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 10:38:20 -0500
In-Reply-To: <1517697.Xq8gZV3Xnd@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>


On 30/11/15 22:42, Rafael J. Wysocki wrote:
> On Monday, November 30, 2015 04:42:46 PM Jon Hunter wrote:
>> Currently, if PM is disabled in the kernel then so is
>> PM_GENERIC_DOMAINS. Although this makes sense, I can see a scenario
>> where having minimal genpd support could be advantageous.
>>
>> I am looking at enabling genpd for Tegra and ideally we would populate
>> the power domains when the platform device is probed for the power
>> management controller (PMC) as this device contains the registers for
>> enabling the power domains.
>>
>> This works fine for the case where PM is enabled, but I am concerned
>> about the case where we don't have PM enabled in the kernel. In this
>> case, because domains are not populated early during the boot process, I
>> am concerned that there is a chance for a device dependent on a power
>> domain to be probed before the PMC device has been probed and had chance
>> to turn on any power domains.
> 
> So make the !PM case invalid for that platform.

Thierry, I know that we have not reviewed GPD for tegra recently, but
what are your thoughts on the above in principle? At least for Tegra 64-bit?

> Seriously, either PM is mandatory, or it isn't.  If it is mandatory, make it so
> instead of pretending that you can live without it.

I understand your point and I do agree, however, this means that for any
device with power-domains that PM is already mandatory (unless they
don't use genpd at all).

I see some platforms getting around this by enabling all the
power-domains early during the platform code and if PM is not enabled
then they won't be turned off and so all is ok (d438462c20a3 "ARM: imx6:
gpc: always enable PU domain if CONFIG_PM is not set"). However, this
assumes that power-domains will never fail to power on and this seems a
little fragile to me.

One thought I had was to make the PM_GENERIC_DOMAINS_OF code independent
of PM (ie. moved to domain_of.c) and with a little tweaking of the
genpd_dev_pm_attach() function it could be made to work whether PM is
enable or not. In other words, if PM is not enabled, then
genpd_dev_pm_attach() would only return success if:
1. The device is not dependent on a power domain or
2. The device is dependent on a power domain and it is present and
   already powered on.

Alternatively, may be genpd_dev_pm_attach() should always return
-EPROBE_DEFER (to prevent probing a device) if !PM and the device has a
"power-domains" node defined.

Cheers
Jon
