From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 30 Dec 2005 15:13:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512301511190.3145-100000@netrider.rowland.org>
References: <200512301442.25442.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200512301442.25442.dtor_core@ameritech.net>
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

> > In that case, I would say that it is appropriate to use keventd or so=
me=20
> > other worker thread to handle device removal detected during resume. =
=A0
> > Since these threads will be frozen along with everything else, the=20
> > unregister calls wouldn't be made until the system was once again awa=
ke.
> >
>=20
> Input (well, actually serio) devices are already handled via kseriod th=
read,
> but that's because it was already there. I was saying that driver core =
should
> not require a reaper thread if there isn't one yet.

The driver core doesn't make this requirement.  If you don't want to reap=
=20
those devices during resume then you don't need the thread.  And after=20
all, if you don't reap the devices at other times then why bother reaping=
=20
them during resume?

Alan Stern
