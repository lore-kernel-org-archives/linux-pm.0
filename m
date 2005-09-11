From: David Brownell <david-b@pacbell.net>
Subject: Re: Suspended devices and drivers
Date: Sun, 11 Sep 2005 15:27:16 -0700
Message-ID: <20050911222716.EE95AE9E21@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0509111538350.25522-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============60843934534370125=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509111538350.25522-100000@netrider.rowland.org>
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

--===============60843934534370125==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > Most usable definitions of "acceptable" will end up needing to be very
> > driver-specific ... or vendor-specific, or system-specific, etc.
>
> I see nothing wrong in that.  And we can have minimal standards that are 
> more general, say filesystem-specific.

The tricky part would then be how to connect all those customized
parts together.  It's hard enough even for non-custom ones!  :)


> > > > The driver is supposed to maintain driver state; but
> > > > the device is supposed to maintain device state.
> > >
> > > ...
> > > > Resuming implies _both_ of them have been preserved.
> > > ...
>
> In cases where state cannot be preserved, then obviously the device can't 
> hope to survive snapshot-poweroff-resume.  But you're distorting matters 
> by implying that the driver can not be responsible for maintaining device 
> state.

I'm not implying that; I'm _saying_ that's the general case, and
gave examples where clearly drivers can not maintain device state.

There's no distortion involved in recognizing that loss of power will
intentionally trigger device state changes (start with internal reset,
and go on from there), or that it'd take work -- which most vendors
won't invest! -- to ensure that those changes can't matter to drivers.


>	Of course it can; and if the driver and device _together_ maintain 
> sufficient state then the device should survive.

So the question becomes how to accomodate such special cases.
Agreed:  some devices and drivers could do that.


> > I summarized the USB bus rules -- (a) and (b) -- above.
>
> Those are the rules for _guaranteeing_ that the USB device hasn't changed.  
> What about rules for saying that as far as you can tell the device hasn't 
> changed?

That "as far as I can tell" can cover arbitrary amounts of work!
Userspace is the best place to provide such subjective judgments...


> > Right now the "same medium" checks are done in userspace.  And I recall
> > folk arguing about that, and deciding that userspace was the the only
> > workable place for them ...
>
> That may be so; I don't know.

Have a look at how UDEV systems determine disk identities and thus choose
how to name and mount disks.


>	The thought occurs that the filesystem 
> ought to get involved, at least to the extent of checking a hash of the 
> superblock...

Which superblock(s)?  And what about the non-filesystem data?  :)


> > And I couldn't support the assumption of "non-hostile environment" for
> > most any general purpose system ... they'll surely get used in places
> > where that's an unsafe assumption!
>
> I hardly think that matters.  Anyone who has sufficient physical access to
> the computer to disconnect and reconnect peripheral devices is already in
> a position to do a lot of damage.  You might just as well go around trying
> to protect against hostile actions by root!  :-)

Whipping out the Leatherman and having at a box may mean ten minutes' work,
and would be quite visible.  (That's assuming the system is already down.)

Swapping a USB device is maybe ten seconds' work ... if someone turned
their back to you for that long, they might never notice what you did.
USB based attacks could be _really_ easy to apply.  (Doesn't Windows
have "autorun" capability?  That could just start a big spam job...)

- Dave


--===============60843934534370125==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============60843934534370125==--
