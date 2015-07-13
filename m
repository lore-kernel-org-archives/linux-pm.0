From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V3 06/19] clk: tegra: remove TEGRA_PLL_USE_LOCK for PLLD/PLLD2
Date: Mon, 13 Jul 2015 15:02:54 +0100
Message-ID: <55A3C50E.7060706@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com> <1436791197-32358-7-git-send-email-jonathanh@nvidia.com> <20150713134151.GQ6287@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12031 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbbGMODC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 10:03:02 -0400
In-Reply-To: <20150713134151.GQ6287@tbergstrom-lnx.Nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Prashant Gaikwad <pgaikwad@nvidia.com>, =?windows-1252?Q?Terje_Bergstr?= =?windows-1252?Q?=F6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org



On 13/07/15 14:41, Peter De Schrijver wrote:
> On Mon, Jul 13, 2015 at 01:39:44PM +0100, Jon Hunter wrote:
>> From: Vince Hsu <vinceh@nvidia.com>
>>
>> Tegra114 has a HW bug that the PLLD/PLLD2 lock bit cannot be asserted when
>> the DIS power domain is during up-powergating process but the clamp to this
> 
> I think there is missing 'off' in this sentence?
> 
> ie. ... 'the DIS power domain is off during up-powergating process'
> 
> Also 'un-powergating sequence' would be nicer.

Yes agree. I will re-word that.

Thanks
Jon
