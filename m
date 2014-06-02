From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] PM / Runtime: Make autosuspend_delay == 0 work as intended
Date: Mon, 2 Jun 2014 11:35:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1406021119020.1280-100000@iolanthe.rowland.org>
References: <87ppir4h4c.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:42557 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752390AbaFBPfb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jun 2014 11:35:31 -0400
In-Reply-To: <87ppir4h4c.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Mon, 2 Jun 2014, Bj=C3=B8rn Mork wrote:

> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>=20
> > Alan has to see this in the first place.
> >
> > On Monday, June 02, 2014 12:29:12 PM Bj=C3=B8rn Mork wrote:
> >> OK, I don't like the result I came up with here.  So I am sending =
this
> >> as an RFC in the hope that smarter people than me can come up with
> >> something nicer. I hope the patch illustrates my problem:  While
> >> trying do debug some runtime suspend issues in a driver, I tempora=
rily
> >> set autosuspend to 0 to deliberately make it aggressive enough for=
 my
> >> driver to fail. I was surprised to learn than this effectively
> >> *disabled* autosuspend if the driver ever return -EBUSY from the
> >> runtime suspend callback.
> >
> > That results from pm_runtime_autosuspend_expiration() always return=
ing 0 in
> > that case.
>=20
> Yup.

> > Well, as I said.
> >
> > Perhaps pm_runtime_autosuspend_expiration() could simply treat
> > power.autosuspend_delay equal to 0 in a special way, but then what =
about
> > power.autosuspend_delay equal to 1?
>=20
> Is that going to cause similar problems? Hmm, I guess it is if the
> callback takes so long that the timeout is reached when we get here?
>=20
> In which cases do you *not* want to retry runtime suspend on -EBUSY f=
rom
> the driver callback? If you don't retry, then the device will not
> runtime suspend at all until the next time the driver updates last_bu=
sy.
> And if the driver always is busy some time after such updates, then
> runtime suspend is effectively disabled.

We don't want to get into a tight retry loop.  That's what I was trying
to avoid.  Notice that although the comment mentions last_busy being
updated, the code doesn't actually look at last_busy.  Instead, it
looks to see if the new expiration time is in the future (which won't
happen unless last_busy gets updated) -- that's how it avoids going
into a tight loop.

> Should drivers just update last_busy more agressively, and make sure =
to
> update it both when starting some hardware transaction and when
> finishing it? That would make the suspend callback run again when the
> hardware is not busy anymore, and would probably make stuff work with=
out
> any PM core changes.

We want to minimize the amount of work that drivers need to do.

I like your idea of adding an explicit retry delay.  In fact, I would=20
like to go farther and make the delay automatically back off=20
exponentially.

How about something like this?  Let t =3D jiffies - last_busy.  If t <=3D=
 1=20
ms then set retry_delay to 1 ms, otherwise set retry_delay to min(t*2,=20
1000 ms).  Or even use a larger cap, such as 60 s.

Alan Stern

PS: You don't need to use ACCESS_ONCE the way you did.  It's important
only when the same value is used several times and you want the
compiler to store a local copy instead of re-reading the original (in
case the original gets changed by another CPU).

