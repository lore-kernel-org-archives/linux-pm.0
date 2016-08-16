From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/8] Remove deprecated workqueue interface users
Date: Tue, 16 Aug 2016 02:23:21 +0200
Message-ID: <20160816002321.ibydaw5qrkpvyx26@earth>
References: <cover.1471104124.git.bhaktipriya96@gmail.com>
 <20160815225948.GG3672@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hd5gqx2eb5ygglsr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38536 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbcHPAX2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Aug 2016 20:23:28 -0400
Content-Disposition: inline
In-Reply-To: <20160815225948.GG3672@mtj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--hd5gqx2eb5ygglsr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 15, 2016 at 06:59:48PM -0400, Tejun Heo wrote:
> On Sat, Aug 13, 2016 at 09:41:21PM +0530, Bhaktipriya Shridhar wrote:
> > This patch set removes the instances of deprecated
> > create_singlethread_workqueues in drivers/power by making the appropria=
te
> > conversions.
> >=20
> > Bhaktipriya Shridhar (8):
> >   power: abx500_chargalg: Remove deprecated create_singlethread_workque=
ue
> >   power: ab8500_btemp: Remove deprecated create_singlethread_workqueue
> >   power: pm2301_charger: Remove deprecated create_singlethread_workqueue
> >   power: intel_mid_battery: Remove deprecated create_singlethread_workq=
ueue
> >   power: ab8500_charger: Remove deprecated create_singlethread_workqueue
> >   power: ipaq_micro_battery: Remove deprecated create_singlethread_work=
queue
> >   power: ab8500_fg: Remove deprecated create_singlethread_workqueue
> >   power: ds2760_battery: Remove deprecated create_singlethread_workqueue
>
> Patches look good to me.  I'm a bit curious about WQ_MEM_RECLAIM
> part tho. I suppose the reasoning is that as the hardware in
> question is involved in battery management which may be time
> critical, WQ_MEM_RECLAIM is added to ensure (timely) forward
> progress under memory pressure, right? It'd be great if someone
> who's more familiar with these hardware can confirm whether this
> is actually necessary.

At least the charger monitoring is timing critical: Many charger
chips must be monitored (e.g. for over-temp. events). I think
all of them have a self-protection, or a watchdog, so they would
actually stop charging instead of overheating, but that may result
in system failure due to power loss. Battery monitors also include
some temperture safety checks. So without careful case-by-case
checking the WQ_MEM_RECLAIM should not be removed IMHO.

Anyways, I queued this patchset, since create_singlethread_workqueue()
did use WQ_MEM_RECLAIM, so removing that bit should be in another patch.

> Oh, it'd also be nice to put the target subsystem in the subject of
> the patchset - e.g. "[PATCH 0/8] power: Remove..."

Yes please. Also it seems like PATCH2-8 have wrong reference to
PATCH0/8 mail.

-- Sebastian

--hd5gqx2eb5ygglsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXslz3AAoJENju1/PIO/qahDoP/3jBz8ssFUKeOdeVqYUIHFKT
280CmikjEw2dX44HAlrwgbV+Al0Hm32fb99K52YnAb/L7LyV6B2sJLLST9Dlb0t/
FoqLI9A4BtFqXD5HvzLFpeVg2UuuRN8KrEGLFnuPL2bCc5Z+V6+G6JD8jroM5LYO
triYpysb/yba04AJ6oxU2fhZG+iqC7ktJ8Dm73IXSuwWNR4cLj4488D85XV86HEV
GPKcuNgWuqi50Le2ahuiSgPwQZxqaQpWPZAYDIAj3Xp8uoxPUcQqcBRQe3uXyzM4
8lni2EBluG94MTs5gidd+mfuQf4zoVlGvE0kKkyiORLzJ6LcBM+u88dNZpjmPzbv
8TO/r4RVnzCuElUp1HQ3bu0gRgIsRg5gwH9ZJ0fr1V22Vw4OGFkkifkmmRuBTi5k
clbG0TDv7CV87TwG4KFmRAQOPBrDWby5OrxiXSS1NQ3JpmLUwd2I1NBYAhNlWckq
Ft7PVcJjHI1w6vgqAuipf0ivRCussISuInh4RIDVilUFZ21MKMLOHvLKVuH53is+
MtaElaPV/sxl6MMLxigL8LZ+ke7pjEKPy2NaZ4KmnEiYpbf/2i1UnHQHLRxt7urz
t6/RG2k8+Pr12SDjfSLKUm5rNJ0xl3JdhNycKeB523uYzpVoRDDLHtXf8wrP8h8G
mejo9h7zaea4WQRpsZ5/
=O08y
-----END PGP SIGNATURE-----

--hd5gqx2eb5ygglsr--
