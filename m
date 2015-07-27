From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
Date: Mon, 27 Jul 2015 17:06:41 +0530
Message-ID: <20150727113641.GB10181@linux>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1595601.YD6UTxy5Qg@amdc1976>
 <20150727103521.GA4103@linux>
 <3141301.RS9TLygaba@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3141301.RS9TLygaba@amdc1976>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 27-07-15, 13:14, Bartlomiej Zolnierkiewicz wrote:
> Sorry but you don't seem to understand the issue.

:)

No, I did. I understand that if someone uses opp bindings today with
some entries as turbo OPPs, cpufreq will use them as normal
frequencies. And that may harm the board.

BUT, opp-v2 code isn't ready to be used yet. And platforms should see
what all is implemented before trying to use them.

All I was saying is, this isn't a FIX as we haven't introduced the
feature yet. Otherwise I had no issues with the patch.

-- 
viresh
