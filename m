Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FD73DDDAA;
	Mon,  6 Jul 2026 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349363; cv=none; b=HKomYi4AlsNFdqv8k0uOTJPnsume83m4ZBysgBhcpE+R005RzqwqPIl+IQasV3HWZ+5dNHeajNjaDCd8qcJXQy9lASJesF7OTkJkkbIQv/4kGKlhOU5xeEsLJzSED13gpuvzM54wqh2VARyeC8kyEqztBrz50QjJAOKSVIa8BRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349363; c=relaxed/simple;
	bh=eulpyiUh0aznOlxmeBeXXDKWTgTsYGSGxJkchSqiGrM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cjCk2sXxzSIwpuf+/GRmY+L/kRCvw2c7pIW/bO5ZRnM9+INlJyp4Dg4FISwIY6ciBtJZMEDKAkTcIvWDRNhBLcrVKZU2MasARBTqPfzAURnl8NLwMVpUo5nV8pZvwV5jqzgIYnTHiIvz3pgbIAD0N0Dik/SncwcAhY0l3DUrtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uADD0ghB; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uADD0ghB"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gv6gr5jBTz8tvS;
	Mon, 06 Jul 2026 16:49:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783349352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eulpyiUh0aznOlxmeBeXXDKWTgTsYGSGxJkchSqiGrM=;
	b=uADD0ghBygQ7hl7LTqSuQzNrT4pfxd3Nkk3nWvmf6IB3D+bbZ8Po9+rlsavnkGLJ4uZdnA
	E6oxE7wja5lrQWqtmpkzyprJHhQUbkUKADwiXdWDyRW509f88ZfjFbVdsc2ylpT40fOOU1
	WzrrRp/KWvzTBBzYRWZJPYm3J3L0aVGbHLts233EFpwatX6mIqHFWSxS8OKrpUaHqJgDM6
	8q8JwEt/ImdukYWwmuJxsFdKcpthuzyLtn4uBC7Nb6yxlqQ9FZ9gTB4t5yU9FTpas5wHRe
	7YWXY3JENVL6v02qurgwVxEoXonNX6ionzTbrhMb+kZ8bmbK2CqpjuhuTskBOw==
Message-ID: <88ee8e5f9b87c202a563accccc224280800a8a64.camel@mailbox.org>
Subject: Re: [PATCH v3 02/20] driver core: platform: provide
 platform_device_set_of_node()
From: Manuel Ebner <manuelebner@mailbox.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Lee Jones	
 <lee@kernel.org>, Thierry Reding <thierry.reding@avionic-design.de>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Srinivas Kandagatla	 <srini@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul	 <vkoul@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich	
 <dakr@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan	
 <saravanak@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)"	 <chleroy@kernel.org>, Andi Shyti
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
 Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, Philipp Zabel
 <p.zabel@pengutronix.de>,  Maximilian Luz <luzmaximilian@gmail.com>, Hans
 de Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, 	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	mfd@lists.linux.dev
Date: Mon, 06 Jul 2026 16:48:48 +0200
In-Reply-To: <fbc50f89e0c3bb148656a3b8d96974f591576dec.camel@mailbox.org>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
		 <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
	 <fbc50f89e0c3bb148656a3b8d96974f591576dec.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: e7506a7c665f87bbeac
X-MBO-RS-META: yfo5gat8zopp9bgmyshyyaocgtadhjyy

On Mon, 2026-07-06 at 16:39 +0200, Manuel Ebner wrote:
> Hi Bartosz,
>=20
> On Mon, 2026-07-06 at 14:44 +0200, Bartosz Golaszewski wrote:
> >=20
> > @@ -693,6 +693,24 @@ int platform_device_add_data(struct platform_devic=
e *pdev, const

Nevermind, I got confused because of @@ int platform_device_add_data() and

> @@ -619,6 +619,13 @@ static void platform_device_release_full(struct devi=
ce *dev)
in [PATCH v3 05/20] driver core: update kerneldoc for platform_device_alloc=
()

Sorry for the noise
 Manuel
