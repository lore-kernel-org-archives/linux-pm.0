From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: Hibernation considerations
Date: Mon, 23 Jul 2007 15:08:00 +0200
Message-ID: <E1ICxdo-0004w2-00@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.44L0.0707221116060.15224-100000@netrider.rowland.org>
	<200707231408.32051.rjw@sisk.pl>
	<E1ICwoE-0004q8-00@dorka.pomaz.szeredi.hu>
	<200707231431.30372.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707231431.30372.oliver@neukum.org> (message from Oliver
	Neukum on Mon, 23 Jul 2007 14:31:29 +0200)
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
Cc: david@lang.hm, miklos@szeredi.hu, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

> > > The reason is that we want them to "park" in safe places, ie. where=
 there
> > > are no locks held etc. =C2=A0Thus, these safe places need to be cho=
sen somehow
> > > and since they are not marked throughout the code, we choose the ob=
vious
> > > one. :-)
> >=20
> > Why shouldn't locks be held?
> >=20
> > No locks which are required for suspend must be held, sure. =C2=A0But
> > otherwise holding locks doesn't matter at all.
>=20
> If you can provide a way to tell them apart, this would work.

Without some marking we can't tell obviously.

Are there many such locks?  We can easily check by adding some
debugging code to the lock primitives, to make them yell if they are
used during suspend.

Miklos
