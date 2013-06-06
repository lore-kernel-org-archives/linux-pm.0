From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 5/5] cpufreq:boost:Kconfig: Enable boost support at
 Kconfig
Date: Thu, 6 Jun 2013 11:21:04 -0400
Message-ID: <20130606152104.GA11015@redhat.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1370502472-7249-6-git-send-email-l.majewski@samsung.com>
 <20130606144910.GA1194@redhat.com>
 <20130606171431.41d63591@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130606171431.41d63591@amdc308.digital.local>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 06, 2013 at 05:14:31PM +0200, Lukasz Majewski wrote:
 > Hi Dave,
 > 
 > > On Thu, Jun 06, 2013 at 09:07:52AM +0200, Lukasz Majewski wrote:
 > > 
 > >  > +config CPU_FREQ_BOOST
 > >  > +	bool "CPU frequency boost support"
 > >  > +	help
 > >  > +	  Switch to enable support for frequency boost
 > >  > +
 > >  > +	  If in doubt, say N.
 > >  > +
 > > 
 > > This help text is devoid of any useful information.
 > > 
 > > On what platforms ? What's the upside/downside ? Why is it an option ?
 > 
 > I shall be more verbose here.
 > 
 > The boost option is supposed to provide one solution to control
 > software based (like is is done with Samsung Exynos4 SoC) and hardware
 > based (like Intel's Turbo Boost feature) boost.
 > 
 > Support for Intel's boost is already in mainline. Therefore I aimed to
 > extend cpufreq to also manage software based solutions (e.g. Exynos).

Given CPUFREQ is available on more platforms than X86/ARM, this option
could also use a depends.

	Dave

