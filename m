From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Hibernation considerations
Date: Mon, 23 Jul 2007 16:01:07 +0200
Message-ID: <200707231601.09541.rjw__48043.1383163252$1185198946$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707221116060.15224-100000@netrider.rowland.org>
	<200707231431.30372.oliver@neukum.org>
	<E1ICxdo-0004w2-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1ICxdo-0004w2-00@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>, stern@rowland.harvard.edu
Cc: david@lang.hm, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

On Monday, 23 July 2007 15:08, Miklos Szeredi wrote:
> > > > The reason is that we want them to "park" in safe places, ie. whe=
re there
> > > > are no locks held etc. =C2=A0Thus, these safe places need to be c=
hosen somehow
> > > > and since they are not marked throughout the code, we choose the =
obvious
> > > > one. :-)
> > >=20
> > > Why shouldn't locks be held?
> > >=20
> > > No locks which are required for suspend must be held, sure. =C2=A0B=
ut
> > > otherwise holding locks doesn't matter at all.
> >=20
> > If you can provide a way to tell them apart, this would work.
>=20
> Without some marking we can't tell obviously.
>=20
> Are there many such locks?  We can easily check by adding some
> debugging code to the lock primitives, to make them yell if they are
> used during suspend.

This way we can only obtain information from systems that use hibernation
quite often.

Alan has recently proposed to introduce "suspend locks" to be acquired du=
ring
a suspend/hibernation and such that we can leave uninterruptible tasks th=
at
don't hold any of them.

Unfortunately, I have no link to his original message at hand.

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
