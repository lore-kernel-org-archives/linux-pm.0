Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED182D593E;
	Thu, 11 Jun 2026 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192945; cv=none; b=e8GWWi++dVddA7I1YqDtwYTSp9JslS0dLKju8ODyhnLQli/7KKYxeup1NPb7W50Df2TOD0trqD4V81nSPshtvTMhD324OwesLEIn9nx4hq1VvIHL6de7kK05hJAvB3caoh6kb5sb4e0DLRYwV3dGg294naKmm11hP6U0pK9h2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192945; c=relaxed/simple;
	bh=eEPYqYwCfV36F7DpKmyY/mBn0JlkcYgtEybyysUnTek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yc0S3n5zoBwjPjrn7Y6FqDg2KKSnQ8hUJmDs4jHexwQMDrJcvlNpfyXd4h0zmxoDkNrABKGggCUE+po9YC1BLEgA1Rwk71zDiolE4fBxBVehbY0KBviSovSUHbIp2bq4hbwsTvxUBeEOH2/Ql1VUuBI6sjEYu1yala6VKIQWYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KerxuCzC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KerxuCzC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781192945; x=1812728945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eEPYqYwCfV36F7DpKmyY/mBn0JlkcYgtEybyysUnTek=;
  b=KerxuCzCSCGOULJrphchYQHaCY5UAt0HQBcM4Ji8iAxMpptujUtIOTsL
   YFxYbGvdD9fo5vtD4UHNeg1OWRZCT8gaE7WiZjF7HnIbuK8olivXR7JE3
   ewYKF265iQ6Rb5cJHHZZfGPPIUxyY6Jzpkn84NmwEisXOJAFoZw3seXBA
   TJIJxdeh6HXoCm9N+tiqLlhhugXRh31tCZRPT9DL6BpER6xiBE90O92qi
   p8erfoFkGYYe6RSM5KqM6JtZxknt01kiZ+ssnJwEu2ymCPFLQxnRz7YFX
   Q4x+VaZRvh5qxuWOCcZRJCyV/YgUnVFTpTNizLppGysQ3EoVebuFw36AJ
   Q==;
X-CSE-ConnectionGUID: Fsbzy/hlREKxhLEylEHGow==
X-CSE-MsgGUID: wXGBiF4mTKCI6WlccaMAyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82200640"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82200640"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 08:49:04 -0700
X-CSE-ConnectionGUID: vgWRVW9xQsScdhid1DOZgw==
X-CSE-MsgGUID: Z/YOgAYiTEymviQBo+GIyw==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 11 Jun 2026 08:48:59 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id E591098; Thu, 11 Jun 2026 17:48:57 +0200 (CEST)
Date: Thu, 11 Jun 2026 18:48:56 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
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
	Manivannan Sadhasivam <mani@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 05/16] usb: hub: Associate port@ fwnode with USB port
 device
Message-ID: <airY6IMz2KFz_z9j@kuha>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-6-wenst@chromium.org>
 <ailxrP-_9_NL8qnN@ashevche-desk.local>
 <CAMRc=MdiwQM6yk8FXcc+RisVP2iqWKWzVsn2-Yy6dyJXt-1X=Q@mail.gmail.com>
 <aipz2zMFcdnZYTxS@ashevche-desk.local>
 <CAMRc=MdRN7YitmMX8PknbzLh+MdsWm+dDg0MLtCVYOorqNobTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdRN7YitmMX8PknbzLh+MdsWm+dDg0MLtCVYOorqNobTw@mail.gmail.com>

On Thu, Jun 11, 2026 at 11:35:13AM +0200, Bartosz Golaszewski wrote:
> On Thu, Jun 11, 2026 at 10:37 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Jun 11, 2026 at 04:20:58AM -0400, Bartosz Golaszewski wrote:
> > > On Wed, 10 Jun 2026 16:16:12 +0200, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> said:
> > > > On Wed, Jun 10, 2026 at 04:40:39PM +0800, Chen-Yu Tsai wrote:
> > > >> When a USB hub port is connected to a connector in a firmware node
> > > >> graph, the port itself has a node in the graph.
> > > >>
> > > >> Associate the port's firmware node with the USB port's device,
> > > >> usb_port::dev. This is used in later changes for the M.2 slot power
> > > >> sequencing provider to match against the requesting port.
> > > >
> > > > Okay, would this affect ACPI-based systems? if so, how?
> > > > Can you elaborate on that, please?
> > >
> > > Is it possible that there's an ACPI device node associated with the port like
> > > on some DT systems? I don't think so and there should be no impact IMO but I
> > > also don't know enough about ACPI.

There are device nodes for the USB ports in ACPI, and I think they get
always assigned in drivers/usb/core/usb-acpi.c.

> > The API is agnostic. There is a possibility to have software nodes associated
> > with the port. I think the best is to be sure that ACPI-aware people who are
> > experts in USB will check this (Heikki?).

I can't say what's the impact from this patch - I'm not an expert with
this side of USB. Is there a danger that we end up overwriting the
ACPI node for the port, or something else?

> Even if there is a software node - it shouldn't really matter. It will
> just be assigned to the port device.

thanks,

-- 
heikki
