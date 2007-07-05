From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 23:15:38 +0200
Message-ID: <200707052315.38770.oliver__18576.7636438415$1183670682$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0707051704580.2557-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707051704580.2557-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 5. Juli 2007 schrieb Alan Stern:
> On Thu, 5 Jul 2007, Oliver Neukum wrote:
>=20
> > > Obviously. =C2=A0But I wasn't about the server trying to acquire a =
lock
> > > held by a client. =C2=A0I was talking about a client trying to acqu=
ire a
> > > lock held by _another_ client.
> > >=20
> > > If this coincides with the server (or some other task which the ser=
ver
> > > is depending on) being frozen before the clients, the freezer has a
> > > problem.
> >=20
> > True, but that case can only happen if servers are frozen before clie=
nts.
> > You don't need a full dependency graph. A simple set sequence of two
> > classes of tasks will do.
>=20
> Just to make things more complicated...  Since a server isn't
> restricted in what it can do, what happens when one server depends on
> another server?

The same principle applies. If you really want that you can solve this
by freezing servers in the reverse sequence they were started.

The main point remains. If you have a circular dependency anywhere
among the servers you can deadlock independent of the freezer.

	Regards
		Oliver
