From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 16:02:17 +0200
Message-ID: <200707051602.19042.rjw__33265.4498437934$1183643822$gmane$org@sisk.pl>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<200707051523.44826.rjw@sisk.pl>
	<200707051528.34754.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707051528.34754.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 15:28, Oliver Neukum wrote:
> Am Donnerstag, 5. Juli 2007 schrieb Rafael J. Wysocki:
> > > It seems pretty clear cut. =A0Whining about how much problems this =
will
> > > cause won't get us nearer to a solution.
> >=20
> > Yes, that's pretty clear cut, but we should start from fixing the dri=
vers. :-)
>=20
> If, at a minimum, we can determine that we can STD without a freezer.

No, we can't.

> It makes no sense to invest a lot of work to face the same problem
> again with STD.

Arguably, it does make sense, because for many platforms the hibernation
is irrelevant and we're going to separate the suspend and hibernation
frameworks anyway.

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
