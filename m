From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 30 Dec 2005 14:42:24 -0500
Message-ID: <200512301442.25442.dtor_core@ameritech.net>
References: <Pine.LNX.4.44L0.0512301423190.32015-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512301423190.32015-100000@netrider.rowland.org>
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

On Friday 30 December 2005 14:26, Alan Stern wrote:
> On Fri, 30 Dec 2005, Dmitry Torokhov wrote:
>=20
> > > There may indeed be other devices like that. =A0If you can't handle=
 device=20
> > > removal while the system is running normally, why should you be abl=
e to=20
> > > handle device removal while the system is suspended?
> > >
> >=20
> > Because I can?
> > =A0
> > > Conversely, even if the resume routine does detect somehow that the=
 device=20
> > > was removed, there's nothing it can do with that information if you=
 don't=20
> > > have a mechanism in place for handling device removals.
> > >
> >=20
> > The subsystem can handle device removal, its just hardware does not
> > give any notification when device is removed so subsystem has to rely
> > on some external event (such as resume process) to query the device
> > and check if it is still present.=20
>=20
> In that case, I would say that it is appropriate to use keventd or some=
=20
> other worker thread to handle device removal detected during resume. =A0
> Since these threads will be frozen along with everything else, the=20
> unregister calls wouldn't be made until the system was once again awake.
>

Input (well, actually serio) devices are already handled via kseriod thre=
ad,
but that's because it was already there. I was saying that driver core sh=
ould
not require a reaper thread if there isn't one yet.

> If you were really serious about it, you could even set up a work queue
> to query each input device once per minute (say), to see whether it had
> gotten removed. =A0But that's probably overkill.

Not only this is overkill but there are many devices with different ways
to check for presence and quite often queies may disturb the device (i.e.
right when you decide to tap on your touchpad my thread will decide that
it is time for querying and will disable it, query and re-enable and that
tap will be lost).

--=20
Dmitry
