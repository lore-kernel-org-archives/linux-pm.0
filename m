From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420, and
 5422
Date: Thu, 3 Dec 2015 16:07:03 +0530
Message-ID: <20151203103703.GC2097@ubuntu>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
 <20151203060527.GH4302@ubuntu>
 <877fkv4ylk.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <877fkv4ylk.fsf@smart-cactus.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

On 03-12-15, 11:26, Ben Gamari wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> > But, before I start reviewing this series, I have few comments.
> > - We weren't able to use cpufreq-dt driver for big LITTLE platforms
> >   earlier, as it never had multi cluster support and we wanted
> >   clock-sharing information via DT.
> 
> Fair enough.
> 
> > - That is all fixed now.
> 
> I did not see any mention of this in the cpufreq-dt driver binding
> documentation, otherwise I would have tried going this route.
> 
> Do you have any references? I'd be happy to examine what would be
> necessary to go this route although, being an independent contributor,
> it may take time.

You wouldn't find in cpufreq-dt documentation as its not specific to
that. I have seen you DT patches now, and you have created the OPP
tables mostly correctly. Just create the cpufreq-platform device for
cpufreq-dt instead of arm-big-little one. And it should just work.

> > - I want Samsung's big LITTLE platforms to use cpufreq-dt and drop
> >   arm_big_little driver completely.
> 
> That sounds like a great direction going forward. However, I would still
> kindly request that you consider this series.
> 
> The existence of future plans of course does not change the fact that
> users have real hardware today; hardware that they have spent money on
> and would like to use. Cpufreq support has already been deferred once
> for similar reasons of interface churn which essentially forestalled
> working functionality from entering the kernel by eight months; I'd
> really like to avoid having this happen again.

I am not talking about any future plans here that need some work to be
done. Its all working today, you just need to use a different driver.

> Sounds reasonable to me. However, I'd just like to reiterate that this
> line of work can be pursued independently from the upstreaming of this
> series.

I think this is the right time to upstream the right solution. Just
try it once, if you face lots of difficulties or issues, then we can
ofcourse see..

NOTE: Check how OPP nodes are required to be created now in
linux-next. They should be named like opp@<freq-hz>. Something I
noticed in your DTs.

-- 
viresh
