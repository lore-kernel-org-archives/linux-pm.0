From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 30 Dec 2005 14:26:41 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512301423190.32015-100000@netrider.rowland.org>
References: <200512301418.46197.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200512301418.46197.dtor_core@ameritech.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 30 Dec 2005, Dmitry Torokhov wrote:

> > There may indeed be other devices like that. =A0If you can't handle d=
evice=20
> > removal while the system is running normally, why should you be able =
to=20
> > handle device removal while the system is suspended?
> >
>=20
> Because I can?
> =20
> > Conversely, even if the resume routine does detect somehow that the d=
evice=20
> > was removed, there's nothing it can do with that information if you d=
on't=20
> > have a mechanism in place for handling device removals.
> >
>=20
> The subsystem can handle device removal, its just hardware does not
> give any notification when device is removed so subsystem has to rely
> on some external event (such as resume process) to query the device
> and check if it is still present.=20

In that case, I would say that it is appropriate to use keventd or some=20
other worker thread to handle device removal detected during resume. =20
Since these threads will be frozen along with everything else, the=20
unregister calls wouldn't be made until the system was once again awake.

If you were really serious about it, you could even set up a work queue
to query each input device once per minute (say), to see whether it had
gotten removed.  But that's probably overkill.

Alan Stern
