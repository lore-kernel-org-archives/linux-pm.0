Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741323B5846;
	Tue, 16 Jun 2026 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603348; cv=none; b=abNt9fydkX3mrt6yYLEJR1x6vplM9mHh8Av1wfEYCXF8V7gDZcidmfsLKYTknfCW9SlQ8ZoSemXRqJilb4DLEdOmyx+2C8QrO6s2+0O9lzEugCqf2kKTuO1kJcVFBm1q0HGdomY2Q2zfriFbvGTVC5a+IYjemaE9vu7SNt+2qAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603348; c=relaxed/simple;
	bh=jiLEocxNQBK6GjMpzXPf7ZOCUOSYAPAZ38ELX1lscIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o30p7rSRpQ56ZjJBHihA1IwtZPs+FnrabTRmD0O/occtMRORzILny7r6UKYFtowXt4B7gGrH7sh3IDWAkNrshnwS/c9RDadP5nQ5HHYmoIOruK9Z7TcAivR7am5xFkPFUYMOiRdCZjVKY/Zfq1qeabk3Dq2ejTl5nvweQDTs+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbLNPnAo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbLNPnAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781603348; x=1813139348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jiLEocxNQBK6GjMpzXPf7ZOCUOSYAPAZ38ELX1lscIw=;
  b=nbLNPnAob3BkNkA47PDUnSjfnra8Igumnyc2w9WR4aY+GGU9VlF5QkJT
   MOeHYrl/s0B5N8itYeOo9wvSRkih5hPZm01Mb4IiGDrDpppQDUEKgzGyy
   FooBq+TB9EEW0ywxQPAimj/CXwIHU4t98dxlMMPxeYMuiXzR/mcv5Knik
   V39ieRR6EQfEqc1fSuk5RT7Jsau7XnDd9dJ9kHoPhe04po1GKrByX44Lc
   NxkowA8uumhG/W5AMlxjaaQfe7KId2syd4QsZssaBapvFT3SosLyfOlpz
   /84+mwI3NMacH9s8QP1H7Z7ITUcWo7viMpA7vz65SYgys4QK4K0S9UTHH
   A==;
X-CSE-ConnectionGUID: AxNcf0vpQDuQS6mkZwzzWQ==
X-CSE-MsgGUID: gGZawzcvT0WqqXJVH/xvNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86265553"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86265553"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 02:49:07 -0700
X-CSE-ConnectionGUID: XVg//dqXQqi8918oDLukJQ==
X-CSE-MsgGUID: EE0dTLFuQNKgd0mpuJkkDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="246843978"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 16 Jun 2026 02:49:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6626895; Tue, 16 Jun 2026 11:49:02 +0200 (CEST)
Date: Tue, 16 Jun 2026 11:49:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Lee Jones <lee@kernel.org>,
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
Subject: Re: [PATCH 07/23] driver core: platform: provide
 platform_device_set_fwnode()
Message-ID: <ajEcDq0S067wMFaK@black.igk.intel.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-7-88c324a1b8d2@oss.qualcomm.com>
 <ah9OIVyrHEhcMHzN@ashevche-desk.local>
 <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McLN9Ovoqo3om-3uC=q+=rcKCoiWMctC=yvwiaHacU0PQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jun 04, 2026 at 05:32:27AM -0700, Bartosz Golaszewski wrote:
> On Tue, 2 Jun 2026 23:41:53 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Thu, May 21, 2026 at 10:36:30AM +0200, Bartosz Golaszewski wrote:
> >> Provide a helper function encapsulating the logic of assigning firmware
> >> nodes to platform devices created with platform_device_alloc(). Make the
> >> kerneldoc state that this is the proper interface for assigning firmware
> >> nodes to dynamically allocated platform devices. This will allow us to
> >> switch to counting the references of the device's firmware nodes in the
> >> future, not only the OF nodes.
> >
> > But why different for of_node and fwnode to begin with?!
> 
> I'm not following. What are you suggesting?

After re-reading of this thread, I think I'm suggesting the same what you have
in plans to do in the future as you put it as "This will allow us to switch to
counting the references of the device's firmware nodes in the future, not only
the OF nodes."

// Offtopic
I haven't heard from you for more than a month on this:
https://lore.kernel.org/r/af18zdP5HF3_P9Vo@black.igk.intel.com
Anything should I do? Please, answer to that thread.

-- 
With Best Regards,
Andy Shevchenko


