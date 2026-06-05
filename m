Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CCB3DD864;
	Fri,  5 Jun 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671269; cv=none; b=XURFfdMpC/md6jqHfwBOB9U8ftXfzpl1ZkqI/2XmO8AOsB7oKqDqMIS1JHgEzW3OI1dTGSiohkOeiWBBgIrSWNLN2eOja0JBVhLsu33ZKToXg9bJO0aB9yPfkYK2+XIv0Jqqh8C4FVizPvRM35QV9NIcK4WYTYdCXTNWWZH5iY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671269; c=relaxed/simple;
	bh=4tMeiKXzH2reWHQd2Do3LiCn4ypOHk0Io4ayzbOXR2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE69f7oEiRrURVD1baumey7QqDInL9iiWqiBfGrbP5jySeDDdkIWnvId4Zf4wiZOFUXt7Fyis0KDmSaGMqnDlbDIpCmY4fdq7H7yRTtig4qNyHktkoRtpRpFzScC1n7mwTj9WBhmpQ79TwXmcWmtMrlDOHt6uy4wEdK01J2e/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViCrIBCD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViCrIBCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780671269; x=1812207269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4tMeiKXzH2reWHQd2Do3LiCn4ypOHk0Io4ayzbOXR2A=;
  b=ViCrIBCD8lCv6XAbtpT81FQ631uftKlCzal7av3ErRIqeaKCKymlgqn6
   AoZVkeupiO2Xg79jhTTe77rFaGCtOmmBblSg8R0tb2lR31byKp3B6Y335
   GzHmCh/RAMtIxamW2Ot1DumW6coJAGxX3Vv2f6pQRwLXWS8yBRVHbJkNO
   SvAu7aJAScvOVWTCSvnnIfXc42pEaCW2PeESJFwBerwUF2SaUh2QdynjL
   KUhMC7j1zNE5snvNw7VYH2wqff3SV/h/qaLcJm79GCnPjGAIeIkytw/fO
   rLX/Vk9j3d+uZk9UOSchtxYi9OaNPMkWQ0LMC21U27AagpVieYbzloWS5
   Q==;
X-CSE-ConnectionGUID: 9ou23hR/QfCF9CuA/UpSrQ==
X-CSE-MsgGUID: liEgSng5SJaoz8YLlT4+Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81565442"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81565442"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 07:54:28 -0700
X-CSE-ConnectionGUID: h9Rk7ixqSzO/yh1S6oBceQ==
X-CSE-MsgGUID: mgvGmj4gSWyogJmBey9GTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="243768683"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 07:54:14 -0700
Date: Fri, 5 Jun 2026 17:54:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Lee Jones <lee@kernel.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Peter Chen <peter.chen@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	driver-core@lists.linux.dev, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 22/23] reset: rzg2l: use
 platform_device_set_of_node_from_dev()
Message-ID: <aiLjE0SLwrDytyw0@ashevche-desk.local>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-22-88c324a1b8d2@oss.qualcomm.com>
 <6af284545729f03a60d06479339862a2f08c6b7e.camel@pengutronix.de>
 <ah9QtExF2rUUTMNo@ashevche-desk.local>
 <aiK-qZqpuC-OEigf@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiK-qZqpuC-OEigf@hovoldconsulting.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 02:18:49PM +0200, Johan Hovold wrote:
> On Wed, Jun 03, 2026 at 12:52:52AM +0300, Andy Shevchenko wrote:
> > On Tue, Jun 02, 2026 at 10:24:41AM +0200, Philipp Zabel wrote:
> > > On Do, 2026-05-21 at 10:36 +0200, Bartosz Golaszewski wrote:

...

> > > > -	device_set_of_node_from_dev(&vdev->dev, dev);
> > > > +	platform_device_set_of_node_from_dev(vdev, dev);
> > 
> > Same Q here, why it uses inherited call? Cargo cult?
> > 
> > 'reused' flag is solely pin control (provider!) thingy as far as I remember.
> 
> No, it's needed for pin control *consumers*, which can be any device,
> and potentially any other resource managed by driver core or bus code.

Why don't we set it for every pin control consumer automatically?

-- 
With Best Regards,
Andy Shevchenko


