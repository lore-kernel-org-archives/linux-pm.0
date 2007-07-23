From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: Hibernation considerations
Date: Mon, 23 Jul 2007 14:31:29 +0200
Message-ID: <200707231431.30372.oliver__42856.0702632696$1185193911$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0707221116060.15224-100000@netrider.rowland.org>
	<200707231408.32051.rjw@sisk.pl>
	<E1ICwoE-0004q8-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1ICwoE-0004q8-00@dorka.pomaz.szeredi.hu>
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
Cc: david@lang.hm, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

Am Montag 23 Juli 2007 schrieb Miklos Szeredi:
> > The reason is that we want them to "park" in safe places, ie. where t=
here
> > are no locks held etc. =C2=A0Thus, these safe places need to be chose=
n somehow
> > and since they are not marked throughout the code, we choose the obvi=
ous
> > one. :-)
>=20
> Why shouldn't locks be held?
>=20
> No locks which are required for suspend must be held, sure. =C2=A0But
> otherwise holding locks doesn't matter at all.

If you can provide a way to tell them apart, this would work.

	Regards
		Oliver
