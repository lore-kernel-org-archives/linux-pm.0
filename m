From: David Brownell <david-b@pacbell.net>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Sun, 23 Jul 2006 09:22:29 -0700
Message-ID: <200607230922.29824.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0607222334510.10239-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0607222334510.10239-100000@netrider.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 22 July 2006 8:59 pm, Alan Stern wrote:
> On Sat, 22 Jul 2006, David Brownell wrote:
> =

> > In short that's kind of a mess.  IMO the correct approach involves remo=
ving
> > the dev->power.power_state thing entirely, along with the sysfs thing, =
but
> > we can't do that quite yet.
> =

> Then what _can_ we do now?  Or better yet, what _should_ we aim towards
> doing?  I'm perfectly happy to have those things removed, but what (if
> anything) should take their place?

Remove both, replace with nothing generic ... my $US 0.02.  You will
have noticed the patch I sent to add a config option to remove the
/sys/devices/.../power/state files; that can start phasing out soon.
Removing power_state can be done over time.

Some busses could provide bus-specific replacements ... PCI and USB,
not I2C or SPI, as examples.  I can't really argue any reason to make
such a replacement though, other than for testing.


> Some simple questions may help start the ball rolling.  During a system
> resume, should all devices be powered on full, or should they be restored
> to the state they were in before the suspend? =


I'd say the answer is bus- or driver-specific, but lean towards the latter.
Though it's not clear how the PM core could tell about runtime states, since
I also think those should be driver-internal ... so how could anyone tell
the difference?

And for that matter, what is a "system resume" on systems that aren't
as simple as PCs?  E.g. when there are multiple run modes, there's
no reason to expect the post-resume mode to be the same as the pre-suspend
one and thus have e.g. the same clocks and voltages available ... neither
"all on full" nor "all on as before suspend" make sense everywhere.


> Or should there be a third =

> possibility -- maybe some devices always on, others the way they were?  =

> And who decides?  The driver?

A given system should be able to provide the answer appropriate for
its applications.  Example, if it's woken up by a given device, maybe
that's the only non-system device that _needs_ to be activated ...

 =

> For that matter, to what extent does the PM core need to be involved in
> runtime power management?

Hardly at all, in my book.  As I wrote in that revised devices.txt...
see that for more info.  (That's written to reflect the status quo.)
Different problem domains can have their own hooks ... there's not a
lot of really generic stuff, since the problem domains are so varied.


> As far as I can see, all the core can do is =

> provide centralized routines that would be widely useful.  But apart from
> something resembling the current sysfs interface, I can't see what those
> routines might do.

See above ... I consider the current /sys/devices/.../power/state interface
irredeemably broken.  Which leaves nothing generic enough for the core, at
least in terms of mechanisms needed/used by Linux today. =


- Dave
