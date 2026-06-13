Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED136AB54;
	Sat, 13 Jun 2026 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781355650; cv=none; b=H6v5O0uH502WLU0Qr3ecCO3aApnjMUoR8UhWuT3lrPs8wZQAFAp38y39SwpZRm59OSWB8OW9ZkK6Lo1Weqm+Bvv58RYPzmhADncTVVlgfXFOZ+IgsTDT+1gFPA4Ql2qPkwFKSDpSZQSQ/5tKtG2ZJSIxT/sEp1tkmouUQJQtCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781355650; c=relaxed/simple;
	bh=uxJGwCAsMcpFZ/9RNw7yRRDOB6tqapy/6259X4loI4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1RsAMWfrfDQwC5VQd2UE9Ni7K1oDCq77Q1fewfHUHWhQfY+0Ui6oQp3sRh1Ow7o11f/9oQDqtrGeHQnk0CU/gEuYglCmqqrR0pwnBhwmMsYJJZa6Nao747rCSEpsU9UrLJlP5vP8MBJEZ/Tt19FGeTwwoDuC32V9reaE3PKpmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfbbVgJl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfbbVgJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781355649; x=1812891649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uxJGwCAsMcpFZ/9RNw7yRRDOB6tqapy/6259X4loI4s=;
  b=FfbbVgJlaLbU7wDkIYebsv8aBoR+2+pqYmj+TnJT6WZXNw7CsISppw6D
   oAVTQFHS5TsWqiRZODMb5ED6eGI1oznW9mpUAFOPwhWXnFECPW8ZymwX9
   nnB/5EAcjQiQvhcEgtNJ2sUMJi0Vkk+qjaDfDP6TmOAmJZKoj1Fh0qqv0
   ndPPfYzJXrk2no3gxsRrPtwfufxbQxitRY1q1Kj6GK91yxdj81Jmv2ktM
   e18BZH+U+oVX6yWCRf2LCnRm6kpL0yOCdfcZHHQh1Vm5S8nIqBjklwkzf
   /S4uCJpcQF5+JmNozhaW1ftweeyUg8U4hAe7Zhm/3ul3/vcarq75+oX9v
   A==;
X-CSE-ConnectionGUID: M5kFuq2KQaKWxOiDFgqjVg==
X-CSE-MsgGUID: L76gAwg3TXSKaMOcJDIaug==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="82014780"
X-IronPort-AV: E=Sophos;i="6.24,202,1774335600"; 
   d="scan'208";a="82014780"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 06:00:48 -0700
X-CSE-ConnectionGUID: 9YFHfovRT2GI8xWhDYQGUA==
X-CSE-MsgGUID: xEQJQI/xSEusBaz11tHecg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,202,1774335600"; 
   d="scan'208";a="246931274"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.184])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 06:00:43 -0700
Date: Sat, 13 Jun 2026 16:00:40 +0300
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
Subject: Re: [PATCH v2 02/16] device property: Add
 fwnode_graph_get_next_port_endpoint()
Message-ID: <ai1UeO-BZQEEheml@ashevche-desk.local>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-3-wenst@chromium.org>
 <ailv8HpnrCH3Zb8C@ashevche-desk.local>
 <CAGXv+5EHHWfiWgqPpf-RMKoSQLc2cd9OA4Z36SNoL5C53kVh2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EHHWfiWgqPpf-RMKoSQLc2cd9OA4Z36SNoL5C53kVh2g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 12, 2026 at 04:20:18PM +0900, Chen-Yu Tsai wrote:
> On Wed, Jun 10, 2026 at 11:08 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Jun 10, 2026 at 04:40:36PM +0800, Chen-Yu Tsai wrote:

...

> > > +struct fwnode_handle *fwnode_graph_get_next_port_endpoint(const struct fwnode_handle *port,
> > > +                                                       struct fwnode_handle *prev)
> > > +{
> > > +     struct fwnode_handle *ep;
> >
> > Unused?
> >
> > > +     while (1) {
> >
> > This is usually harder to read and follow. It's like "pay much attention on
> > the code", but here no rocket science, no code to really pay attention to.
> >
> > > +             prev = fwnode_get_next_child_node(port, prev);
> > > +             if (!prev)
> > > +                     break;
> > > +
> > > +             if (WARN(!fwnode_name_eq(prev, "endpoint"),
> > > +                      "non endpoint node is used (%pfw)", prev))
> > > +                     continue;
> > > +
> > > +             break;
> > > +     }
> > > +
> > > +     return prev;
> > > +}
> >
> > So, this can be rewritten as
> >
> >         ep = prev;
> >         do {
> >                 ep = fwnode_get_next_child_node(port, ep);
> >                 if (fwnode_name_eq(ep, "endpoint"))
> >                         break;
> >
> >                 WARN_ON(ep, ...);
> >         } while (ep);
> >
> >         return ep;
> >
> > But also big question why? to WARN*(). There is no use in the entire
> > property.c.
> 
> Will drop. This function was lifted from drivers/of/property.c then
> adapted to the fwnode APIs, so it still has the structure of its
> origin. With the WARN() gone, rewriting it as do {} while() becomes:
> 
> do {
>         prev = fwnode_get_next_child_node(port, prev);
>         if (prev && fwnode_name_eq(prev, "endpoint"))

'prev &&' is not needed.

>                 break;
> } while (prev);
> 
> return prev;

-- 
With Best Regards,
Andy Shevchenko


