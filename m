Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF89430CC4;
	Wed, 15 Jul 2026 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107896; cv=none; b=KI+vxvz2aOQehz7IW8PsGv72F1wQHx20xahSulmIfsS/m+DNg/tKW6nrRtpRcmxuVBRO3YBquKCXxRgsrGUhKrAHMJTfjlSFSC4/F0fS2553nWfcb0rwe8NUjdDHNC/a27PfvlMaSDWUVPgQlIhApyJEgpjqQtZUrafdcN4bUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107896; c=relaxed/simple;
	bh=k4Mxr2b2uXcaPiH3l9mMz8keQUEPR+TLeMo54YK8SQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjmNEcoIawaTeOVGwX+qRJ7LfyNDi9BGZTpvHvUO/UBO7uLybAC3T3pB5jmXw9lYaZLIYRuMHX8WkcXYlDnU7FQwdz+wnFQ6Ggofn4WOPyoSwOrZ78Sc7yL7+s+vGydbK+AQGM0VfGlr/Y72BIrkKx+Dv27Z0l2QTnIpnqx4wWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBT8cc0+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBT8cc0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784107891; x=1815643891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k4Mxr2b2uXcaPiH3l9mMz8keQUEPR+TLeMo54YK8SQg=;
  b=JBT8cc0+MGyymQ1W7X4DBNeNGOoVi0Uy81MBS3lOHht4S/rW+qqGYKal
   ThJi5Lz1r1URxFHoTNrypsJOekCHyojgOCpDlYCucraEqf5fr8sFJ94NB
   NFr0joiwasXM+Tsa2GHuvfUikbUC0Ayxn8c0fvN+DpIePAZGUKGOLF/UO
   vKPINT02Ij/2zDhul5lJ37BwTPxFBNeIM6kAAhFQy5UgxDzqjB0dll7kW
   Kc66BfTFxGuE0UixzGC8frXAKwFS7ZCqzzThsnB43Oj/7YFn8USXaB6zt
   yqy9A3C1CR2q8ghdtIUaPHHKyzSZbHKJIRePtKLWXZKPHsTTss9OnT9jj
   g==;
X-CSE-ConnectionGUID: R3VZmNryRTiSxdQ2vGldmA==
X-CSE-MsgGUID: qnZMFrhLSKKNWQljNgxr2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84621796"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84621796"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:31:27 -0700
X-CSE-ConnectionGUID: C6gWwrZiQoSdjr4Qi+bgqQ==
X-CSE-MsgGUID: rexS2BC5TTm8ipg2rVuMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="255007837"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 02:31:22 -0700
Date: Wed, 15 Jul 2026 12:31:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 07/16] usb: core: Move struct usb_port and related
 APIs to port.h
Message-ID: <aldTZ3ni4Uk3eTO8@ashevche-desk.local>
References: <20260715085348.3457359-1-wenst@chromium.org>
 <20260715085348.3457359-8-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715085348.3457359-8-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 04:53:37PM +0800, Chen-Yu Tsai wrote:
> |struct usb_port| and its matching container_of() macro should live in
> its own port.h, matching the split we have for .c files.
> 
> Move them as described. Also move usb_port_is_power_on(), since in the
> next change its |struct usb_hub *| parameter will be changed to
> |struct usb_port *|, and becomes a non-static function that only
> references |struct usb_port|.
> 
> port.h is only included from hub.h, as a subsequent patch will directly
> use fields from |struct usb_port| in a static inline helper in hub.h.
> The USB internal headers don't have header guards to help with this.
> 
> Also drop 'extern' from the header declaration of usb_port_is_power_on().
> This is not needed in modern C.

...

> +struct usb_port {
> +	struct usb_device *child;
> +	struct device dev;
> +	struct usb_dev_state *port_owner;
> +	struct usb_port *peer;
> +	struct typec_connector *connector;
> +	struct dev_pm_qos_request *req;
> +	enum usb_port_connect_type connect_type;
> +	enum usb_device_state state;
> +	struct kernfs_node *state_kn;
> +	usb_port_location_t location;
> +	struct mutex status_lock;
> +	u32 over_current_count;
> +	u8 portnum;
> +	u32 quirks;
> +	unsigned int early_stop:1;
> +	unsigned int ignore_event:1;
> +	unsigned int is_superspeed:1;
> +	unsigned int usb3_lpm_u1_permit:1;
> +	unsigned int usb3_lpm_u2_permit:1;
> +};

A side note for the future development (no need to change anything here
right now). It might be that the layout is suboptimal and `pahole` might
propose a better one.

-- 
With Best Regards,
Andy Shevchenko


