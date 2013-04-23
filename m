From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 2/6] thermal:exynos4: TMU Common clock framework support
 for TMU (Thermal Monitoring Unit)
Date: Tue, 23 Apr 2013 10:06:47 +0200
Message-ID: <20130423100647.20d80c73@amdc308.digital.local>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
 <1366389493-8239-3-git-send-email-l.majewski@samsung.com>
 <CAK9yfHxWq5CrhY=A2HMZnH3SQww2sPTBM_zQ9hoinyk1zger7g@mail.gmail.com>
 <20130423081724.03b3b422@amdc308.digital.local>
 <CAK9yfHwx_3Lkt_xnzttvBK=0xGqdxL+f=QfdYjuo3mHV8NtNQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:28258 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab3DWIHI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 04:07:08 -0400
In-reply-to: <CAK9yfHwx_3Lkt_xnzttvBK=0xGqdxL+f=QfdYjuo3mHV8NtNQA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>

Hi Sachin,

> Hi Lukasz,
> 
> On 23 April 2013 11:47, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
> > Hi Sachin,
> >
> >> On 19 April 2013 22:08, Lukasz Majewski <l.majewski@samsung.com>
> >> wrote:
> >> > This patch modifies exynos_thermal.c file to use
> >> > clk_disable_unprepare() and clk_prepare_enable() instead of
> >> > clk_{enable|disable}.
> >> >
> >> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> >> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> > ---
> >>
> >> I have already submitted a similar patch for this:
> >> http://permalink.gmane.org/gmane.linux.power-management.general/33310
> >>
> >>
> >
> > Thanks for pointing to the correct patch.
> >
> > However, I've got a question:
> >
> > The patch only changes clock names at exynos_tmu_{probe|remove}.
> >
> > Correct me if I'm wrong, but shouldn't we also change clock_enable
> > to clk_prepare_enable at exynos_tmu_read()? (Are we guaranteed,
> > that we will NOT sleep there?)
> 
> Since clk_prepare does not do anything, i thought it was sufficient to
> have it once in probe and then unprepare in remove.
> Do you see a real problem in this implementation. If so I can update
> it to use clk_prepare_enable at other places as well.
> 
I just wanted to stick to the common clock new API. It seems to me that
exynos_tmu_read() might sleep, but I'm quite novice at TMU :-).

If yours patches work, then we shall apply them.

I will do my best to test yours three patches ASAP on my setup.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Poland (SRPOL) | Linux Platform Group
