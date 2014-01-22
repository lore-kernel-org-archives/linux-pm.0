From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH RESEND] cpufreq: exynos: Fix build error of no type of
 module_init
Date: Wed, 22 Jan 2014 17:10:07 +0100
Message-ID: <1390407007.18340.13.camel@AMDC1943>
References: <1390400476-22951-1-git-send-email-k.kozlowski@samsung.com>
 <CAKohpo=2wR+Sqwxj4koH0rvuk29BkNyAZgN0RR7bVH+3uqpB1Q@mail.gmail.com>
 <1390402760.18340.6.camel@AMDC1943> <1390405030.18340.11.camel@AMDC1943>
 <52DFE7D9.5050001@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <52DFE7D9.5050001@windriver.com>
Sender: cpufreq-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene.kim@samsung.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2014-01-22 at 10:46 -0500, Paul Gortmaker wrote:
> On 14-01-22 10:37 AM, Krzysztof Kozlowski wrote:
> > 
> >>
> >> Hi,
> >>
> >> A little more explanation from my side: the build error actually happens
> >> only on next/master, not Linus' tree.
> >>
> >> Mentioned commit which changes the driver to platform driver is in
> >> mainline since 3.12-rc2 so it seems this is not the cause of the build
> >> error. I think I need to find first the real cause of this build error.
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > After bisecting, the real commit for build error is:
> > caa7dcde7c424cdc81698a6e4e48072eb67ec67e
> >     module: relocate module_init from init.h to module.h
> 
> Yep, even though I fixed a crap-tonne of implicit includes, and
> built all the arm configs, some were bound to sneak through.
> 
> I'll push a fix shortly to the init cleanup queue:
> 
>    http://git.kernel.org/cgit/linux/kernel/git/paulg/init.git/
> 
> so it will be fine for the next linux-next tree.

Thanks, the same issue applies to drivers/cpufreq/exynos-cpufreq.c.

Best regards,
Krzysztof

