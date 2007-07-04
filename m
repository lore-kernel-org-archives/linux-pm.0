From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 10:11:33 +0200
Message-ID: <200707041011.33279.oliver__37816.3341469646$1183536786$gmane$org@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031342.14295.oliver@neukum.org>
	<18058.55215.185633.434117@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18058.55215.185633.434117@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 4. Juli 2007 schrieb Paul Mackerras:
> Oliver Neukum writes:
>=20
> > USB devices certainly have suspend methods.
>=20
> Indeed, and the USB framework has code to know when the host
> controller is suspended and avoid trying to send out urbs in that
> case. =A0Or at least it did last time I looked at it in any detail; it'=
s
> been "just working" - including suspending and resuming, without the
> freezer - for quite a while now.

And what happens to that IO? I suspended and lost data is not an
acceptable behavior.

	Oliver
