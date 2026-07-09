Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48CD3BB114;
	Thu,  9 Jul 2026 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593503; cv=none; b=KsaHhatiH1eLGWhHeoxC9U0XnX3/rqcHlj+32eldsikJXclzCyN83/NB9iOkopaqsYLi0QjMcIsF/eaAMCy6TIGUplbb9I3ZR0w+Nw1lK/27y/xtuGWRYSerzOA+dhTdubdbmonEzoSwYtJgKMLthXH6nXlDNicJRg1WZrZ6woE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593503; c=relaxed/simple;
	bh=iLiK3CTSDdvUowUyU7p7EgFeHFgaWNMld+MOAz5fmpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJsWHQ4GjFaq10GHlY8Q/4cPc2+EzwHYKX2qBCs/t2uRpxyRNcc8kOtBY85LotzWssTfoMX65K+NqTcHKxo6uVrUdILLORv5mK/EkLpSiZ7EGkQ1qb7i45eQ32R4w0kCc/sQgZc5Cafv+45A2R5wkGU9oIcQfk7Sb6wF2mEoocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/SX9Yim; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/SX9Yim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783593502; x=1815129502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iLiK3CTSDdvUowUyU7p7EgFeHFgaWNMld+MOAz5fmpk=;
  b=Q/SX9YimQ3gwVUZj0HWmPsJEgt7shcr4QvbvJ9QJ+idgYFhvLQb1uwtb
   hIEXEj8A5BiVzuAggFVJTyC+rZA/L0R18u/KiemXFxaJKJ4gfSSFBe9He
   i9kcUlg1Tuwtr2IQOrbWqba86gdcOPSBWWmEQW3bCKhQko8fLseYVxt/u
   5GyqplUB3xU89EcVRFQqbFC19atxfBxKjAqAfihShCj4kt6TV8RhzpLvG
   +vuMgVkBq61g8VMY9jFZ3ElKJ5Wq5G1lNTxStEVsgKn+8MvyvlLhFy/L5
   3REJbzjk5eNv36tJaJUAbn6Ay22J6WRDWi/2M51Q5ucrBcjur/rMbrhEk
   A==;
X-CSE-ConnectionGUID: yVgRLzbeRZ+gDZJubqYEZg==
X-CSE-MsgGUID: lS84q1QgRxmk/A25R4xrbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84149226"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84149226"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:38:21 -0700
X-CSE-ConnectionGUID: 9eSEoKOvQvKdFLKV0C3kuA==
X-CSE-MsgGUID: NW8U+aFdQuuqkVYYdWQYwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251896574"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:38:16 -0700
Date: Thu, 9 Jul 2026 13:38:14 +0300
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
	Alan Stern <stern@rowland.harvard.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4 07/14] usb: hub: Pass |struct usb_port*| to
 usb_port_is_power_on()
Message-ID: <ak96Fi4U3JJzbW3f@ashevche-desk.local>
References: <20260709095726.704448-1-wenst@chromium.org>
 <20260709095726.704448-8-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709095726.704448-8-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 09, 2026 at 05:57:12PM +0800, Chen-Yu Tsai wrote:
> usb_port_is_power_on() currently takes |struct usb_hub*|, but only needs
> it to tell if the hub/port is SuperSpeed or not.
> 
> In a subsequent change, usb_port_is_power_on() needs access to a pwrseq
> state tracking field in |struct usb_port|. Either structure can be used
> to identify whether a port/hub is SuperSpeed or not, as the field in
> |struct usb_port| is inherited from the hub:
> 
>     port->is_superspeed = hub_is_superspeed(hub)
> 
> Replace usb_port_is_power_on()'s |struct usb_hub*| parameter with
> |struct usb_port*| so a subsequent change can use it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


