From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC 0/3] Runtime PM support for named power states
Date: Wed, 5 Oct 2005 03:44:45 -0400
Message-ID: <20051005074445.GB3306@neo.rr.com>
References: <Pine.LNX.4.44L0.0509301536560.4470-100000@iolanthe.rowland.org>
	<20051005060435.628B0EA5EC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============39572862324284908=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051005060435.628B0EA5EC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============39572862324284908==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 04, 2005 at 11:04:35PM -0700, David Brownell wrote:
> > Although it may not show up very clearly, these patches -- especially the 
> > first -- are running up against the limitations and bad design choices 
> > originally made for the PM core.
> 
> I think some parts just "grew"; not everything was "designed".  :)
> 
> 
> > Particularly vexing was the use of a pm_message_t to store a device's
> > current state.  The event field in pm_message_t doesn't represent a power
> > state; it represents a _reason_ for a state transition.  Nevertheless, the
> > current code insists on using it to identify states.
> 
> I suspect only driver code should ever care about device states.

I agree.  I'm not sure if we should represent physical device states
specifically.  For most PCI devices, the device is either on (D0) or
off (D1-D3).  D1-D3 are often determined by which wake capabilities have
been enabled.  Therefore, it seems reasonable to tell the driver to turn
off the device and let it figure out which state would meet all of the
wake constraints.  In other words, the ability to specify the exact D-state
isn't especially useful.

Some drivers may want to allow userspace to have more direct control of
their power states.  They can create sysfs attributes to allow for this
sort of device-specific control.

> 
> The PM core should just tell drivers to become compatible with some
> new constraint (like ACPI S3, generally implying devices in PCI D2
> or D3; while S1 doesn't) ... and not worry about whether that involves
> a state change or not.
> 
> Maybe they're already _in_ that state for example.

Yeah, the thought occurred to me.  One way of approaching the problem is to
have the PM core use logical states such as the following:

1.) ON
2.) FREEZE
3.) SUSPEND

others?

This is similar to our current implementation.

Device drivers would be responsible for watching physical device states like
D0, D1, etc.  Some devices might have rather complex power management options
and may contain several physical states.  This doesn't mean the standard PM
code can't provide libraries to make this device state tracking easier for
most drivers.

> 
> 
> > Finally, there's no obvious mapping between the PM_EVENT_FROZEN and 
> > PM_EVENT_SUSPENDED values and the new named states.  Obviously devices 
> > will be left in _some_ state, but the PM core can't tell which.
> 
> The PM core shouldn't need to care.  If the driver is in a state
> compatible with that message, all is fine; the driver should be
> able to ignore the message.
> 
> That said, there's still confusion between FREEZE (which seems
> more like a "standby" with focus on quick time to full-ON) and
> SUSPEND (which for spinning up a disk would take part of a minute
> to get back to full-ON).

My understanding is as follows:

FREEZE:
-stop device operation
-free interrupts, stop timers, etc.

SUSPEND:
-call FREEZE if not frozen.
-physically power down the device

In other words, FREEZE avoids changing power states.

Thanks,
Adam

--===============39572862324284908==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============39572862324284908==--
