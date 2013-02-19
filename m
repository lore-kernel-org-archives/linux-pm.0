From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH 2/9] hwmon: (lm90) split set&show temp as common codes
Date: Tue, 19 Feb 2013 15:56:49 -0700
Message-ID: <51240331.7080604@wwwdotorg.org>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-3-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:58932 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933463Ab3BSW4w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Feb 2013 17:56:52 -0500
In-Reply-To: <1361187031-3679-3-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: durgadoss.r@intel.com, rui.zhang@intel.com, MLongnecker@nvidia.com, khali@linux-fr.org, devicetree-discuss@lists.ozlabs.org, linux-tegra@vger.kernel.org, lm-sensors@lm-sensors.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.orgrs.org, linux-arm-kernel@lists.infradead.org

On 02/18/2013 04:30 AM, Wei Ni wrote:
> Split set&show temp codes as common functions, so we can use it directly when
> implement linux thermal framework.

> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c

> -static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
> -			  char *buf)
> +static void _show_temp8(struct device *dev, int index, int *temp)

This function now seems to be "get" not "show". If you rename it to e.g.
"get_temp8", then you won't need to use an _ in the function name. If
that name causes conflicts with later patches, perhaps "read_temp8".

> -static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
> -			 const char *buf, size_t count)
> +static void _set_temp8(struct device *dev, int index, long val)

Similarly, perhaps "write_temp8"?

Similar comments for the rest of the patch.
