From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 30 Dec 2005 14:18:44 -0500
Message-ID: <200512301418.46197.dtor_core@ameritech.net>
References: <Pine.LNX.4.44L0.0512301323000.32015-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512301323000.32015-100000@netrider.rowland.org>
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

On Friday 30 December 2005 13:26, Alan Stern wrote:
> On Thu, 29 Dec 2005, Dmitry Torokhov wrote:
>=20
> > > Why do you need a new cleanup thread? =A0What's wrong with the exis=
ting=20
> > > strategy for handling removed devices -- i.e., the procedure that w=
ould=20
> > > have been followed if there was no suspend/resume transition?
> > >=20
> >=20
> > Sometimes there is no such procedure. For example if you yank PS/2 mo=
use
> > there is no way for the system to detect it's missing. Only when you =
try
> > to resume and mouse does not respond you realize it's gone. I bet the=
re
> > are other devices like that.=20
>=20
> There may indeed be other devices like that. =A0If you can't handle dev=
ice=20
> removal while the system is running normally, why should you be able to=
=20
> handle device removal while the system is suspended?
>

Because I can?
=20
> Conversely, even if the resume routine does detect somehow that the dev=
ice=20
> was removed, there's nothing it can do with that information if you don=
't=20
> have a mechanism in place for handling device removals.
>

The subsystem can handle device removal, its just hardware does not
give any notification when device is removed so subsystem has to rely
on some external event (such as resume process) to query the device
and check if it is still present.=20

--=20
Dmitry
