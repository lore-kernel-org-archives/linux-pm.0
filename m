From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V3 02/19] memory: tegra: Add MC flush support
Date: Mon, 20 Jul 2015 09:46:02 +0100
Message-ID: <55ACB54A.4080103@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com> <1436791197-32358-3-git-send-email-jonathanh@nvidia.com> <20150717095754.GG3057@ulmo> <20150717102049.GQ6287@tbergstrom-lnx.Nvidia.com> <20150717113124.GP3057@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15759 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756262AbbGTIqJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 04:46:09 -0400
In-Reply-To: <20150717113124.GP3057@ulmo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Prashant Gaikwad <pgaikwad@nvidia.com>, =?windows-1252?Q?Terje_Bergstr=F6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


On 17/07/15 12:31, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Jul 17, 2015 at 01:20:49PM +0300, Peter De Schrijver wrote:
>> On Fri, Jul 17, 2015 at 11:57:55AM +0200, Thierry Reding wrote:
>>>> Old Signed by an unknown key
>>>
>>> On Mon, Jul 13, 2015 at 01:39:40PM +0100, Jon Hunter wrote:
>>>> The Tegra memory controller implements a flush feature to flush pending
>>>> accesses and prevent further accesses from occurring. This feature is
>>>> used when powering down IP blocks to ensure the IP block is in a good
>>>> state. The flushes are organised by software groups and IP blocks are
>>>> assigned in hardware to the different software groups. Add helper
>>>> functions for requesting a handle to an MC flush for a given
>>>> software group and enabling/disabling the MC flush itself.
>>>>
>>>> This is based upon a change by Vince Hsu <vinceh@nvidia.com>.
>>>>
>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>> ---
>>>>  drivers/memory/tegra/mc.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/memory/tegra/mc.h |   2 +
>>>>  include/soc/tegra/mc.h    |  34 ++++++++++++++
>>>>  3 files changed, 146 insertions(+)
>>>
>>> Do we know if this is actually necessary? I remember having a discussion
>>> with Arnd Bergmann a while ago, and the Linux driver model kind of
>>> assumes that by the time a device is disabled all outstanding accesses
>>> will have stopped.
>>>
>>> Do we have a way to determine that this even makes a difference? Can we
>>> trigger a case where not doing this would cause breakage and see that
>>> adding this fixes that particular issue?
>>>
>>
>> Most likely it is. The memory controller can still be processing requests
>> when the peripheral domain is powergated. This would mean the response cannot
>> be delivered in that case. So we need to be sure there are no outstanding
>> requests before shutting down the domain.
> 
> My point is that that's the driver's responsibility anyway, hence making
> the explicit flush unnecessary.

I see your point and it is interesting. The trouble is that we would
need to test every memory client in every power domain to prove this. So
I don't think that is a trivial thing to do. Furthermore, looking at
what we have done in kernel used for android products (which probably
stress PM the most) this is done and so I don't know of any shipping
product that stresses PM that does not do this. May be someone else
might. I personally would not be comfortable removing this without
testing, but as I mentioned it is not a trivial thing to test correctly.
However, I will let you and the other maintainers decide what's best here.

Jon
