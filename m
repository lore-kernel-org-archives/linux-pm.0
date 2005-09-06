From: David Brownell <david-b@pacbell.net>
Subject: Re: Suspended devices and drivers
Date: Tue, 06 Sep 2005 08:18:45 -0700
Message-ID: <20050906151845.03BD2D480C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509061037520.5078-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============46807014453921214=="
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
To: stern@rowland.harvard.edu
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============46807014453921214==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > > With the USB device, things are more interesting.  If you unplug the
> > > device (even while it's not in use), Windows warns you not to do this
> > > ...
> > 
> > So it's inconsistent in behavior, since this isn't how it handles
> > the same thing during resume-from-hibernate ...
>
> ...
> If you describe the behavior as "Windows warns you whenever it learns that
> you ejected removable media without permission", then Windows _is_
> consistent.

No, it's inconsistent ... when you ejected the media before that
resume-from-snapshot, it could tell.  And it ignored it, even though
you'd not told Windows you were going to do that.


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

The simple solution is to use _real_ suspend states if you're going
to expect real suspend/resume behavior ... :)

Note that for things like HID devices (mice etc), users rarely notice
this since the HID driver masks enumeration through /dev/input/mice.

Also, that we've been aiming at that "removes devices" as the default
for drivers without suspend()/resume() support, because it's the ONLY
choice that's both reliable (all drivers can handle it) and safe (since
users and applications must already handle "live" unplug).

- Dave


--===============46807014453921214==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46807014453921214==--
