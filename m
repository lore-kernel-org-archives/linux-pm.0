From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspended devices and drivers
Date: Tue, 6 Sep 2005 21:47:30 +0200
Message-ID: <200509062147.31349.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0509061037520.5078-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73904913430967079=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509061037520.5078-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: David Brownell <david-b@pacbell.net>
List-Id: linux-pm@vger.kernel.org

--===============73904913430967079==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Tuesday, 6 of September 2005 16:50, Alan Stern wrote:
> On Mon, 5 Sep 2005, David Brownell wrote:
> 
> > > With the USB device, things are more interesting.  If you unplug the
> > > device (even while it's not in use), Windows warns you not to do this
> > > without first getting permission by using the "Eject Removable Devices"
> > > button.  If you try to press that button while a program has a file open
> > > on the device, Windows says that you can't remove the device right now and
> > > advises you to try again later.
> > 
> > So it's inconsistent in behavior, since this isn't how it handles
> > the same thing during resume-from-hibernate ...
> 
> Obviously because Windows isn't aware of anything that happens during
> hibernate while the power is turned off.  How could it possibly warn you
> about unplugging a device when it doesn't know whether you unplugged the
> device or not?
> 
> If you describe the behavior as "Windows warns you whenever it learns that
> you ejected removable media without permission", then Windows _is_
> consistent.
> 
> > > However...  I put the laptop into Hibernate mode.  To be absolutely sure
> > > this was a true snapshot-poweroff-resume cycle, I also unplugged the power
> > > cord and removed the battery.  Then I removed and replaced the USB device
> > > and restarted the laptop.  Everything worked smoothly; the file remained
> > > open and the program was able to continue reading it, well past the point
> > > where the I/O buffers needed to be refilled.
> > 
> > So basically there's a special case somewhere to treat _this_ disconnect
> > differently than other ones.
> 
> Yes, there must be.
> 
> > How does real suspend behave (like STR)?  How does it handle cases where you
> > plug in a different instance of the same device ... example, different CF
> > card in a CF reader?  Or when you move the device to another port?  And
> > does XP behave identically?
> 
> I'll try doing some of those experiments when I have a chance.
> 
> > > If Windows ME can do this, Linux should be able to do it too.
> > 
> > That argument can be stretched too far!  Though from time to time I have
> > indeed wished for something more like a BSOD.  An oops hidden in a logfile
> > that never gets flushed to disk, with an X desktop, gives no clues ... :)
> > 
> > Linux certainly _could_ try to emulate up all the fault handling of some
> > version of Windows.  But whether it _should_ is a different story.
> 
> I say this is a case where we should try, at least to some extent; users 
> will feel that "Powerdown-swsusp automatically removes all hot-pluggable 
> devices" is too Draconian.
> 
> What do other people on the PM list think?

I think it is analogous to leaving a mounted CD in the drive and suspending.

If you resume the box without ejecting the CD, it remains mounted and all is fine
(I actually tested this).  I don't know what happens if you remove the CD from
the drive while suspended (from the Linux' point of view), but this is a different
kettle of fish.  Anyway, IMO, the behavior should be consistent across all
devices or users will get confused.

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============73904913430967079==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73904913430967079==--
