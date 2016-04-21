From: Eddie Huang <eddie.huang@mediatek.com>
Subject: Re: [RESEND PATCH 0/3 v6] Add Mediatek MT8173 cpufreq driver
Date: Thu, 21 Apr 2016 19:37:58 +0800
Message-ID: <1461238678.20801.11.camel@mtksdaap41>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
	 <20150826021659.GD8784@linux>
	 <CALx668V2herrp6XOtCDR7nNvFhd7DLLMjXmr86cjfCOQ_cgmrw@mail.gmail.com>
	 <22538895.vrRgZUmQTV@vostro.rjw.lan>
	 <CAGS+omAtiALWTjVJS4wNatXVLqZRSOk3m29QQvW=fQWs7Hs5ng@mail.gmail.com>
	 <55E73077.8060106@gmail.com> <5718AAF0.3010606@gmail.com>
	 <5718B244.3020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:46903 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751008AbcDULiF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 07:38:05 -0400
In-Reply-To: <5718B244.3020201@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Matthias,

On Thu, 2016-04-21 at 12:58 +0200, Matthias Brugger wrote:
> 
> On 21/04/16 12:26, Matthias Brugger wrote:
> >
> >
> > On 02/09/15 19:23, Matthias Brugger wrote:
> >>
> >>
> >> On 02/09/15 08:45, Daniel Kurtz wrote:
> >>> Matthias,
> >>>
> >>> On Fri, Aug 28, 2015 at 10:06 PM, Rafael J. Wysocki
> >>> <rjw@rjwysocki.net> wrote:
> >>>> On Wednesday, August 26, 2015 02:53:39 PM Pi-Cheng Chen wrote:
> >>>>> On Wed, Aug 26, 2015 at 10:16 AM, Viresh Kumar
> >>>>> <viresh.kumar@linaro.org> wrote:
> >>>>>> On 26-08-15, 09:25, Pi-Cheng Chen wrote:
> >>>>>>> The [3/3] is based on Mediatek SoC maintainer tree[1] and the
> >>>>>>> patch which
> >>>>>>> introduce a new clock type[2] consumed by MT8173 cpufreq driver.
> >>>>>>> So it will
> >>>>>>> cause some conflicts if it goes through your tree. I am not sure
> >>>>>>> how this
> >>>>>>> should be handled, but should it be merged through Mediatek SoC
> >>>>>>> maintainer
> >>>>>>> tree?
> >>>>>>
> >>>>>> Just get that applied to MTK tree, it doesn't have any dependency on
> >>>>>> rest of the patches for build/boot. The only thing is that cpufreq
> >>>>>> wouldn't work and it will work as soon as Rafael's and MTK's trees
> >>>>>> are
> >>>>>> merged by Linus.
> >>>>>
> >>>>> Thanks for your explanation.
> >>>>>
> >>>>> @Rafael, Would you please apply [1,2] to your tree?
> >>>>
> >>>> Applied, thanks!
> >>>
> >>> Can you please apply [3] from this set to your dts tree?
> >>>
> >>
> >> I will as soon as v4.3-rc1 shows up.
> >
> > I somehow forgot this patch. Sorry for that.
> > Applied for v4.6-next/dts64 right now.
> >
> 
> I just realized that CLK_INFRA_CA53SEL and CLK_APMIXED_MAINPLL are not 
> part of the clk driver.
> 
> Pi-Cheng, can you check if they got renamed in the meanwhile? Or do we 
> need some clock driver patches that enable this clocks for the series?
> 

Thanks your notice. Unfortunately, we still have no chance let patch
with these two clock merged. The last version is [1]. This clock patch
will block cpufreq dts [2] and dynamic power dts [3]. Clock maintainer
is working on new architecture [4], hopefully we can send new clock
patch soon. After that, we will send new cpufreq and dynamic power dts.
So please ignore [2] [3] at this moment. 

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/369737.html
[2] https://lkml.org/lkml/2015/7/9/206
[3]
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/423899.html
[4]
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/418796.html

Eddie
Thanks


