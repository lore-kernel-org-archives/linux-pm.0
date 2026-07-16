Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D0376BD1;
	Thu, 16 Jul 2026 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223262; cv=none; b=JQrxQxg8YaKSy1skrSViAx/H5imArOjz9+P6+b7MFYbkSDyl6Cwxlg6gz4cRsQ+kP2OpBduUtLZelwfuxW4Qi+YK+p1xa2vLM7KWQSgZssyzGQWeuZJgXSHG5uk81kLXUkZzXJurvn5SRjZbFbO8RD6UINaH3GYDhx/TQBGaFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223262; c=relaxed/simple;
	bh=LdUVk/NYwiBLxejC3EguQWO9elJf87/PL/iYCAtTcfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjhTAbm9TWjHy+LZaaT5LLS6mbmpqZ0pKVPkZC5tZvA2iTPW+/fSKvQdmnv5nu5UnsaogLvjsaFBhi3ml403bS9XHdbeM6O5YR1zdjEpVp1D9cLSC2hJzhGjbYRFrR9sDhScJ2a/XswVU23cCJ0G5AV4fZlRy+alXmTQvNpzn0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKgCzg6D; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKgCzg6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784223260; x=1815759260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LdUVk/NYwiBLxejC3EguQWO9elJf87/PL/iYCAtTcfo=;
  b=mKgCzg6DcKtyYDsHoeqsXbHDrViEp97nshLRTEah6+ewLEyMLNM711NM
   vxNmN3yNxHsYsatOLZb3KF4ZKWpd+urNWxCzNbEE6WJfHNle3bdSGWyyz
   jmicErUrYh2TDFisdE001Q6pKH7DNGKxrtnnFvmVZwCOrm/jKOwYZlE/M
   2/UFGnh83NoX38556M7jC3rLuUGfog+xELfHvCwVtcOs7GziXPQK+pCkc
   k70kHQdYxrPzNFlP1N7dbXVLho3Odlxak0OtH4hVhIdlPpTdnwCayLEIG
   w/FVpeOJdA0Hs0h7uyUWkIFaMICrmU512F1FGAgbnYHA4+uNJXjd51Mh6
   g==;
X-CSE-ConnectionGUID: 1tWHmOtvT6qN278eTUd8tQ==
X-CSE-MsgGUID: NMDcAI4qR82H+tq4V8y9Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="85009567"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="85009567"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:34:19 -0700
X-CSE-ConnectionGUID: G088pS9JRWCNCTzsqTnKsA==
X-CSE-MsgGUID: jHS8gdqYTkewW49IH6KeVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="260157517"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:34:14 -0700
Date: Thu, 16 Jul 2026 20:34:11 +0300
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
Subject: Re: [PATCH v5 10/16] usb: hub: Power on connected M.2 E-key
 connectors with power sequencing API
Message-ID: <alkWE-bQ9gGIXIJj@ashevche-desk.local>
References: <20260715085348.3457359-1-wenst@chromium.org>
 <20260715085348.3457359-11-wenst@chromium.org>
 <aleKQKH2V-ck-SX6@ashevche-desk.local>
 <CAGXv+5Ed9Cn-NeHiXJ58er7NJs1P2ZUMrjqYac-gSky-TNV8Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5Ed9Cn-NeHiXJ58er7NJs1P2ZUMrjqYac-gSky-TNV8Lw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 06:02:38PM +0800, Chen-Yu Tsai wrote:
> On Wed, Jul 15, 2026 at 9:25 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Jul 15, 2026 at 04:53:40PM +0800, Chen-Yu Tsai wrote:

...


> > >       fwnode_handle_put(dev_fwnode(dev));
> > > +     /* usb_hub_create_port_device() could leave an error value */
> > > +     if (!IS_ERR(port_dev->pwrseq))
> > > +             pwrseq_put(port_dev->pwrseq);
> >
> > Hmm... I would rather make pwrseq_put() NULL and error pointer-aware, so
> > it will be no-op in such cases. But I think Bart has his own opinion about
> > this.
> >
> > >       kfree(port_dev->req);
> > >       kfree(port_dev);
> > >  }
> >
> > >               put_device(&port_dev->dev);
> > > +             hub->ports[port1 - 1] = NULL;
> > >               return retval;
> > >       }

...

> > > int usb_hub_create_port_device(struct usb_hub *hub, int port1)
> >
> > > +     port_dev->pwrseq = usb_hub_port_pwrseq_get(port_dev);
> > > +     if (IS_ERR(port_dev->pwrseq)) {
> > > +             retval = dev_err_probe(&port_dev->dev, PTR_ERR(port_dev->pwrseq),
> > > +                                    "failed to get power sequencing descriptor\n");
> > > +             goto err_put_kn;
> >
> > OTOH, how pwrseq can be non-NULL and at the same time port be created?
> 
> I assume by non-NULL you mean returning an error?
> 
> device_register(&port_dev->dev) is called some lines above this.
> 
> usb_port is weird in that usb_hub_create_port_device() does a bunch
> of stuff that is normally done in a driver's probe function. However
> usb_port's driver is just a stub driver add for userspace compatibility
> reasons. See commit d99f6b4130877 ("usb: rename usb_port device objects").
> 
> So at this point the usb_port device has been added to the driver model.
> Or we can just zero out port_dev->pwrseq instead? I guess that is cleaner
> than having some weird check in the release function.

So, why do we need to assign the error pointer to the field directly then?
Make a local variable and assign it if and only if there is no error pointer
in it. Would it work?

-- 
With Best Regards,
Andy Shevchenko


