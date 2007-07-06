From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 09:32:30 +0200
Message-ID: <200707060932.31345.oliver__38951.1421941735$1183707202$gmane$org@neukum.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<E1I6XFM-0001ek-00@dorka.pomaz.szeredi.hu>
	<1183676751.3388.96.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183676751.3388.96.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, 6. Juli 2007 schrieb Benjamin Herrenschmidt:
> > Yes, fuse could handle being frozen there. =C2=A0However that would o=
nly
> > solve part of the problem: an operation waiting for a reply could be
> > holding a VFS mutex and some other task may be blocked on that mutex.
> >=20
> > How would you solve freezing those tasks?
>=20
> That task is implicitely frozen... but the kernel doesn't know it and
> thus the freezer timeouts or fails or deadlocks or whatever.
>=20
> The freezer could be made to ignore tasks that are sleeping in the
> kernel assuming that if they go out of it, they'll ultimately reach
> do_signal and freeze, but that means they can potentially still issues
> IOs which is what the freezer tries to avoid ...
>=20
> Or the kernel could start tracking dependencies, but then, good luck
> implementing that crap.

Do we need dependencies? Don't we know that fuse can deadlock only
on a limited number of locks in VFS?

	Regards
		Oliver
