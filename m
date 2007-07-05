From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Thu, 5 Jul 2007 17:06:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707051704580.2557-100000__25819.7922529236$1183669726$gmane$org@iolanthe.rowland.org>
References: <200707052249.45495.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707052249.45495.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Jul 2007, Oliver Neukum wrote:

> > Obviously. =C2=A0But I wasn't about the server trying to acquire a lo=
ck
> > held by a client. =C2=A0I was talking about a client trying to acquir=
e a
> > lock held by _another_ client.
> >=20
> > If this coincides with the server (or some other task which the serve=
r
> > is depending on) being frozen before the clients, the freezer has a
> > problem.
>=20
> True, but that case can only happen if servers are frozen before client=
s.
> You don't need a full dependency graph. A simple set sequence of two
> classes of tasks will do.

Just to make things more complicated...  Since a server isn't
restricted in what it can do, what happens when one server depends on
another server?

Alan Stern
