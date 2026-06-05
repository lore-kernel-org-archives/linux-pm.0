Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B63D6CDC;
	Fri,  5 Jun 2026 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671203; cv=none; b=ZGHcLIqKjZloftrs1PgD9Q4CgGHIgVyoaPL6AZClJ3KmW5XsAAAj2UYy914llQasQ6DCEZ1IigbXW8V4MCgkkoh7qKVh5PfC9p4cvhx6XSzhATLgI6R2exIzbDEetbdB/ugebOqLIg/7cfVc2lEZsEL73SKJ+/vL6jx0XjnzRtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671203; c=relaxed/simple;
	bh=S9VN2IMCqnREp7EhcUK1NJoNhMFd+IfW7xD2w5Raim8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/0gA9H4jB9w95nEwJKMbuj7sDHRsnQFGe4cVgLfBCDMofNxptZmLWr4aVyrDJdyXprvv2dnVZeXYV41Ut7BjCh/Pos8XI6br6ZSpA0hf/fZunerxkYPUg7EslUVW9rsb7K/HF6R2+CWLBd1k+XNp+gLXJ8JyQzHNPbrO/AqnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5F52p0+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5F52p0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780671202; x=1812207202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S9VN2IMCqnREp7EhcUK1NJoNhMFd+IfW7xD2w5Raim8=;
  b=E5F52p0+ucmhd7pnaA1s0YvFP4r6jZmWEp5YTLs+J7hRopPN46ZWTp6H
   eHOY7MjTeP5zXmBYBzh2Hs2jG0NCni8socwy7PRp4G3WDh095P/Cpyean
   PsWhgtvm4PAdwh+hCFGclmXUDu+WyyYha+XGCrLvvXeeuI8b2Gm7+PrDB
   kmO7Rt1zJ4bGXvUInLnCCvkn0LL2mjvT4y4/+d6meCOdDvjVL0Xw0HH6f
   SVqUnTuEx7ZbpdlzlVAyVNvs7sC9tV4aGXPpKS9snHz4e3mgEvWsEnM0I
   kC5lKzzwQJvUu/7pCtvNyu7tj1roKlFj3vW8tWehU+9yMw9lteHCR6I4/
   w==;
X-CSE-ConnectionGUID: VSc//moSRr2Lx6ZBEw5GTA==
X-CSE-MsgGUID: Or7/njWxTXaQmyhu0E0vOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81565337"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81565337"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 07:53:21 -0700
X-CSE-ConnectionGUID: p3R1KLajSt+9nt2FGUPoiA==
X-CSE-MsgGUID: dy03ihVLR16TJHMTwX8Gig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="282943735"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 07:53:07 -0700
Date: Fri, 5 Jun 2026 17:53:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
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
	Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: Re: [PATCH 08/23] driver core: platform: provide
 platform_device_set_of_node_from_dev()
Message-ID: <aiLi0KZskrCyEYO5@ashevche-desk.local>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com>
 <ah9O15bMlAYgSlHx@ashevche-desk.local>
 <aiK-EXwp_xhcbty9@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiK-EXwp_xhcbty9@hovoldconsulting.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 02:16:17PM +0200, Johan Hovold wrote:
> On Wed, Jun 03, 2026 at 12:44:55AM +0300, Andy Shevchenko wrote:
> > On Thu, May 21, 2026 at 10:36:31AM +0200, Bartosz Golaszewski wrote:
> > > Provide a platform-specific variant of device_set_of_node_from_dev(). In
> > > addition to bumping the reference count of the OF node being assigned,
> > > it also assigns the fwnode of the platform device.
> > 
> > Can we rather investigate the way how to make that of node reuse thingy
> > (which is used solely by pin control) differently and then drop this confusing
> > device_set_of_node_from_dev() call altogether?
> 
> No, that call is needed. See commit 4e75e1d7dac9 ("driver core: add
> helper to reuse a device-tree node") for details.

Bart fixes the problem with the platform driver. At the result this will be
the only device_set_node() + 'reused = true'.  As for 'reused' flag, the need
is only for pinmux/pin control stuff. The question here is if there is a better
way to make that 'reused' be done automatically without need of setting some
flag explicitly.

-- 
With Best Regards,
Andy Shevchenko


