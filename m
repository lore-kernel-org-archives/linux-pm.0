Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC3372ECA;
	Mon, 10 Aug 2026 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350380; cv=none; b=dV7XQwsivyeW1L6XH3EVFBA2DwVtekK+wTb27kJxmdF2dWXdH3umZFUxRSMp8xvPaifgzjCqkdq23gaiwwHi8UpQJl7rzZf9bGbhLkrjZlsEsPHR29KQKFBe7LA6zuVHoJgmcXZENlNUzdMCs93/ToHdQlrfo4vN5CyM97K7nBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350380; c=relaxed/simple;
	bh=++vktebTJ+rMB1mZxjsv9rXUywIuN/HM5q3NZWWkCDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOMVRProNphX/FN/6fFJTBWzXtV/YM5otTM8LDiV/wCJCfzn8ff8dNEna3YwrdquM+kPIahyqvWsGYnTb6r67Hrti1TL89zsS5Q9tQ3WHQMPmfXpeOdMRHIRb/BKoQe+d+CtuKK+GY5EcepgYX7ucwsGsRVDZi5aJYE0EAQLTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGw3LkEI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGw3LkEI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786350377; x=1817886377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=++vktebTJ+rMB1mZxjsv9rXUywIuN/HM5q3NZWWkCDk=;
  b=kGw3LkEIhb1qSEvCx8J8I3ikVBcZoeW2Mbgt53AGvqwiXnffuKTGeWUT
   xx+uwmLYr+K9GrEjF9CjdWgYAuh/E6SfB+Xn7JugV+ufDc4wdzlB8F6ca
   qQ95ODqZiGaEHRbGIhzunV/9/RHnbVyFOWzSgva4tN/OojDiHt3jayf5d
   u4H59B1YvsIbB4SSkBqFAXYFcZzFlUFOR2P7nrh7LGymyOEXD/MVoyuDU
   Zd8hzvmHvZ8JggWaY+7fKRP8vDjxfY1GAGT0DAKLt3lD+yWYoITWn6yRk
   xD3m5I0crvs1GYUGwZKsCgSHDXk/bi+yCSwO/S7+GDUnf56+rBJS3hP8P
   Q==;
X-CSE-ConnectionGUID: gTeNF/4oQCiphq7jejFXsg==
X-CSE-MsgGUID: +8/N9mhRQ0ejfjZiNi24lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="85976392"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="85976392"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:26:16 -0700
X-CSE-ConnectionGUID: qsY+KBHKTJaaQy+CCw/B+w==
X-CSE-MsgGUID: UzhpxU54SZmz8vkYlnfovg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="264960575"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.104])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:26:11 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 137AA121197;
	Mon, 10 Aug 2026 11:26:09 +0300 (EEST)
Date: Mon, 10 Aug 2026 11:26:09 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
Subject: Re: [PATCH v7 01/16] device property: Add
 fwnode_graph_get_port_by_id()
Message-ID: <anmLIT--JrEvOaSs@kekkonen.localdomain>
References: <20260724084328.3943997-1-wenst@chromium.org>
 <20260724084328.3943997-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724084328.3943997-2-wenst@chromium.org>

Hi Chen-Yu,

On Fri, Jul 24, 2026 at 04:43:10PM +0800, Chen-Yu Tsai wrote:
> In some cases the driver needs a reference to the port firmware node.
> Once such case is the upcoming USB power sequencing integration. The
> USB hub port is tied to the corresponding port firmware node if it
> exists.
> 
> Provide a helper for this.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v5:
> - Dropped left-over declaration in header (Sashiko)
> 
> Changes since v4:
> - Added flags parameter so users can specify whether incomplete ports
>   are returned or not (Sashiko)
> 
> Changes since v2:
> - Moved "Return:" kernel-doc section to the end. (Andy)
> 
> Changes since v1:
> - New patch
> ---
>  drivers/base/property.c  | 29 +++++++++++++++++++++++++++++
>  include/linux/property.h |  2 ++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 9387bb83eb54..950defc0c55a 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1346,6 +1346,35 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  }
>  EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
>  
> +/**
> + * fwnode_graph_get_port_by_id - get the port matching a given id
> + * @fwnode: parent fwnode_handle containing the graph
> + * @id: id of the port
> + * @flags: fwnode lookup flags
> + *
> + * The caller is responsible for calling fwnode_handle_put() on the returned
> + * fwnode pointer.
> + *
> + * Does not return ports that belong to disabled devices or endpoints that
> + * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.

The function also does not return ports that have no endpoints. I don't
think it'd be very useful to do that either, instead this should be still
documented.

> + *
> + * Return: A 'port' firmware node pointer with refcount incremented.
> + */
> +struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode,
> +						  u32 id,
> +						  unsigned long flags)
> +{
> +	struct fwnode_handle *ep;
> +
> +	ep = fwnode_graph_get_endpoint_by_id(fwnode, id, 0,
> +					     flags | FWNODE_GRAPH_ENDPOINT_NEXT);
> +	if (!ep)
> +		return NULL;
> +
> +	return fwnode_get_next_parent(ep);
> +}
> +EXPORT_SYMBOL_GPL(fwnode_graph_get_port_by_id);
> +
>  const void *device_get_match_data(const struct device *dev)
>  {
>  	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 14c304db4664..01ea010cb2f9 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -505,6 +505,8 @@ int fwnode_get_phy_mode(const struct fwnode_handle *fwnode);
>  
>  void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
>  
> +struct fwnode_handle *fwnode_graph_get_port_by_id(struct fwnode_handle *fwnode, u32 id,
> +						  unsigned long flags);
>  struct fwnode_handle *fwnode_graph_get_next_endpoint(
>  	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
>  struct fwnode_handle *

-- 
Kind regards,

Sakari Ailus
