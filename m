Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3532B9A1;
	Wed, 10 Jun 2026 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102012; cv=none; b=H7pUzxfy6GqNbeb2NMQTwF4GXm3UXHdh4w7ouqHyzH/04yl7yhY3gwqgDAPGmcQm3/Xe2zumV3U81qwK1kUDArdzRm00tp7C4yYhhqubiRvRtayfYlyKOEfzq2YnOkfXUkBdTveXmJhzJKz29uBkKX0gbxL4nPWdIWvejNe/cAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102012; c=relaxed/simple;
	bh=nbSpTI+NEem/B8QHO4h+hdqb3YdpkqnxeBRh6LClmIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EK2ZQLvO1pDyFRmQwnL2irxlrqw1EOIlZwC0WEbCxJ9Hxj5VGJ1+cfARtcBqdv7rVFq5L0coOvSLL0yob8ZTYa80oCfjYYea4KX8it1WWlH7DPOK+UVe9JWV/PcJneDbCIlrdaL4pXxmu4OjD4Ej2ltNwppd6DZB0WPCd5uxb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5WLT4kU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5WLT4kU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781102012; x=1812638012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nbSpTI+NEem/B8QHO4h+hdqb3YdpkqnxeBRh6LClmIU=;
  b=X5WLT4kUMOo1wWzZcKmVy5Jj4rem6G8ot/7Fb6V13KL0tbAPQCmubGPK
   MvqEuCySm6kN72zsExWep/qCjT710X9cOKizj6MCKY1tWC0qjK++BIDAY
   f6r2s3/xiUl8uFsIAmsKPJ/bIHhf9bpfS90wUYwckNEUn1p2Cad0fX038
   TjMBzWPH70dmF2fNEt/wrGHFiDwbQo6YQNRJISXNOz660vxTloBcUFtMN
   au7KRHESa+dc6FuxSkyICUx8hMWidh226XrDx336b2G7rXreX2cdw7HtS
   OYmkKFo7CgHCiGrOzitY1FV3O/7FU8WlP0S8krPxO8KQjW8YozMxHdgzU
   g==;
X-CSE-ConnectionGUID: +EG2NPQCQ6il0PeDC6kYaw==
X-CSE-MsgGUID: 9k/lZGs4QNCp99jLIWae2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81742953"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81742953"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:33:29 -0700
X-CSE-ConnectionGUID: H8GN1TzCTVSABF/VcR68RA==
X-CSE-MsgGUID: 4X+ZiRtBQHWMqwM+SsXzmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="284277249"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 07:33:23 -0700
Date: Wed, 10 Jun 2026 17:33:20 +0300
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
	Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2 10/16] power: sequencing: pcie-m2: support matching on
 remote "port" node
Message-ID: <ail1sAxgh5Xtkj2y@ashevche-desk.local>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-11-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610084053.2059858-11-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 04:40:44PM +0800, Chen-Yu Tsai wrote:
> A USB hub can have multiple ports, and this driver needs to
> differentiate which port is being matched to. The USB hub driver now
> associates the "port" node with the usb_port device, so here we can
> use the remote "port" node to check for a match. Then fall back to
> the remote device node for the other connection types.

...

> +		if (remote_port && remote_port == dev_of_node(dev))
> +			return PWRSEQ_MATCH_OK;
>  		if (remote && (remote == dev_of_node(dev)))
>  			return PWRSEQ_MATCH_OK;

We have device_match_of_node() IIRC the name of that API.


-- 
With Best Regards,
Andy Shevchenko


