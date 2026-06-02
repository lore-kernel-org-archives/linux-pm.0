Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB09F3C4B84
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388770; cv=none; b=WaVMSgJdXISl7E2cH4IL6yrPgJEOf/oG7KsH3ySpOA/kWv5Zxs6bCGW1eNDjobrYUTDlbyCIOKMUNucjY6Z6VLlf1/1tsOTVAHp1M+qnYs6pdERRUOJkKv6MHmyOgZ0WZ6FZfYXSzoidb81Q5xIbYP9FgmFgW3yA8yFoyWFbpGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388770; c=relaxed/simple;
	bh=ZQkpBhdyPFX8K1AgwsbSqD6e4PBbKm/F+6uEvcBzPyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oCF3+LzF3V+jsbgePpRQcFFFgzRbw5HY9ayHS8tGC59EwJIt+2Z8HTXjLuXUzo8h1Q4Z+qzqwxrm1KPfclyEXceYoStYqPXob0r/5ZYgRoteEAOjYA0c0//EKdTquAZTcpADCrr8JhR3S13cQbHKDOp0WxjE7tnSYFOs/8MTQUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wUKQZ-0001Gf-0T; Tue, 02 Jun 2026 10:24:47 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wUKQT-000iZa-13;
	Tue, 02 Jun 2026 10:24:41 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wUKQT-000000003ba-0TqR;
	Tue, 02 Jun 2026 10:24:41 +0200
Message-ID: <6af284545729f03a60d06479339862a2f08c6b7e.camel@pengutronix.de>
Subject: Re: [PATCH 22/23] reset: rzg2l: use
 platform_device_set_of_node_from_dev()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Lee Jones	
 <lee@kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Thierry
 Reding <thierry.reding@avionic-design.de>, Sebastian Hesselbarth	
 <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Srinivas Kandagatla <srini@kernel.org>, Greg
 Kroah-Hartman	 <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Rob Herring <robh@kernel.org>,  Saravana Kannan
 <saravanak@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andi Shyti
 <andi.shyti@kernel.org>, Andy Shevchenko	
 <andriy.shevchenko@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Doug Berger
 <opendmb@gmail.com>,  Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team	 <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Matthew Brost	 <matthew.brost@intel.com>, Thomas
 =?ISO-8859-1?Q?Hellstr=F6m?=	 <thomas.hellstrom@linux.intel.com>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>,  David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>,  Paul
 Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, Maximilian Luz
 <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Krzysztof
 Kozlowski	 <krzk@kernel.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, 	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date: Tue, 02 Jun 2026 10:24:41 +0200
In-Reply-To: <20260521-pdev-fwnode-ref-v1-22-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
	 <20260521-pdev-fwnode-ref-v1-22-88c324a1b8d2@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Do, 2026-05-21 at 10:36 +0200, Bartosz Golaszewski wrote:
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node from another device for
> dynamically allocated platform devices with the provided helper.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/reset/reset-rzg2l-usbphy-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
> index fd75d9601a3bfde7b7e3f6db287ec8c5c45a20ab..f003b360629c90bb37ed0ade7=
a675b5b0f28fa7e 100644
> --- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> @@ -249,7 +249,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_de=
vice *pdev)
>  	vdev->dev.parent =3D dev;
>  	priv->vdev =3D vdev;
> =20
> -	device_set_of_node_from_dev(&vdev->dev, dev);
> +	platform_device_set_of_node_from_dev(vdev, dev);
>  	error =3D platform_device_add(vdev);
>  	if (error)
>  		goto err_device_put;

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
