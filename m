From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 1/2] cpufreq: exynos4x12: Use the common clock framework to
 set APLL clock rate
Date: Wed, 25 Sep 2013 15:10:22 +0200
Message-ID: <20130925151022.74df54a7@amdc308.digital.local>
References: <1380108138-30402-1-git-send-email-l.majewski@samsung.com>
 <1380108138-30402-2-git-send-email-l.majewski@samsung.com>
 <CAK9yfHzb8VA+E38iQ3b31Yjfd9BvKcEMBc_gijJ3hERa_fBqFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17385 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289Ab3IYNKg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 09:10:36 -0400
In-reply-to: <CAK9yfHzb8VA+E38iQ3b31Yjfd9BvKcEMBc_gijJ3hERa_fBqFw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

Hi Sachin,

> Hi Lukasz,
> 
> On 25 September 2013 16:52, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
> >
> >  static void exynos4x12_set_apll(unsigned int index)
> >  {
> > -       unsigned int tmp, pdiv;
> > +       unsigned int tmp, freq = apll_freq_4x12[index].freq;
> 
> nit: It is better to put the 'freq' assignment on a new line.

checkpatch.pl wasn't complaining :-).
Also please consider below comment.

> 
> >
> > -       /* 1. MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
> > +       /* MUX_CORE_SEL = MPLL, ARMCLK uses MPLL for lock time */
> >         clk_set_parent(moutcore, mout_mpll);
> >
> >         do {
> > @@ -140,24 +140,9 @@ static void exynos4x12_set_apll(unsigned int
> > index) tmp &= 0x7;
> >         } while (tmp != 0x2);
> >
> > -       /* 2. Set APLL Lock time */
> > -       pdiv = ((apll_freq_4x12[index].mps >> 8) & 0x3f);
> > +       clk_set_rate(mout_apll, freq * 1000);
> 
> Don't we need to check the return value of this?

The broken code isn't handling errors now (*_set_apll() function is
defined as void). Since this patch is a regression fix (for v3.12) I
just wanted to change as little as possible to provide a functional fix.

I think that regression fix shall not change much functionality -
therefore the exynosXXXX-cpufreq.c cleanup will be done for next kernel
release.

> 
> Same comments for the second patch too.
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
