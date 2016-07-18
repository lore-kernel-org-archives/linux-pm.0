From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: cpufreq: Intel P state driver: add cycle counter for clock frequency monitoring
Date: Mon, 18 Jul 2016 23:46:37 +0200
Message-ID: <1598804.AtLo7zN835@vostro.rjw.lan>
References: <66b88042-0f03-893b-33ac-c4e6df17534c@osadl.org> <1468859382.13661.167.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63496 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751451AbcGRVlp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2016 17:41:45 -0400
In-Reply-To: <1468859382.13661.167.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Carsten Emde <C.Emde@osadl.org>
Cc: Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM mailing list <linux-pm@vger.kernel.org>

On Monday, July 18, 2016 09:29:42 AM Srinivas Pandruvada wrote:
> Hi Carsten,
> 
> On Sun, 2016-07-17 at 23:51 +0200, Carsten Emde wrote:
> > Most cpufreq drivers contain an interface to the cpufreq_stats plugin
> > that counts the time the processor stays in a given P state. The
> > Intel P
> > state driver, however, does not work on discrete P states but allows
> > to
> > run the processor at arbitrary clock frequencies within the allowed
> > range. Even if the frequencies were reduced to steps of 100 MHz, this
> > would result in too many P states.
> This is true even using acpi-cpufreq driver on Intel x86 processors for
> a while. Due to HW coordination, power limits, TDP the requested P
> state may not be honored for a given CPU. The stats shows, P states
> which are just requests.
> 
> 
> >  This patch, therefore, introduces the
> > additional cpufreq variable kcycles that contains the number of clock
> > cycles divided by 1000 since the most recent reboot. This allows to
> > monitor the average clock frequency during a defined time interval by
> > simply calculating the derivative. 
> Can you not use turbostat?

Let alone turbostat, but I wonder what is wrong with using the cpu_frequency
tracepoint?

powertop is able to use it, so anyone else can do that as well.

Thanks,
Rafael

