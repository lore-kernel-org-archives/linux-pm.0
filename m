Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADB13624B7;
	Mon, 23 Feb 2026 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846463; cv=none; b=Bmx/3NNNeVUbIV+TCjpJqgENMRtVBb7+047WT80DyLGbEgpZBbu57V4eu0Z8K/Sz+HzTeEoTXsnC5q6iN+0DGNeiusEIkwv/86Cz0RBd1ktLhXT+mJZe/pF3zIyQD3KhzusYj+ENqgl1AGbkthPXgm67Ie2KsnXH1n5eYQKHkmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846463; c=relaxed/simple;
	bh=iDAMs2by9bj1uD5GcOuSsqTjHpLUeMUMQVPtg7eI0dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eS8wBFTTD8lX/tox4eyVwqXuGN/YYVfAAfNV558QWVILr7ATfGk+GIT2EBnVB0GmYwZNbT75VIffzbw6oiS5VCo83mciZ2jePxX+uwnvWZZpy4ljVDJetayKtzg8qotkM6N9a/NGDbiGvpMqgXK8ZACRkd4tud7+9IDf1wtAdqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6e0K+a9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6e0K+a9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771846461; x=1803382461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iDAMs2by9bj1uD5GcOuSsqTjHpLUeMUMQVPtg7eI0dY=;
  b=C6e0K+a96oh7AiecTaYkG5LnfEgrT8AbVFW7wt9FasWEM5uleuO9dGD2
   njnBVlbIXRGK6EbvSxiOaU4RCukGJ+/LUd+4hBKrbrDMT4V+pm1cg7PVA
   odThR7LfLFFtJPkFzef2bBobFsNHYtxEncW2exMoztmRd9cyHhi47Tn9v
   CFjH+IGy6px/tyr5s3SZde65otLLgXakw7/Bibqgt61Jj/yDzsrcBo46y
   3Wb+MAUSd00PcZAtXsMYYrbTRy7iwUscHuaV078uoK/VLIKAwEHgNgNKD
   kYpWq1yi0eCDov2rKwOBzcq7FerfNgmSWBDFYtkW+hfSpVJZvBJDuTMdB
   g==;
X-CSE-ConnectionGUID: s3JduAl6ShW/Edr+RYnmIA==
X-CSE-MsgGUID: BwosGBppSZCzVADLY+2uOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="95455000"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="95455000"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:34:21 -0800
X-CSE-ConnectionGUID: uc81lelzRSaazTvmw9TItg==
X-CSE-MsgGUID: 8/jJ6qoATta4FcN19+4Fig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="246140516"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:34:15 -0800
Date: Mon, 23 Feb 2026 13:34:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Tobias Schrammm <t.schramm@manjaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Dzmitry Sankouski <dsankouski@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, driver-core@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH 1/9] workqueue: devres: Add device-managed allocate
 workqueue
Message-ID: <aZw7NJOhkq6DlyZA@smile.fi.intel.com>
References: <20260223-workqueue-devm-v1-0-10b3a6087586@oss.qualcomm.com>
 <20260223-workqueue-devm-v1-1-10b3a6087586@oss.qualcomm.com>
 <aZwWMiYEvr3DXi3E@smile.fi.intel.com>
 <534a9d0f-600e-4162-a48c-f9797241dacd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534a9d0f-600e-4162-a48c-f9797241dacd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 11:18:41AM +0100, Krzysztof Kozlowski wrote:
> On 23/02/2026 09:56, Andy Shevchenko wrote:
> > On Mon, Feb 23, 2026 at 08:27:29AM +0100, Krzysztof Kozlowski wrote:

...

> >> +	ptr = devres_alloc(devm_destroy_workqueue, sizeof(*ptr), GFP_KERNEL);
> >> +	if (!ptr)
> >> +		return NULL;
> >> +
> >> +	va_start(args, max_active);
> >> +	wq = alloc_workqueue(fmt, flags, max_active, args);
> >> +	va_end(args);
> >> +	if (wq) {
> >> +		*ptr = wq;
> >> +		devres_add(dev, ptr);
> >> +	} else {
> >> +		devres_free(ptr);
> >> +	}
> > 
> > Why not using devm_add_action_or_reset()?
> 
> Where? Here? How the code would be simpler, exactly?

static void devm_workqueue(struct device *dev, void *wq)
{
	destroy_workqueue(wq);
}
...
{
	...

	va_start(args, max_active);
	wq = alloc_workqueue(fmt, flags, max_active, args);
	va_end(args);
	if (!wq)
		return NULL; // or ERR_PTR(-ENOMEM) on your choice

	ret = devm_add_action_or_reset(dev, ..., wq);
	if (ret)
		return NULL; // ERR_PTR(ret) on your choice

	return wq;
}

Compare to yours :-)

...

> >> +void devm_destroy_workqueue(struct device *dev, void *res)
> >> +{
> >> +	destroy_workqueue(*(struct workqueue_struct **)res);
> >> +}
> >> +EXPORT_SYMBOL_GPL(devm_destroy_workqueue);
> > 
> > Is this going to be used?
> 
> It is not used in this patchset, but most of devm-allocators have the
> cleanup.

-- 
With Best Regards,
Andy Shevchenko


