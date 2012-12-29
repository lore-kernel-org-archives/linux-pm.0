From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH] Fix problem with cpufreq_pndemand or cpufreq_conservative
Date: Sat, 29 Dec 2012 01:33:41 +0100
Message-ID: <20121229003341.GA30982@balto.lan>
References: <50DE1A74.4040607@lwfinger.net>
 <3226192.H2BxHSuKio@vostro.rjw.lan>
 <50DE2F32.1010207@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50DE2F32.1010207@lwfinger.net>
Sender: cpufreq-owner@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, viresh kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 28, 2012 at 05:45:54PM -0600, Larry Finger wrote:
> >I wonder if that's avoidable?  The intention is not to create an additional
> >module, clearly.
> 
> It appears not to be possible. I don't know enough about to kmake to
> understand why it is forcing a new module. Perhaps some expert knows
> what Kconfig or Makefile magic will prevent that.

kbuild is building an additional module just because the makefile is
adding the new objects in the obj-m list directly, as in:

obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)     += cpufreq_ondemand.o cpufreq_governor.o
obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE) += cpufreq_conservative.o cpufreq_governor.o

To build just two modules the Makefile would have to be modified [1]
into something into something like:

obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)     += cpufreq_ondemand_mod.o
cpufreq_ondemand_mod-y                  := cpufreq_ondemand.o cpufreq_governor.o
obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE) += cpufreq_conservative_mod.o
cpufreq_conservative_mod-y              := cpufreq_conservative.o cpufreq_governor.o

so that only two .o are added to obj-m, but that's not correct either as
you end up with cpufreq_governor symbols exported twice.

I think the only way would be to force cpufreq_governor as builtin with
an automatic Kconfig option.

Fabio

1. http://lxr.linux.no/#linux+v3.7.1/Documentation/kbuild/makefiles.txt#L191

-- 
Fabio Baltieri
