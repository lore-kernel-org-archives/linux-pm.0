From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Suspended devices and drivers
Date: Tue, 6 Sep 2005 11:46:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509061134280.5078-100000@iolanthe.rowland.org>
References: <20050906151845.03BD2D480C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0018173575200277625=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050906151845.03BD2D480C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
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

--===============0018173575200277625==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 6 Sep 2005, David Brownell wrote:

> > > > With the USB device, things are more interesting.  If you unplug the
> > > > device (even while it's not in use), Windows warns you not to do this
> > > > ...
> > > 
> > > So it's inconsistent in behavior, since this isn't how it handles
> > > the same thing during resume-from-hibernate ...
> >
> > ...
> > If you describe the behavior as "Windows warns you whenever it learns that
> > you ejected removable media without permission", then Windows _is_
> > consistent.
> 
> No, it's inconsistent ... when you ejected the media before that
> resume-from-snapshot, it could tell.  And it ignored it, even though
> you'd not told Windows you were going to do that.

It sounds like we've got a failure to communicate.  There were two 
experiments.  In the first, I simply unplugged the device.  Windows did 
detect this and did warn me.  In the second experiment, I first did the 
snapshot-and-poweroff, then removed the device, then replaced the device, 
then did resume-from-snapshot.  In that experiment Windows could _not_ 
tell and did not warn me.

In none of the experiments was there a case where Windows could have
realized that I unplugged the device and failed to warn me about it.


> > I say this is a case where we should try, at least to some extent; users 
> > will feel that "Powerdown-swsusp automatically removes all hot-pluggable 
> > devices" is too Draconian.
> 
> The simple solution is to use _real_ suspend states if you're going
> to expect real suspend/resume behavior ... :)

It will probably be easier to add the code needed to verify devices and 
media after restore-from-snapshot than it would be to educate users about 
the difference between suspend/resume vs. snapshot/restore!  :-)

> Note that for things like HID devices (mice etc), users rarely notice
> this since the HID driver masks enumeration through /dev/input/mice.

Yes, certainly.  Mostly I'm concerned about storage devices.  Although the 
same concerns affect other things too, like audio/video devices.

> Also, that we've been aiming at that "removes devices" as the default
> for drivers without suspend()/resume() support, because it's the ONLY
> choice that's both reliable (all drivers can handle it) and safe (since
> users and applications must already handle "live" unplug).

Yes.  Eventually it would be good to get suspend/resume support into all 
the drivers that could stand to benefit from it.

Alan Stern


--===============0018173575200277625==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0018173575200277625==--
