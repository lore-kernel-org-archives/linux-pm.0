From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420, and
 5422
Date: Thu, 3 Dec 2015 16:54:46 +0530
Message-ID: <20151203112446.GD2097@ubuntu>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
 <20151203060527.GH4302@ubuntu>
 <566021E2.6070000@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <566021E2.6070000@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ben Gamari <ben@smart-cactus.org>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

On 03-12-15, 11:05, Sudeep Holla wrote:
> The main difference is that we get the OPPs from the firmware rather
> than DT. We may just need to abstract that part and we should be able to
> use it. I will have a look at it and get back to you will more details.
> It has been a while since I looked at cpufreq-dt.

I forgot that :( .. but we can then create OPPs at runtime based on
what's available from firmware. And we also have an API now to set
which CPUs share OPPs... so that might be used as well..

-- 
viresh
