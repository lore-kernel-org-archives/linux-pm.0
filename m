From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 4/6] ARM64: cpuidle: Rename cpu_init_idle to a common
 function name
Date: Sun, 15 Mar 2015 16:26:08 +0000
Message-ID: <20150315162608.GA21176@e102568-lin.cambridge.arm.com>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 <1425385777-14766-5-git-send-email-daniel.lezcano@linaro.org>
 <20150313182246.GT30671@e104818-lin.cambridge.arm.com>
 <20150314114109.GB9696@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150314114109.GB9696@e104818-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 14, 2015 at 11:41:09AM +0000, Catalin Marinas wrote:
> On Fri, Mar 13, 2015 at 06:22:46PM +0000, Catalin Marinas wrote:
> > On Tue, Mar 03, 2015 at 01:29:35PM +0100, Daniel Lezcano wrote:
> > > diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> > > index 0cea244..6ef291c7 100644
> > > --- a/drivers/cpuidle/cpuidle-arm64.c
> > > +++ b/drivers/cpuidle/cpuidle-arm64.c
> > > @@ -110,7 +110,7 @@ static int __init arm64_idle_init(void)
> > >  	 * idle states suspend back-end specific data
> > >  	 */
> > >  	for_each_possible_cpu(cpu) {
> > > -		ret = cpu_init_idle(cpu);
> > > +		ret = arm_cpuidle_init(cpu);
> > 
> > Same nitpick here about dropping the arm_ prefix (though here we already
> > have a cpuidle_init).
> 
> Actually, a question, probably for Lorenzo - why do we need to call
> cpu_init_idle() from the driver? Is there any dependency on what the
> driver had done before this call? If not, I suggest a core_initcall() in
> the arch code for cpu_init_idle(). At a quick look through the code, the
> back-end can be initialised on its own.

Because we want to register the driver if and only if both the generic
idle states parsing AND the back-end initialization succeed. If we move
the cpu_init_idle() to a core initcall() we still need a way to probe
if the back end initialization succeeded or not, we do not want to
have a driver initialized with back-end calls that fail.

It is also so, because we must guarantee the idle index mapping between
generic driver and the back end, if either initialization fails, the
driver should not be registered.

At the moment the driver is very similar to the x86 generic driver,
which is a good thing for consistency; by the way x86 driver prefixes
the function names with "intel_", I am not too fussed about the
functions naming scheme, open to suggestions.

Lorenzo
