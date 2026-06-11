Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE4A1F5821;
	Thu, 11 Jun 2026 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167076; cv=none; b=NDvC0mJ05xZ2sI+F0W6vvCbRczb9hKJhfPtPuFFOcDY+z7SMQdFbU71hwvL8yF5T599S2VtKkYq2KZWsk/ltp0ttgN+moOzjD7jR//hGb9XCtZL1PtM5gjifTIrdhuKUCrQaxVi9drz3R1VmFFQ5YsF1ksiWD4dYlsThZtdSYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167076; c=relaxed/simple;
	bh=Ai4mXzWajtLKC33BxFXRCMf6dWYQxHfjWVW663QbhRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGvoZHXC1uZOLtbBR7/Gmt7oqzoL1MVvvetl4bq8GffZ8fDGG79qAxd2eY+F7QE9xJRwFTo/onmT5Wva7AxhpTUJ37MQa0e8hO8hOuywWasUCncM+JWqai1cFiw/vgIxJIGe/e7BCSZC8HhRRkIO3z9/iVZ3aQBQyqvhRTOa8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9Z07Kot; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9Z07Kot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781167075; x=1812703075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ai4mXzWajtLKC33BxFXRCMf6dWYQxHfjWVW663QbhRU=;
  b=S9Z07KothLAUTAqSlSnfPoAICzGqie+6q8AdqoHkKEITBiagZZkmYIUz
   BNp2Y2z+qyOleHB9RIbYGPgYCJY67RNCpbFWn7T6e86/A3cvB3D+byGDA
   GgL+lJXHw/qYyOC6wqszIZ0ZiKhE/9BPFsLYX3TsvSXZg9fB9EE3JHT32
   3mh5ruOPL+TucF4jI80WVA92usBk/A3DKJVkNSDAlzA5Hk0qDh2AgxGd3
   CQf1lR36Orvy5+gLludeY6ZkRC5bxLB2dGBsbn5iC7zwnzLueOy03HVIa
   pdDEH7U5gxBjEca78G69JyMSeEtSjjrTwKPhBbD49m/hXooPQNsYmaw5p
   g==;
X-CSE-ConnectionGUID: U9BfQpHIQr6wuHuLOkAohg==
X-CSE-MsgGUID: ToHX3x03Rl2Vh4swPY1DBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93363398"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="93363398"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:37:54 -0700
X-CSE-ConnectionGUID: DG4C+DU7RLqPDacCZUSHiA==
X-CSE-MsgGUID: dJFo0kyiSgO0ryNVI1csHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="241987912"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 01:37:49 -0700
Date: Thu, 11 Jun 2026 11:37:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	Manivannan Sadhasivam <mani@kernel.org>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 05/16] usb: hub: Associate port@ fwnode with USB port
 device
Message-ID: <aipz2zMFcdnZYTxS@ashevche-desk.local>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-6-wenst@chromium.org>
 <ailxrP-_9_NL8qnN@ashevche-desk.local>
 <CAMRc=MdiwQM6yk8FXcc+RisVP2iqWKWzVsn2-Yy6dyJXt-1X=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdiwQM6yk8FXcc+RisVP2iqWKWzVsn2-Yy6dyJXt-1X=Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 04:20:58AM -0400, Bartosz Golaszewski wrote:
> On Wed, 10 Jun 2026 16:16:12 +0200, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Wed, Jun 10, 2026 at 04:40:39PM +0800, Chen-Yu Tsai wrote:
> >> When a USB hub port is connected to a connector in a firmware node
> >> graph, the port itself has a node in the graph.
> >>
> >> Associate the port's firmware node with the USB port's device,
> >> usb_port::dev. This is used in later changes for the M.2 slot power
> >> sequencing provider to match against the requesting port.
> >
> > Okay, would this affect ACPI-based systems? if so, how?
> > Can you elaborate on that, please?
> 
> Is it possible that there's an ACPI device node associated with the port like
> on some DT systems? I don't think so and there should be no impact IMO but I
> also don't know enough about ACPI.

The API is agnostic. There is a possibility to have software nodes associated
with the port. I think the best is to be sure that ACPI-aware people who are
experts in USB will check this (Heikki?).

Also note Sashiko complain on reference count leakage.

-- 
With Best Regards,
Andy Shevchenko


