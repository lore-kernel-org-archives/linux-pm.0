From: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/4][V2] cpuidle : multiple drivers support
Date: Fri, 26 Oct 2012 11:23:58 +0300
Message-ID: <20121026082358.GD1962@tbergstrom-lnx.Nvidia.com>
References: <1350641449-22863-1-git-send-email-daniel.lezcano@linaro.org>
	<20121025134933.GA1962@tbergstrom-lnx.Nvidia.com>
	<4190590.cE8oL2xMlM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4190590.cE8oL2xMlM-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: "linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 25, 2012 at 10:29:43PM +0200, Rafael J. Wysocki wrote:
> On Thursday, October 25, 2012 04:49:33 PM Peter De Schrijver wrote:
> > On Fri, Oct 19, 2012 at 12:10:45PM +0200, Daniel Lezcano wrote:
> > > The discussion about having different cpus on the system with
> > > different latencies bring us to a first attemp by adding a
> > > pointer in the cpuidle_device to the states array.
> > > 
> > > But as Rafael suggested, it would make more sense to create a
> > > driver per cpu [1].
> > > 
> > > This patch adds support for multiple cpuidle drivers.
> > > 
> > > It creates a per cpu cpuidle driver pointer.
> > > 
> > > In order to not break the different drivers, the function cpuidle_register_driver
> > > assign for each cpu, the driver.
> > > 
> > > The multiple driver support is optional and if it is not set, the cpuide driver
> > > core code remains the same (except some code reorganisation).
> > > 
> > > I did the following tests compiled, booted, tested without/with CONFIG_CPU_IDLE,
> > > with/without CONFIG_CPU_IDLE_MULTIPLE_DRIVERS.
> > > 
> > > Tested on Core2 Duo T9500 with acpi_idle [and intel_idle]
> > > Tested on ARM Dual Cortex-A9 U8500 (aka Snowball)
> > > 
> > > V1 tested on Tegra3 and Vexpress TC2
> > > 
> > 
> > V2 tested on Tegra3.
> 
> Do I assume correctly that Tested-by applies?
> 

Yes.

Cheers,

Peter.
