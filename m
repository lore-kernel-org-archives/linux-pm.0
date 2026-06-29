Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FFB36C9ED;
	Mon, 29 Jun 2026 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731660; cv=none; b=IT5s3gPJsCL/dGndLKjz3CLLsZjnXmVX5SrGiGyGyM59cM/R4oI/1PuKnkf9xxEWY8LmPnpXdk8GI1XIJlSB5gSKKB6uwCrS0YCzyvw7Eh0hDonMuumQD6hiZfaJxzWuN28yYAWZaw/DVtH0WKhFMPxRvEUg/vEFu6B1nYJwGNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731660; c=relaxed/simple;
	bh=gLqMN8vpA2AzELZ43hBji5CPMGlrPDZKkBk5U11/0oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1nKzsn8WWCSQ+gL2aISzFXs7Z868lgp9iiBxtg91K6IBlAOrAWi+TPbkyFvjei6m8eYkH7RMWFW2LfV4sOUGIjJJpsdYzRbFIKI6EKVHYN7622JaPW5oLmazDxrnCRV3+QEvpRgbDg2FnXWzXH2qFwcQSZ8Q1bmcyMQU9aVTsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVe7oLg/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVe7oLg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782731659; x=1814267659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gLqMN8vpA2AzELZ43hBji5CPMGlrPDZKkBk5U11/0oM=;
  b=WVe7oLg/3L0D38VeplokGcMGoEZOHGTnSHd4AINqNF9Lkl5XoITG7fcx
   4RwUUQZ8+rB7zsLkyNax46tQ7Ufdtp/01sDGZYbPm+VsGaPyJWK2J08D0
   pZ/tIVPUvjK8ZqKdQIkt1R3Fi03ZCAA1AKG5q52oOcGiJSjxxZyyGZh+G
   dXGJS8uIpn+Qe6yFaH47JtWgyCCI7K/prkwH13vRzGlsOPbd4GBqiEUwr
   Vsx+mJC4rxaYdBbVR7FqF077fmgy4Jha5KgaHaUGqJ1JA1sBSfxgopjFa
   uRITmic7nRuqIk900fFmoNJPH7LxZAZldh5skovZo9+QG/y/95nk3mcOq
   A==;
X-CSE-ConnectionGUID: yQ4Q0U71T4eL19V1aG5T8g==
X-CSE-MsgGUID: ErjZkmfiSmG53wLfn3Qi6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83290138"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="83290138"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 04:14:18 -0700
X-CSE-ConnectionGUID: NVYSf8rjSpKNO2Qk94jDzw==
X-CSE-MsgGUID: wKmi9k3IRtWOyVUpONdWzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="248569133"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 04:14:12 -0700
Date: Mon, 29 Jun 2026 14:14:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 07/16] usb: hub: Power on connected M.2 E-key
 connectors
Message-ID: <akJTgn0aZDtH04ij@ashevche-desk.local>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-8-wenst@chromium.org>
 <CAMRc=Mc3DqGb2MsvM4tjcqFuRraAO+EftO1UrtNFvR5dMRXmVA@mail.gmail.com>
 <CAGXv+5HQa9BH5wyVwKNxjXLEZDnE0sbeQjgNxwmAG+OF8bbz=w@mail.gmail.com>
 <CAGXv+5Gbf8+=hMZcK0pYraC1t4qmDx_WVPkr2RhWdm3bq_LZEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5Gbf8+=hMZcK0pYraC1t4qmDx_WVPkr2RhWdm3bq_LZEQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 02:46:42PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jun 12, 2026 at 4:55 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
> > On Thu, Jun 11, 2026 at 6:11 PM Bartosz Golaszewski <brgl@kernel.org> wrote:
> > > On Wed, 10 Jun 2026 10:40:41 +0200, Chen-Yu Tsai <wenst@chromium.org> said:

...

> > Yeah, instead we need
> >
> >     config USB
> >         depends on POWER_SEQUENCING && !POWER_SEQUENCING
> 
> FTR:
> 
> Somehow I remembered this incorrectly. It should be the following instead:
> 
>     depends on POWER_SEQUENCING || !POWER_SEQUENCING

We have depends on ... if ... expression nowadays for that kind of case.

> and the dependency issue mentioned below then goes away.
> 
> > But I ran into a dozen or so drivers that have "select USB", mostly
> > input devices:
> >
> >     config TOUCHSCREEN_USB_COMPOSITE
> >         tristate "USB Touchscreen Driver"
> >         depends on USB_ARCH_HAS_HCD
> >         select USB
> >
> > Kconfig complains about unmet dependencies.
> >
> > > I see Andy has some suggestions but in general I like this approach much better
> > > than adding the pwrseq_get_index() function. Thanks!

-- 
With Best Regards,
Andy Shevchenko


