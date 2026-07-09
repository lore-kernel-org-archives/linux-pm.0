Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB9D3FAE10;
	Thu,  9 Jul 2026 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593408; cv=none; b=ErxFjWFP7QM4Z2E6xNVBJZWLvrIz+ruCpHB6wCsvgcKzFhmmz3jaVvvpyuR6UumSTqCzJNQHje/5YcFRV30KD3PPzhpa2X4vvFPm/vN4LjQZcgv3hKQe4GXUvorIeqEtmzte4Ui9O/OV9HWTosaFmqe22+IhFykBjjSCGCFfPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593408; c=relaxed/simple;
	bh=sM/To+DTEc32STAWmbWoa4mxR1gafUH0Ew8jud2Bb6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKHSM8XnsyK9a+q0IAknVva8HEWVSGx2dUimSiopNdkRdb2OI/oAWI6ig9/ZvOmN9D41p0cwUXhiPbp7iMrCxueUNT0l91SDdNERCXu2CNapunIYUucN55qA++6XyfECc9vYvoLCMsPOy1ZD5IhSP5deGUxA07Fxi/A9+ACynsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bua0mjXM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bua0mjXM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783593408; x=1815129408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sM/To+DTEc32STAWmbWoa4mxR1gafUH0Ew8jud2Bb6E=;
  b=bua0mjXM47Lg5VIlNcyvznBOjLcjqQcEEQ4wacmSt+F0RV8lNCP7U73P
   Mn3xb7t9p2KKRC63biExgj0U23hsmHTB8Bh6otZmanmW+DCLlzIH2kOf0
   S0yAHmsd3505TQlTbCDMcbor09GTI6uEa11Bnqyng4KcAqawAQwLd+8RA
   Az00Lxpp0gbwNs7T1g92yj+eSXbr/Vm2lKHiRAgkUS1YZApOO29CChf4n
   oby/y0EPycoz6+CF/LBoZDien/jWAeH2ymtmhM67YCYvJG7kz4L6zqrud
   UcekR56BNrpKnvCCeLOj8nKyIdtgMWJLYWAXiBbXPerrXWkBaQJjd601t
   g==;
X-CSE-ConnectionGUID: GDi6Yu+ASYODYLCb8kcShg==
X-CSE-MsgGUID: g03hxAK4QYq7xv3A1wvLKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84128317"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84128317"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:36:45 -0700
X-CSE-ConnectionGUID: 5i2pH1kLQnmvne4XMmnt5g==
X-CSE-MsgGUID: aCmP89aeSLqKerWrRicZLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250148201"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:36:40 -0700
Date: Thu, 9 Jul 2026 13:36:37 +0300
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
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v4 06/14] usb: core: Move struct usb_port and related
 APIs to port.h
Message-ID: <ak95tdi31diPMTZ6@ashevche-desk.local>
References: <20260709095726.704448-1-wenst@chromium.org>
 <20260709095726.704448-7-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709095726.704448-7-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 05:57:11PM +0800, Chen-Yu Tsai wrote:
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +extern int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus);

Drop 'extern', it's not needed in a modern code (like 20 years?).

-- 
With Best Regards,
Andy Shevchenko


