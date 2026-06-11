Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F4D379C5A;
	Thu, 11 Jun 2026 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204091; cv=none; b=Sg/xF3NfTZ8iT8Uq4JuLKOvqhSxjY63YpyZ5hepFel2E3XRqcXZfFcdAxuf8OJiS1ClIKWE0BybmooBhOsD/VAtXms0P8wfjyv5E+0e2pGk8s4FqUlQYZsruWReHQEfPssVzAZuBq4uRgTgfjrpWUVCxDh56APDLWXg7t/ligRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204091; c=relaxed/simple;
	bh=T54buALKRrnV/NkHhNnF9DYrF9mnjHeDsPLsjZLccVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFM7PhMtpFSCVJQUk7C+hL4PW1hF930nidbEyz8Y3sEcVuI3ksSBEh4vMfY/ey/x/pzmR6dLVdHc3D2RuOr6sYfe3OnbG9p/IJBn+nLr1rkT+arRAJ9RyHdF3dai8fI9fM4VGNX7PfVG9t4SRXMjNE1/z0i3japIT2xfysZohLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0+ZBT0n; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0+ZBT0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781204091; x=1812740091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=T54buALKRrnV/NkHhNnF9DYrF9mnjHeDsPLsjZLccVc=;
  b=K0+ZBT0nkOFcS8gaMxOMMP0Lb9pTVV6zWJ2CiHfsodGaZonTK8th1/Wk
   8ipifrAzbV/3CDmcJ8UwAGAslH+7S9JQks4cMWh5H9Jdi5nX0ItoAp4+T
   sewGv0VX/vbAxt3rbzgcF1J1gvmVARqxyXIHSLlBKgVgHCqIhJRg6IJfo
   psXOfnWHHb/paYKSSHVKfenMWg1rYfm0Ojv1ozYt9BbgJV/TDODTppeDx
   +vRWk1ABkCR++wQ6IFuARVqLQf+dQWasE9i49YwVz0cJavUMglzA6rrfO
   l8ysO56MxM69OCHGU4Pcm7upaxxvwUVg0BVn4U7/+CwEMCfnHvYuKoAYK
   A==;
X-CSE-ConnectionGUID: /XFFNp+7THWDROoJ7XkEVQ==
X-CSE-MsgGUID: +LisPtMbRwqvm/1XbrwxGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99606446"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="99606446"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:54:50 -0700
X-CSE-ConnectionGUID: 8c6VWJAfS46EAVViB8yt6A==
X-CSE-MsgGUID: zgLRcfSXSzCuoVc837orwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246654990"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:54:44 -0700
Date: Thu, 11 Jun 2026 21:54:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
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
Message-ID: <aisEccAOm3qoXjxd@ashevche-desk.local>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-6-wenst@chromium.org>
 <ailxrP-_9_NL8qnN@ashevche-desk.local>
 <CAMRc=MdiwQM6yk8FXcc+RisVP2iqWKWzVsn2-Yy6dyJXt-1X=Q@mail.gmail.com>
 <aipz2zMFcdnZYTxS@ashevche-desk.local>
 <CAMRc=MdRN7YitmMX8PknbzLh+MdsWm+dDg0MLtCVYOorqNobTw@mail.gmail.com>
 <airY6IMz2KFz_z9j@kuha>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <airY6IMz2KFz_z9j@kuha>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 06:48:56PM +0300, Heikki Krogerus wrote:
> On Thu, Jun 11, 2026 at 11:35:13AM +0200, Bartosz Golaszewski wrote:
> > On Thu, Jun 11, 2026 at 10:37 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Jun 11, 2026 at 04:20:58AM -0400, Bartosz Golaszewski wrote:
> > > > On Wed, 10 Jun 2026 16:16:12 +0200, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> said:
> > > > > On Wed, Jun 10, 2026 at 04:40:39PM +0800, Chen-Yu Tsai wrote:
> > > > >> When a USB hub port is connected to a connector in a firmware node
> > > > >> graph, the port itself has a node in the graph.
> > > > >>
> > > > >> Associate the port's firmware node with the USB port's device,
> > > > >> usb_port::dev. This is used in later changes for the M.2 slot power
> > > > >> sequencing provider to match against the requesting port.
> > > > >
> > > > > Okay, would this affect ACPI-based systems? if so, how?
> > > > > Can you elaborate on that, please?
> > > >
> > > > Is it possible that there's an ACPI device node associated with the port like
> > > > on some DT systems? I don't think so and there should be no impact IMO but I
> > > > also don't know enough about ACPI.
> 
> There are device nodes for the USB ports in ACPI, and I think they get
> always assigned in drivers/usb/core/usb-acpi.c.
> 
> > > The API is agnostic. There is a possibility to have software nodes associated
> > > with the port. I think the best is to be sure that ACPI-aware people who are
> > > experts in USB will check this (Heikki?).
> 
> I can't say what's the impact from this patch - I'm not an expert with
> this side of USB. Is there a danger that we end up overwriting the
> ACPI node for the port, or something else?

Exactly this one is my worrying, but I haven't checked the actual flow.

> > Even if there is a software node - it shouldn't really matter. It will
> > just be assigned to the port device.

-- 
With Best Regards,
Andy Shevchenko


