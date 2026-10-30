Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350664;
	b=t1+feQbsae7mZBoBfbUu/hXjXDecktn6O+CIvIGtX/VtkHjR1apSD/lY3DEfruEMLIIN
	 fbtESGnx43a3WghDCfBLaRZb0KJ7lHSCjLG7fh5Xx8zHtlBFAmQFhyDc4s8gM/YZz9hNM
	 yqqAw7gUqQqPQg5uPxKA+0Bk/CJeH3ZSXW8862i9DqCOrm2aZ+YfNCy9FbC0GW/dj56aB
	 EhpSMz+/xjSupRNeC5q9A/bMi2s9ldLUfLjl+5d3ZXa1Pj9NvI1Eh5J1xetMNaz88A2rS
	 nQKAZgHOHYnm9Opcq6fBYq1KkPIV2maHTex7ZpMoNsdPTw/mOKjCAtX9lFmn/ZohqDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350664;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eGH1sgh8fHcD1YzHQAXXHU+ICjz/GR3arUB8DIO7xaI=;
	b=cRd3WNwOcp82N+5BbTERaiFge8tLXG5fO7pmT+c6sA0tzejBPam8VXM8//xQOgosTrKS
	 56BeuPbnU3s48xNHPeuxG23ygMWm6IfZyIj+FBNNyJ08NkBrY7LaZT70D/hd6KGrTdk4g
	 NMIu48Ct4o+bHfwLY1rnXcCnxCr7qK05K7MgvOOa3Be8vKIAb5dXjG1MzrRGS9esHDfFg
	 lydQ0NwNOHsbMhZBxikzCNK/La7VlqPIO5pYvZvK4Kd8Zr+hQ4xPKyJhrGP0yg7IL8bBp
	 JKLw0y6kZ/Shp+AwfEx1tv9VTKf0u9aiCIrazfaZotqDCeQqOvIjjIlnnQz/SAI51uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L79pU4vW;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273FF606A31C;
	Fri, 30 Oct 2026 08:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 273FF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L79pU4vW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793350664; x=1824886664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XC9L0N0lGS0WxoaPGxJtRF+Dcu7w/yLaO4BtytOzzuQ=;
  b=L79pU4vW7uY7s26CgOQnkqh84RSv936RavEmcjrDTUnS4Siipvtjaxv9
   niC/LQALmZglumppct7FEwQIro1Gz/w674bkYPVoPpUs7WdYYrKj8S4dh
   pzbje3C7Tok8W3ejcrBifgXwizUFSAgAZknUyf1X1uEdKEqzYRhBhmM0u
   VNlUIdPpedishVRl3xlDdhyqLpVcFReAGuJNt3+ZcVVbHXOZqNHIQYCE2
   8QV4MERFL9+uvL8WvzD28keURSTx3+k6K3S4QyMJ7JQJlkHCDQlO1o6kH
   qSxXemxc78C/HhTKxmdFwkZvq4LJevHZJxeCyUkDpo2OWXghEEAascIs9
   w==;
X-CSE-ConnectionGUID: rsO5rGNMSNKICgyZGCqLdw==
X-CSE-MsgGUID: ZTeF+5WvTq2wwTAtPCe8dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1987135"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="1987135"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 01:57:43 -0700
X-CSE-ConnectionGUID: 2ZQs9CufQJ2aI+tvMlBntg==
X-CSE-MsgGUID: YTk54IPeRM2APeu2Ec1IKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5265993"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.19])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 01:57:35 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 2CDB9121B77;
	Fri, 30 Oct 2026 10:57:36 +0200 (EET)
Date: Fri, 30 Oct 2026 10:57:34 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Guan-Yu Lin <guanyulin@google.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, netdev@vger.kernel.org,
	imx@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
Message-ID: <auRb_r8ZSSU-eHZA@kekkonen.localdomain>
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>

Hi Frank,

Thanks for the patch.

On Thu, Oct 29, 2026 at 12:30:37PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> When CONFIG_PM is not enabled, all devices runtime PM state should be
> treated as active.
> 
> __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
> pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get().
> stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
> should return the same value as the stub pm_runtime_get(), which is 1.

Shouldn't the same change be done to pm_runtime_get_if_in_use()? It's
otherwise the same, except that it requires also the use count to be
non-zero.

-- 
Regards,

Sakari Ailus
