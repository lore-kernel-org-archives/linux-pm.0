Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E33D411A;
	Fri,  3 Jul 2026 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084287; cv=none; b=ep9ARCvzZvyjoMQ9V+x4ChaE8Hq6xypKC9P5sUH/knTKjWGHZQJ6L0hLk88SXE48EwLgfwbkmZct+iP6egm52T+5n0c9UxsTuj0BasC1GhcMgN6Vh4yePI4zu3zSfAzVlPt1q17VG6kINPmaynEk6Zu+zcr2K/HNJ8M66EBhmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084287; c=relaxed/simple;
	bh=ur0KVXHfio32hANukgiS55qHcr/vid5LoYAKVA8ObVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNxSn+psdcFcJX5+dpYBL2tk7FiK5zRIc8CUM4SDqNnjCscnu3gu/q1Cs59MAO7ULujEVDMYGUGpZYBw+b9Twcbs2wfirB8/CJcBqeJzlXTPY7j/aTZemHvzZt5MSP40ha4ERFoxCjr5zRMjhMD97bDf3acZYcVtl0N7HOcqh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETgClG3D; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETgClG3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783084286; x=1814620286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ur0KVXHfio32hANukgiS55qHcr/vid5LoYAKVA8ObVY=;
  b=ETgClG3D1EQeMLFzmtw6vJIEQFE8TIwPEiURekGiPldrPWxoHi/qeK3l
   6e54VZYpGh2qCfzDpwHIN8vjmIViKDcuPyIuU0pEU/XUy67Sdkh2zo/ep
   xJa0DHXBoe5C9peQBBwh/Bup0XG4/rAbFtp5UNUWHwNNlRoN2WiF+/GOa
   oxhT0hrIGrBrtsTast0MvQigy7Y00RwG2viGVJTV+ZI6kUgUqf9bSPjJ8
   5lg5/fureaiBcjXAvq9F88lWjwHBPhtrq9BH9aFLQEHjFoF2S6Al7MG9d
   UXyZN35RQMCzIRfo3XyilCFLJ/nQuAWUwcNlggV3S9L17O7aT8YAzcKnE
   A==;
X-CSE-ConnectionGUID: MVh+SwvsTCigILiAZDb5gw==
X-CSE-MsgGUID: 7C+Rlq3XRa6zAZwkfc0y4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="84028535"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="84028535"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:11:25 -0700
X-CSE-ConnectionGUID: OtKHXtZxRy+HZdZh/F4u3A==
X-CSE-MsgGUID: 7twUTalZTUmLgv086/XQfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="248664397"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:11:20 -0700
Date: Fri, 3 Jul 2026 16:11:18 +0300
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
Subject: Re: [PATCH v3 06/13] usb: hub: Pass |struct usb_port*| to
 usb_port_is_power_on()
Message-ID: <ake09vk4fEv1D9QC@ashevche-desk.local>
References: <20260703110317.1283411-1-wenst@chromium.org>
 <20260703110317.1283411-7-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703110317.1283411-7-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 07:03:07PM +0800, Chen-Yu Tsai wrote:
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

At a brief look this will be the only function that takes usb_port
instead of usb_hub in the entire hub.h (I don't count container_of()
as a function). With that being said I would rather see it to be moved
to port.c altogether (yes, it's more invasive change, but looks more
consistent).  I would even dare to move struct usb_port (and container_of()
accompanied with that) and this function to port.h. This might require
a separate patch, though.

Perhaps something like: 1) "move struct usb_port and associated APIs to port.h";
2) "...this patch...".

-- 
With Best Regards,
Andy Shevchenko


