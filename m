From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
Date: Mon, 27 Jul 2015 13:47:41 +0200
Message-ID: <2681271.3UazeZ9PAQ@amdc1976>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <3141301.RS9TLygaba@amdc1976> <20150727113641.GB10181@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20150727113641.GB10181@linux>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, July 27, 2015 05:06:41 PM Viresh Kumar wrote:
> On 27-07-15, 13:14, Bartlomiej Zolnierkiewicz wrote:
> > Sorry but you don't seem to understand the issue.
> 
> :)
> 
> No, I did. I understand that if someone uses opp bindings today with
> some entries as turbo OPPs, cpufreq will use them as normal
> frequencies. And that may harm the board.
> 
> BUT, opp-v2 code isn't ready to be used yet. And platforms should see
> what all is implemented before trying to use them.

OK.

> All I was saying is, this isn't a FIX as we haven't introduced the
> feature yet. Otherwise I had no issues with the patch.

I will update the description for the next patchset revision.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
