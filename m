From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 17:02:16 +0200
Message-ID: <200707041702.16583.oliver__48522.3011034124$1183561407$gmane$org@neukum.org>
References: <20070703224215.GA30081@srcf.ucam.org>
	<Pine.LNX.4.44L0.0707041030540.25704-100000@netrider.rowland.org>
	<20070704145818.GA7784@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070704145818.GA7784@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 4. Juli 2007 schrieb Matthew Garrett:
> On Wed, Jul 04, 2007 at 10:38:47AM -0400, Alan Stern wrote:
>=20
> > Okay, I agree that (1) can be handled without too much effort. =A0But=
=20
> > doing it adds an extra test to _every_ driver's I/O pathway. =A0Freez=
ing=20
> > userspace does not incur all this additional overhead.
>=20
> For runtime PM to work it's already necessary to have a test in that=20
> path to check if the device is suspended. I can't see how this adds any=
=20
> overhead to the common case.

No,

you just make sure the device reports to upper layers when it might
be busy. The USB layer manages this quite well without burdening
the common case.

	Regards
		Oliver
