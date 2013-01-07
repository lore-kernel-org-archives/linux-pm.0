From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 7/9] Thermal: Make PER_ZONE values configurable
Date: Mon, 7 Jan 2013 11:24:14 -0800
Message-ID: <20130107192414.GC4465@kroah.com>
References: <1357542806-20449-1-git-send-email-durgadoss.r@intel.com>
 <1357542806-20449-8-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42864 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074Ab3AGTYS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jan 2013 14:24:18 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so10740912pbc.19
        for <linux-pm@vger.kernel.org>; Mon, 07 Jan 2013 11:24:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357542806-20449-8-git-send-email-durgadoss.r@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, eduardo.valentin@ti.com, hongbo.zhang@linaro.org, wni@nvidia.com

On Mon, Jan 07, 2013 at 12:43:24PM +0530, Durgadoss R wrote:
> This patch makes MAX_SENSORS_PER_ZONE and
> MAX_CDEVS_PER_ZONE values configurable. The
> default value is 1, and range is 1-12.

Why would we ever want to change this?  Why make this configurable at
all, how is a distro supposed to set this value?

Shouldn't it be specified from the driver itself?

thanks,

greg k-h
