From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Mon, 4 Feb 2013 16:05:11 +0100
Message-ID: <20130204150511.GF13909@pd.tnic>
References: <5808458.pvV2iHpBWm@vostro.rjw.lan>
 <CAKohpok7RiJ_HKGi3r0vU26kNEtFKq==pMMoshT6Z2yy9ghemA@mail.gmail.com>
 <20130204123221.GA22340@pd.tnic>
 <CAKohpomcrtV3i9fL4zV6Mt0uDza-9pHTOsqTe2=C1t6mE6cpCQ@mail.gmail.com>
 <20130204130403.GD13909@pd.tnic>
 <CAKohpokuFC5gnTFcD3+RH3p5XaW8vBtyfq+Kej=d2J8tERdmoQ@mail.gmail.com>
 <20130204133648.GE13909@pd.tnic>
 <CAKohpo=aLnhM0Op_32ohWZK5eG5nT7iK0OktBe+8ygOQW7zUqQ@mail.gmail.com>
 <20130204140908.GC15452@pd.tnic>
 <CAKohpokowK6ybYd8aDUdfFYsnzoc5VAKsuPSkfxoDqJ3k+FwGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpokowK6ybYd8aDUdfFYsnzoc5VAKsuPSkfxoDqJ3k+FwGA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 04, 2013 at 07:51:33PM +0530, Viresh Kumar wrote:
> We correlate things with cpus rather than policies and so the current
> directory structure of cpu/cpu*/cpufreq/*** is the best suited ones.

Ok, show me the details of that layout. How is that going to look?

One thing I've come to realize with the current interface is that if
you want to change stuff, you need to iterate over all cpus instead of
writing to a system-wide node.

And, in this case, if you can and need to change the policy per
clock-domain, I wouldn't make it needlessly too-granulary per-cpu.

That's why I'm advocating the cpu/cpufreq/ path.

> Yes, and that's why cpu/cpu*/cpufreq/ondemand/*** suits the best, with
> exactly the same logic that went for P-states or cpufreq-stats.

See above.

> Hmm.. confused..
> Consider two systems:
> - A dual core system, with cores sharing clocks.
> - A dual cluster system (dual core per cluster), with separate clocks
> per cluster.
> 
> Where will you keep governor directories for both of these configurations?

Easy: as said above, make the policy granularity per clock-domain. On
systems which have only one set of P-states - like it is the case with
the overwhelming majority of systems running linux now - nothing should
change.

> We need to select only one... cpu/cpufreq doesn't suit the second case
> at all as we need to use ondemand governor for both the clusters but
> with separate tunables. And so a single cpu/cpufreq/ondemand directory
> wouldn't solve the issue.

Think of it this way: what is the highest granularity you need per
clock-domain? If you want to control the policy per clock-domain, then
cpu/cpufreq/ is what you want. If you want finer-grained control -
and you need to think hard of what use cases are sensible for that
finer-grained solution - then you're better off with cpu/cpu*/ layout.

In both cases though, having clear examples of why you've come up with
the layout you're advocating would help reviewers a lot. If you simply
come and say we need this because there might be systems out there who
could use it, then that probably is not going to get you that far.

HTH.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
