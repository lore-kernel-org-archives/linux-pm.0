From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 15:28:33 +0200
Message-ID: <200707051528.34754.oliver__1493.96516285396$1183642851$gmane$org@neukum.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<E1I6Pud-0000V1-00@dorka.pomaz.szeredi.hu>
	<200707051523.44826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707051523.44826.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 5. Juli 2007 schrieb Rafael J. Wysocki:
> > It seems pretty clear cut. =A0Whining about how much problems this wi=
ll
> > cause won't get us nearer to a solution.
>=20
> Yes, that's pretty clear cut, but we should start from fixing the drive=
rs. :-)

If, at a minimum, we can determine that we can STD without a freezer.
It makes no sense to invest a lot of work to face the same problem
again with STD.

	Regards
		Oliver
