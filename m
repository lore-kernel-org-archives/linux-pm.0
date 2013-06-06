From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 5/5] cpufreq:boost:Kconfig: Enable boost support at Kconfig
Date: Thu, 06 Jun 2013 17:14:31 +0200
Message-ID: <20130606171431.41d63591@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1370502472-7249-6-git-send-email-l.majewski@samsung.com>
 <20130606144910.GA1194@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <20130606144910.GA1194@redhat.com>
Sender: cpufreq-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Dave,

> On Thu, Jun 06, 2013 at 09:07:52AM +0200, Lukasz Majewski wrote:
> 
>  > +config CPU_FREQ_BOOST
>  > +	bool "CPU frequency boost support"
>  > +	help
>  > +	  Switch to enable support for frequency boost
>  > +
>  > +	  If in doubt, say N.
>  > +
> 
> This help text is devoid of any useful information.
> 
> On what platforms ? What's the upside/downside ? Why is it an option ?

I shall be more verbose here.

The boost option is supposed to provide one solution to control
software based (like is is done with Samsung Exynos4 SoC) and hardware
based (like Intel's Turbo Boost feature) boost.

Support for Intel's boost is already in mainline. Therefore I aimed to
extend cpufreq to also manage software based solutions (e.g. Exynos).


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
