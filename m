Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E6442315C;
	Fri,  5 Jun 2026 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644728; cv=none; b=ApTmAAsJQZeMZUYYYAxrcVUu3afBmB+xB9Leq8lQKggoFeeR5fkdT4+in+20UlE6jnoDj7zG/leucrwQ4S9yeHNp2xgOKuFyA8TULlBGCUNlKxhcDJpJzIwSOw85rLyF2NhVeSl2Cznyn++uRA2QfDPveEZ3eXYBMCimhzDyLhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644728; c=relaxed/simple;
	bh=c30wbulhkBn1BOKZ95h66WcDcHsR2Lig8B6kzzR9otg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlRM+IeYSCMvfG/BZgboPZuuSMDydBImO5nRRmQvrqvLapimmToLjtTXt7FhUz/pjkhrs636K+FXwREBcKHvjt/FRmn4fYKMMdw12zAE1PgjgqEyh/6OFQsfpOA1Z54N+Vfv8cGcq3TzlrW4gtNtS4BSoPJHN5XXULKg3LJH95Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGZhrs/N; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGZhrs/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780644727; x=1812180727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c30wbulhkBn1BOKZ95h66WcDcHsR2Lig8B6kzzR9otg=;
  b=SGZhrs/NfcpcCcqV3uRHFGGg+wyRaQlgJsWM3upHHww90ue67+lQDMBd
   ZsmRSSOc33GM4VM9AsyTuBhhnV7MAH7xc2dqXbElIG8TGOdRNQTaFds3r
   n+6NamFDPmklFUc3GIiDadql2qpWu4ARQrWn1130ZLqyZHtZG+i/R4Xef
   1avlRLuGqciRhbLkSCHepAJEPKle+epn4jqQlzep4z1niyBIoi+UNi68s
   FGLgThZnY/fmZyDtFDvW4/Il453EtwvdQTQ3YLizReE4S120cS0sKLXQH
   EHI0KTusI7l2arMH0SA25vxbYJUAno6dDkYRfQjR27rUumN5sbB0Vczyb
   g==;
X-CSE-ConnectionGUID: EIBuMG3eSeyjAKKtOweGZg==
X-CSE-MsgGUID: /0xCisKmTq2pYVBW821L0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="69012007"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="69012007"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:32:05 -0700
X-CSE-ConnectionGUID: dgmCPLzkTKmMjNLLI2/dBg==
X-CSE-MsgGUID: q1Bd7HPvQi+WKekTT+SBKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="249704712"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:31:50 -0700
Date: Fri, 5 Jun 2026 10:31:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Peter Chen (CIX)" <peter.chen@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Lee Jones <lee@kernel.org>,
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
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	driver-core@lists.linux.dev, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 20/23] usb: chipidea: use
 platform_device_set_of_node_from_dev()
Message-ID: <aiJ7ZB-J-TyJEwBb@ashevche-desk.local>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-20-88c324a1b8d2@oss.qualcomm.com>
 <ah9P6Xt9SyKgc2oJ@ashevche-desk.local>
 <CAMRc=MdhjZhGL9tEx9WEjn2f95d=ObNM0AtBNpcevm6aHgpj+Q@mail.gmail.com>
 <aiJz6Ys4gE998ULp@nchen-desktop>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiJz6Ys4gE998ULp@nchen-desktop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 02:59:53PM +0800, Peter Chen (CIX) wrote:
> On 26-06-04 08:34:16, Bartosz Golaszewski wrote:
> > On Tue, 2 Jun 2026 23:49:29 +0200, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> said:
> > > On Thu, May 21, 2026 at 10:36:43AM +0200, Bartosz Golaszewski wrote:

...

> > >>  	pdev->dev.parent = dev;
> > >> -	device_set_of_node_from_dev(&pdev->dev, dev);
> > >> +	platform_device_set_of_node_from_dev(pdev, dev);
> > >
> > > Why do they even do that? Do they have a USB connected pin control?
> > 
> > I don't know. I can't test it so I don't want to break it. If they don't need
> > it, the person who can test it, can remove it later.
> 
> It was introduced by below commits:
> 
> commit 0f153a1b8193ce768be4df0400aeb2c8f2a3b3da
> Author: Rob Herring <robh@kernel.org>
> Date:   Wed Dec 15 16:56:46 2021 -0600
> 
>     usb: chipidea: Set the DT node on the child device
> 
>     The ChipIdea glue drivers just copy the glue resources to the "ci_hdrc"
>     child device. Instead, set the child device's DT node pointer to the
>     parent device's node so that platform_get_irq() can find the IRQ
>     resources in the DT. This removes the need for statically populating the
>     IRQ resources from the DT which has been deprecated for some time.

This doesn't explain why the node marked as reused. device_set_node() fits
the above description. Rob?

-- 
With Best Regards,
Andy Shevchenko


