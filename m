From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 02/04] Driver Core: Add idle and wakeup
	functions
Date: Wed, 10 Jun 2009 10:19:37 +0200
Message-ID: <200906101019.38159.rjw__16379.3081803762$1244622088$gmane$org@sisk.pl>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<200906100141.38833.rjw@sisk.pl>
	<aec7e5c30906092303k6d61279fl4bf55184e932a876@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30906092303k6d61279fl4bf55184e932a876@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 10 June 2009, Magnus Damm wrote:
> On Wed, Jun 10, 2009 at 8:41 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> > On Tuesday 09 June 2009, Magnus Damm wrote:
> >> On Sat, Jun 6, 2009 at 5:42 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> >> > On Friday 05 June 2009, Magnus Damm wrote:
> >> >> On Wed, Jun 3, 2009 at 6:05 PM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> >> >> > On Friday 29 May 2009, Magnus Damm wrote:
> >> >> >> 2009/5/29 Rafael J. Wysocki <rjw@sisk.pl>:
> >> >> >> > On Wednesday 27 May 2009, Magnus Damm wrote:
> >> >> >> >> From: Magnus Damm <damm@igel.co.jp>
> >> >> >> >>
> >> >> >> >> Add platform_device_idle() and platform_device_wakeup()
> >> >> >> >> and allow architectures to implement their own versions
> >> >> >> >> of these if CONFIG_HAVE_PLATFORM_IDLE_WAKEUP is set.
> >> >> >> >>
> >> >> >> >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> >> >> >> >> ---
> >>
> >> >> The wakeup()/idle() code in this patch is one way to solve it on a
> >> >> platform device level. Another more generic way would be to add
> >> >> ->enable() and ->disable() callbacks to struct bus_type and introduce
> >> >> device_enable() and device_disable() that takes struct device and
> >> >> invokes the bus callbacks if set.
> >> >
> >> > So, you need a generic mechanism that drivers can use to notify the bus type
> >> > code that a device is idle and therefore it should schedule an autosuspend
> >> > request for the device.  Also, you want a mechanism by which drivers can notify
> >> > the platform code that there is a need to wake-up an autosuspended device.
> >> > Is that correct?
> >>
> >> Yes, you are 100% correct that I want drivers to have some way to
> >> notify the bus type that a certain device is idle or needs to be woken
> >> up.
> >>
> >> Exactly what should happen when the device is marked as idle is a
> >> different question. I guess this is bus specific. Connecting the idle
> >> notification directly to autosuspend is not a very good idea IMO since
> >> the power management comes with latency restrictions.
> >>
> >> If we zoom out a bit then I think that we should have something
> >> similar to cpuidle but for devices. Maybe the driver should give a
> >> list of suspend modes, their latencies and power savings. This per
> >> driver (or per device) latency information is important, but even more
> >> important IMO is latency information for the bus itself.
> >>
> >> So for our on-chip SuperH SoC platform devices I'd like to keep track
> >> of which devices that are idle, and if all devices within one power
> >> domain are idle then i'd like to execute autosuspend() for those and
> >> after that power off the bus/domain. But only if this doesn't break
> >> any latency requirements.
> >
> > OK, I think we can add ->idle() and ->wakeup() callbacks to struct bus_type
> > for this purpose.
> 
> Sounds very good! So unless there are any objections I'll just post a
> "Driver Core: Add idle and wakeup functions V2" which adds ->idle()
> and ->wakeup() callbacks to struct bus_type together with inline asm
> functions device_idle() and device_wakeup().

Well, I'd prefer to do that along with my run-time PM patch that is currently
being discussed with Alan and Oliver (I've sent a Cc of the first message
in that thread to you).

> > BTW, I'm waiting for a new version of your patch adding the arch data to
> > struct platform_device with a better changelog.
> 
> Yeah, sorry about the delay. I will post an updated version!

Great, thanks!

Best,
Rafael
