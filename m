Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FDE3D9DB6;
	Fri,  3 Jul 2026 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085662; cv=none; b=u6tYJThEkZR56qwQrM+I5qLpO2BxIguIcsMw5OchixEqjjsj5QmU7avvU60KI5H49ki0DlPmXuaT39zr2YxkVkGmTb5H+M+s1YlChdUSCLxXUMZ6bh7H17whQEUqXAgRT4ELgWukD5L/WfBNhbBCxh4pY4ppxOJen3vBU+y3UEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085662; c=relaxed/simple;
	bh=+YDsaVWOUv1RxK+8utVxCX1+Gsf9vT/ItASTLwgreuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STMKzPnO7OCrDDHfCZnNSncbhkEi9mzdSrl2enPgTa4jWFPcG7MQdf690JMKplgKt+z0rgjh7zfrAbzhsb6/2jtk5aVDAnp0o8whd/C7M/DLp8lTvzkaM9MGPOxfQJAoIBFOeDCqKKqHOuUYKcITcw2zvHk77fAbOU/stGMly4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gj2ig/+L; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gj2ig/+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783085661; x=1814621661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+YDsaVWOUv1RxK+8utVxCX1+Gsf9vT/ItASTLwgreuo=;
  b=Gj2ig/+LV1aR0y7ZZplV5ve6G48G4O5jhfP2EBF+Q0wF2AW5NDsA2zat
   7hrXtCZRhyidwEfwrHovSGsQUVLRXQFMYLrXZUGSH4iOhbZrT4g8Fhce/
   cHnwjGgE1f0Fg+8hJbKJdNcCOO8zwuxzGGnOPKhNahM0YDn3iQLgFtzKg
   aVu9ch58/O5j9bqMgnMSxeyRxg7yli2hXvCIHPFebxyHK0MU3MCPE9KQj
   Y/4GZZfLd5tD6FXPDMaWH9wyEtp0CUUZwKRuqZxATs+UMvPWGOzuicwxW
   knqVBEN5dCLvKZYxmBDkb0EGTmChy9/bvkCwbPXOnFSFw8BD1LtxkFuXH
   A==;
X-CSE-ConnectionGUID: rvmhoqdmQn+5M/o8ziLsXg==
X-CSE-MsgGUID: lwr1tYhpT+il09UBx/ufCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101384505"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="101384505"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:34:20 -0700
X-CSE-ConnectionGUID: 3b2uYpljSmWfiHeJLiq6gA==
X-CSE-MsgGUID: RU0gKjNQTza5b8+Wtp7g7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="256690746"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:34:16 -0700
Date: Fri, 3 Jul 2026 16:34:13 +0300
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
Subject: Re: [PATCH v3 05/13] usb: hub: Associate port@ fwnode with USB port
 device
Message-ID: <ake6VXm9XTDr9d-W@ashevche-desk.local>
References: <20260703110317.1283411-1-wenst@chromium.org>
 <20260703110317.1283411-6-wenst@chromium.org>
 <akeyxn390mVmYo83@ashevche-desk.local>
 <CAGXv+5G3ETTGbgjWJCbQjn9yvRamx4GHPxjWPgmy_aXWUxm0iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5G3ETTGbgjWJCbQjn9yvRamx4GHPxjWPgmy_aXWUxm0iQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 09:25:56PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jul 3, 2026 at 9:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Jul 03, 2026 at 07:03:06PM +0800, Chen-Yu Tsai wrote:
> > > When a USB hub port is connected to a connector in a firmware node
> > > graph, the port itself has a node in the graph.
> > >
> > > Associate the port's firmware node with the USB port's device,
> > > usb_port::dev. This is used in later changes for the M.2 slot power
> > > sequencing provider to match against the requesting port.
> > >
> > > To avoid potential conflicts with ACPI firmware nodes and then causing
> > > power management issues, only assign the firmware node if the hub's
> > > firmware node is not an ACPI firmware node.
> >
> > Now I'm more confident that it does not mess up with ACPI case.
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thank you and Bartosz for the reviews.
> 
> FTR Sashiko pointed out that this is likely leaking a fwnode reference.
> I will add a fwnode_handle_put() call to usb_hub_remove_port_device()
> in the next version.

Ah, indeed. The _get call has to have its _put counterpart.

-- 
With Best Regards,
Andy Shevchenko


