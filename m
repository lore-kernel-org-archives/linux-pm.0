From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
Date: Mon, 27 Jul 2015 13:14:34 +0200
Message-ID: <3141301.RS9TLygaba@amdc1976>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1595601.YD6UTxy5Qg@amdc1976> <20150727103521.GA4103@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150727103521.GA4103@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Monday, July 27, 2015 04:05:21 PM Viresh Kumar wrote:
> On 27-07-15, 12:24, Bartlomiej Zolnierkiewicz wrote:
> > Have you read my explanation of the issue?
> > 
> > With your OPP-v2 patches cpufreq-dt picks turbo frequencies and uses
> > them as normal ones.
> > 
> > (More at: http://www.spinics.net/lists/arm-kernel/msg430397.html)
> 
> Yes I did. I understand that the turbo frequencies are not considered
> as such by OPP/cpufreq core and it requires your changes to get it
> working.

Sorry but you don't seem to understand the issue.

The problem is that without my patch and with your OPP-v2 patches
turbo frequencies get picked by OPP/cpufreq core and then by cpufreq-dt.
This happens without enabling any boost & thermal etc. support for
turbo frequencies.

> But its not an issue or bug we are fixing, the problem is that the
> code for opp-v2 isn't complete yet and your patches is putting things
> in place. So, we are still doing the bring up here and not fixing a
> bug really.

I consider the possibility to use turbo frequencies without explicitly
enabling boost support to be a buggy behavior.  While it is unlikely
that somebody defines turbo frequencies in their dts file in the near
future (except Exynos ones) it costs as nearly nothing to prevent
such behavior now.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
