From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420, and
 5422
Date: Thu, 3 Dec 2015 11:35:27 +0530
Message-ID: <20151203060527.GH4302@ubuntu>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>, Sudeep Holla <Sudeep.Holla@arm.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Ben,

On 02-12-15, 22:19, Ben Gamari wrote:
> 
> This patch series adds cpufreq support for the Exynos 5800, 5420, and 5422
> SOCs. In particular, it adds support for operating-points-v2 bindings to the
> arm-big-little cpufreq driver and updates the above-mentioned SOCs' devicetrees
> to take advantage of this support. There are also a couple of patches improving
> the clarify of the arm-big-little implementation. It is built on a set posted
> by Bartlomiej Zolnierkiewicz in April 2015.
> 
> The most signficant change from the original series is porting to the
> operating-points-v2 devicetree bindings. The series has been tested by me on
> and Odroid XU4 and by Javier Martinez Canillas on a Peach Pit.

Thanks for working with opp-v2 bindings, really appreciate it.

But, before I start reviewing this series, I have few comments.
- We weren't able to use cpufreq-dt driver for big LITTLE platforms
  earlier, as it never had multi cluster support and we wanted
  clock-sharing information via DT.
- That is all fixed now.
- I want Samsung's big LITTLE platforms to use cpufreq-dt and drop
  arm_big_little driver completely.
- The only case for which it (arm_big_little) driver might be useful
  is the IKS solution. Which I don't believe you are going to use in
  future :)

My plan for the arm-big-little driver:
- Migrate all platforms to use cpufreq-dt instead for non-IKS
  solution
- Make arm-big-little driver arm-big-little-iks only driver.

@Sudeep: What would it take you to use cpufreq-dt for ARM's platforms
?

-- 
viresh
