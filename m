From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 3/7] cpufreq-dt: add turbo modes support
Date: Mon, 27 Jul 2015 13:01:43 +0200
Message-ID: <15810554.2OjPyuYJBt@amdc1976>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-4-git-send-email-b.zolnierkie@samsung.com>
 <20150727083754.GD31611@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:54440 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbbG0LCU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 07:02:20 -0400
In-reply-to: <20150727083754.GD31611@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


Hi,

On Monday, July 27, 2015 02:07:54 PM Viresh Kumar wrote:
> On 09-07-15, 17:43, Bartlomiej Zolnierkiewicz wrote:
> > diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
> > index 0414009..483ca1b 100644
> > --- a/include/linux/cpufreq-dt.h
> > +++ b/include/linux/cpufreq-dt.h
> > @@ -17,6 +17,7 @@ struct cpufreq_dt_platform_data {
> >  	 * clock.
> >  	 */
> >  	bool independent_clocks;
> > +	bool boost_supported;
> >  };
> 
> I am planning to kill this structure soon, don't add anything to it.
> We should be doing this based on DT.

This change was in the original patch posted in April:
https://lkml.org/lkml/2015/4/10/646

your review from a month ago didn't contain this request:
https://lkml.org/lkml/2015/6/22/667

and now (after nearly 4 months) you are telling me that
I should change this because you are planning to do some
more changes in the future.

Could we please keep it as it is for now and change it
later (after independent_clocks configuration will get
ported to use device tree)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

