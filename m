From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM QoS dynamic resource manager
Date: Thu, 17 Jun 2010 15:32:23 -0700
Message-ID: <87zkytffyg.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>
	<20100525145223.GA4974@gvim.org>
	<AANLkTikLgu2c1GPE3glHLlaznOM59SVeCj2NHzDjyjZR@mail.gmail.com>
	<20100608033333.GA23066@gvim.org>
	<AANLkTinGBvZm870CsjocsCV1SmQ-FCCbJLtKWR1juB1Q@mail.gmail.com>
	<4C0ECC38.2000003@codeaurora.org> <20100609030525.GD26668@gvim.org>
	<1276265566.8214.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276265566.8214.2.camel@localhost> (Kevin Hilman's message of
	"Fri\, 11 Jun 2010 19\:42\:46 +0530")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: mark gross <640e9920@gmail.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> On Tue, 2010-06-08 at 20:05 -0700, mark gross wrote:
>> On Tue, Jun 08, 2010 at 04:03:20PM -0700, Bryan Huntsman wrote:
>> > 
>> > Mike, one idea I'm exploring is having platform-specific busses with
>> > QoS constraints specified via runtime_pm as part of the LDM.  Adding
>> > dynamic class creation within pm_qos, or a type enum as you suggest,
>> > would work.  However, I think this kind of behavior would fit nicely
>> > within runtime_pm.
>> >
>> 
>> Something like that is what Kevin Hilman was thinking too.  It would
>> bring a qos concept to the LDM for each bus driver object.  
>
> Yes, I definitely have some thoughts/ideas in this direction and is what
> we are doing on OMAP.  I've been on the road, so I will chime in more on
> this next week when I get back...

[apologies for the delay, travel has made it difficult to keep up with mail]

So below is an overview of how we are managing device-specific
latency/throughput on OMAP.  We are currently managing in an
OMAP-specific way, but I certainly see the value in generalizing this
into something managed at the 'struct device' level.

So this is obviously being used for device-specific constraints, but
on OMAP, we're also modeling the internal bus(ses) as special
"omap_device(s)" and we use constraints the bus "devices" for
throughput.

Bryan mentioned aggregating the constraints up to some parent where
platform-specific decisions can be made, and I am totally in support
of that.  On OMAP, we're aggregating the device latency constraints at
the time of a device idle (triggered by pm_runtime_idle().)  More
details on that in the below overview.

It would be great if we could all get together at one of the
conferences this year to talk through some of our ideas in more
detail.  I plan to be at ELC Europe (October in UK) and Linux Plumbers
(Nov in Boston) with a remote possibility of making it to LinuxCon
(Aug in Boston, which includes a PM mini-summit on Monday.)


-------------------------------------------------------------------

What we currently have in OMAP is a layer called omap_device.  A
struct omap_device contains a platform_device which contains a struct
device.

In the omap_device layer, each omap_device tracks it's actual wakeup
latency and also has a configurable maximum wakeup latency.  Drivers
or subsystems can set and change the maximum wakeup latency
dynamically, and the actual wakeup latency can be manually set when
the omap_device is registered (based on HW specs), or can be
dyamically measured at runtime (since we know how reliable said HW
specs can be.)

On OMAP, drivers usage of runtime PM will eventually trickle down to
calling omap_device_enable() or omap_device_idle().  These calls in
the omap_device API make the final decisions based comparing the
actual and requested wakeup latencies.

For example, runtime_pm_idle() will eventually call omap_device_idle()
for an omap_device.  In omap_device_idle(), if the wakeup latency of
that device is less than the currently requested maximum, the
'deactivate' hook for that latency level is called (which leads to the
HW-level magic to disable that device at the HW level.)  And of
course, if the wakeup latency for that device is longer than the
currently requested maximum, the deactivate hooks is not called.
Similarily on enable, if the devices current wakeup latency already
meets the requested maximum, nothing needs to change.  If it doesn't
the 'activate' hook is called so that it can meet the requested
maximum.

Thats a brief summary, but is a bit of an oversimplification.  The
actual omap_device code supports multiple latency levels
per-omap_device.  In both the _enable() and _idle() paths, the various
levels are traversed until one is found which meets the maximum wakeup
latency requirements.

Why would a device want multiple per-device latency levels?  As an
simple example, one level might simply be disabling the devices
clocks.  Another might also disable the PLL generating those clocks.
Another might be turning off the voltage regulator supplying power to
that device, etc. etc.  For each latency level, there are
configurable, platform-specific, activate and deactivate hooks that
can be used to do the actual work.

I hope that helps explain things, and feel free to peruse the code.
It's currently in mainline and part of the OMAP arch-specific code:

   arch/arm/plat-omap/omap_device.c
   arch/arm/plat-omap/include/plat/omap_device.h

Kevin
