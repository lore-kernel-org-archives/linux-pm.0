From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5/9] Thermal: Create 'mapX' sysfs node for a zone
Date: Mon, 7 Jan 2013 11:21:29 -0800
Message-ID: <20130107192129.GA4465@kroah.com>
References: <1357542806-20449-1-git-send-email-durgadoss.r@intel.com>
 <1357542806-20449-6-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49575 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab3AGTVd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jan 2013 14:21:33 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so10852656pad.5
        for <linux-pm@vger.kernel.org>; Mon, 07 Jan 2013 11:21:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357542806-20449-6-git-send-email-durgadoss.r@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, eduardo.valentin@ti.com, hongbo.zhang@linaro.org, wni@nvidia.com

On Mon, Jan 07, 2013 at 12:43:22PM +0530, Durgadoss R wrote:
> This patch creates a thermal map sysfs node under
> /sys/class/thermal/zoneX/. This contains
> entries named map0, map1 .. mapN. Each map has the
> following space separated values:
> trip_type sensor_name cdev_name trip_mask weights

sysfs file are always "one value per file".  This seems to violate that
rule, so please rework this.

thanks,

greg k-h
