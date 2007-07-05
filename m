From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 23:31:32 +0200
Message-ID: <E1I6YvE-00025u-00@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.44L0.0707051704580.2557-100000@iolanthe.rowland.org>
	<200707052315.38770.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707052315.38770.oliver@neukum.org> (message from Oliver
	Neukum on Thu, 5 Jul 2007 23:15:38 +0200)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: oliver@neukum.org
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > On Thu, 5 Jul 2007, Oliver Neukum wrote:
> >=20
> > > > Obviously. =C3=82=C2=A0But I wasn't about the server trying to ac=
quire a lock
> > > > held by a client. =C3=82=C2=A0I was talking about a client trying=
 to acquire a
> > > > lock held by _another_ client.
> > > >=20
> > > > If this coincides with the server (or some other task which the s=
erver
> > > > is depending on) being frozen before the clients, the freezer has=
 a
> > > > problem.
> > >=20
> > > True, but that case can only happen if servers are frozen before cl=
ients.
> > > You don't need a full dependency graph. A simple set sequence of tw=
o
> > > classes of tasks will do.
> >=20
> > Just to make things more complicated...  Since a server isn't
> > restricted in what it can do, what happens when one server depends on
> > another server?
>=20
> The same principle applies. If you really want that you can solve this
> by freezing servers in the reverse sequence they were started.

You just can't know what constitutes a "server", processes which read
from the fuse device are candidates, but all tasks which communicate
with these in some way are also.  And that basically makes every
userspace task in the system a candidate server and you are no further
than before.

> The main point remains. If you have a circular dependency anywhere
> among the servers you can deadlock independent of the freezer.

Well, Duh.

Miklos
