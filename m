From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2] PM / Domains: Return -EPROBE_DEFER if we fail to init
 or turn-on domain
Date: Thu, 6 Aug 2015 12:46:23 +0100
Message-ID: <55C3490F.20307@nvidia.com>
References: <1438334400-26367-1-git-send-email-jonathanh@nvidia.com>	<55C0C4D3.2050600@nvidia.com>	<CAMuHMdW8H-mxG9poJpjijBCUHWs+Q4Xe3muXeTqnd7npBEzXRA@mail.gmail.com>	<1911839.6SetkcFuZL@vostro.rjw.lan>	<55C30FE4.9080206@nvidia.com>	<55C31AA9.8050202@nvidia.com>	<CAMuHMdU3y-wn5W3-9BD8epkqdWu+0_16pYwktVhqBHku+Mo2mg@mail.gmail.com>	<55C3284F.8070305@nvidia.com> <CAMuHMdV7AMQD564AgUSACAJFTdqtmMxU9yoefuZ2CXEEhR57RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4028 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbbHFLqa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2015 07:46:30 -0400
In-Reply-To: <CAMuHMdV7AMQD564AgUSACAJFTdqtmMxU9yoefuZ2CXEEhR57RQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Geert,

On 06/08/15 12:26, Geert Uytterhoeven wrote:
> Hi Jon,
> 
> On Thu, Aug 6, 2015 at 11:26 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
> 
> [...]
> 
>>>>>>>>> This causes a regression for platforms where:
>>>>>>>>>   1. DT describes the hardware power domains, and
>>>>>>>>>   2. The boot loader or reset state has enabled all power domains, and
>>>>>>>>>   3. Linux doesn't have a driver for the power controller yet.
>>>>>>>>>
>>>>>>>>> Before, devices for which the PM domain couldn't be found just probed and
>>>>>>>>> worked, Now, these devices don't probe anymore, and the kernel fails to boot.
> 
> [...]
> 
>> It still sounds to me that the nodes should be disabled/removed from the
>> dtb. Having a dynamic way to do this would be useful, I can see.
> 
> I had a quick look, and it already seem to exist..
> Hence on platforms not implementing power controllers yet, the early platform
> code could do:
> 
>         struct device_node *np;
>         for_each_node_with_property(dn, "power-domains")
>                 of_remove_property(np, "power-domains");
> 
> Haven't tested that yet, though...

Yes that could be an option, however, it would mean doing this type of
thing for various types of nodes. You mentioned dma was another case.

> Heck, even the core power domain code could do that, if
> CONFIG_PM_GENERIC_DOMAINS=n ;-)

Yes that's true. Hopefully it would WARN too ;-)

Jon

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
