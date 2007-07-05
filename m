From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 22:49:44 +0200
Message-ID: <200707052249.45495.oliver__12957.5665262111$1183668629$gmane$org@neukum.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707052234.30021.oliver@neukum.org>
	<E1I6YDJ-0001sj-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6YDJ-0001sj-00@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 5. Juli 2007 schrieb Miklos Szeredi:
> > > Yes, fuse could handle being frozen there. =C2=A0However that would=
 only
> > > solve part of the problem: an operation waiting for a reply could b=
e
> > > holding a VFS mutex and some other task may be blocked on that mute=
x.
> > >=20
> > > How would you solve freezing those tasks?
> >=20
> > OK, you made me reach for literatur on theoretical computer science.
> >=20
> > IMHO the range of actions a fuse server is inherently limited.
> > You must never ever block on a lock one of your clients is holding. I=
n
> > this case the limitation is not influenced by the freezer.
>=20
> Obviously. =C2=A0But I wasn't about the server trying to acquire a lock
> held by a client. =C2=A0I was talking about a client trying to acquire =
a
> lock held by _another_ client.
>=20
> If this coincides with the server (or some other task which the server
> is depending on) being frozen before the clients, the freezer has a
> problem.

True, but that case can only happen if servers are frozen before clients.
You don't need a full dependency graph. A simple set sequence of two
classes of tasks will do.

	Regards
		Oliver
