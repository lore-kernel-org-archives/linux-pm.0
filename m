From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Tue, 4 May 2010 22:23:41 +0200
Message-ID: <201005042223.41370.rjw@sisk.pl>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<20100504135907.GA3651@opensource.wolfsonmicro.com>
	<87r5lrh780.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87r5lrh780.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Arve@smtp1.linux-foundation.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 04 May 2010, Kevin Hilman wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
> =

> > On Mon, May 03, 2010 at 05:43:34PM -0700, Brian Swetland wrote:
> >> On Mon, May 3, 2010 at 5:09 PM, Arve Hj=F8nnev=E5g <arve@android.com> =
wrote:
> >> > On Mon, May 3, 2010 at 4:37 PM, Kevin Hilman
> >
> >> >> This last point is especially troubling.  I don't find it a comfort=
ing
> >> >> path to go down if the drivers have to start caring about which PM
> >> >> policy is currently in use.
> >
> >> I'll echo Arve here -- all drivers should seek to be in the lowest
> >> power state possible at all times.  We've never suggested that
> >> suspend_block is a substitute for that.
> >
> > Looking at this from a subsystem/driver author point of view the problem
> > I'm faced with is that as a result of using system suspend much more
> > aggressively the subsystem and driver layers are getting conflicting
> > instructions about what the lowest power state possible is.
> =

> Exactly.
> =

> With runtime PM, there is flexibility in choosing the lowest power
> state at the device/subsystem level, based on activity, timeouts,
> bitrate, dependencies, latency/throughput constraints, etc.
> =

> With opportunistic suspend, all of this flexibility is gone, and the
> device/subsystem is told to go into the lowest power, highest latency
> state, period.

Guys, please.

The opportunistic suspend feature is _not_ to replace runtime PM by any mea=
ns!

However, there are situations in which runtime PM is clearly insufficient.
The idea behind runtime PM is that subsystems and device drivers will know
when to put devices into low power states and save energy this way.  Still,
even if all subsystems do that 100% efficiently, there may be more savings
possible by putting the entire system into a sleep state (like on ACPI-based
PCs) and we can reach there by runtime PM alone.

> >> Suspend blockers give us some flexibility on systems where runtime pm
> >> will not get us all the way there. If you can meet your power needs
> >> without needing suspend blockers, awesome, you don't need them on that
> >> platform.  The patchset Arve sent out makes this feature an
> >> off-by-default kernel configuration option that compiles out to no-ops
> >> when disabled.
> >
> > I think a big part of this for me is that this approach changes the
> > intended use of the system-wide suspend a bit, complicating it a bit
> > further than it already is.  We end up doing a suspend (which in the
> > normal course of affairs means that the driver should shut everything
> > down) partly as a substitute for runtime PM on the core system devices
> > and partly because our runtime PM isn't doing as well as it should on
> > the individual devices.
> =

> Agreed, and because of this, part of my concern is that opportunistic
> suspend will take the place of doing the "right thing" which (IMHO) =

> would be to improve runtime PM for devices.

It really can't, at least on some platforms.  For example, resuming a PC
notebook from suspend to RAM takes more than 1s (with an SSD; rotational di=
sks
add more latency here) which is way too much for such a replacement.

Besides, there also is room for runtime PM in the Android framework, because
it needs to suspend certain devices without freezing processes, for example.

The freezing of processes is the most important difference to me.  Runtime =
PM
works with the assumption that processes are not frozen (hence the name), b=
ut
arguably energy savings you can get without going behind that point are
naturally limited.

> > I'd be a lot more comfortable with this if it came with a mechanism for
> > communicating the intended effect of a suspend on a per-device level so
> > that the drivers have a clear way of figuring out what to do when the
> > system suspends.  If there isn't one we can add subsystem or driver
> > specific hooks, of course, but it'd be better to address this at the
> > system level.
> =

> I agree.

I'm not sure.  Why _exactly_ would you need that?

> I think there needs to be more discussion on the indended usage
> of suspend blockers by drivers/subsystems, especially those PM aware
> drivers and subsystems already doing runtime PM with constraints etc.
> =

> >> In our experience, periodic timers and polling, both userspace side
> >> and kernelside make suspend blockers a win even on platforms like OMAP
> >> which have pretty flexible hardware power management.  Going to low
> >> power states in idle results in higher average power consumption than
> >> going to the same states in full suspend, at least on Android devices
> >> shipping today.
> >
> > There's definite work to be done here, yes.
> =

> And I've admitted this to be the only compelling reason for
> opportunistic suspend so far.
> =

> But the driver/subsystem implications of opportunistic suspend still
> need some fleshing out IMO.

At the moment, if you're not on Android, there are none.

Thanks,
Rafael
