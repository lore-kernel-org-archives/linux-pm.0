From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/8] Thermal: Create sensor level APIs
Date: Tue, 18 Dec 2012 03:13:22 -0800
Message-ID: <1355829202.19706.28.camel@joe-AO722>
References: <1355822977-4804-1-git-send-email-durgadoss.r@intel.com>
	 <1355822977-4804-2-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:51730 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754011Ab2LRLNX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 18 Dec 2012 06:13:23 -0500
In-Reply-To: <1355822977-4804-2-git-send-email-durgadoss.r@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Durgadoss R <durgadoss.r@intel.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hongbo.zhang@linaro.org, wni@nvidia.com

On Tue, 2012-12-18 at 14:59 +0530, Durgadoss R wrote:
> This patch creates sensor level APIs, in the
> generic thermal framework.

Just some trivial notes.

> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
[]
> +static ssize_t
> +sensor_temp_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	long val;
> +	struct thermal_sensor *ts = to_thermal_sensor(dev);
> +
> +	ret = ts->ops->get_temp(ts, &val);
> +
> +	return ret ? ret : sprintf(buf, "%ld\n", val);

I'd much prefer the form

	ret = ts->ops...
	if (ret)
		return ret;

	return sprintf(buf, "%ld\n", val);

Otherwise, maybe use gcc's pretty common ?: extension
	return ret ?: sprintf(...) 

[]

> +static int enable_sensor_thresholds(struct thermal_sensor *ts, int count)
> +{
> +	int i;
> +	int size = sizeof(struct thermal_attr) * count;
> +
> +	ts->thresh_attrs = kzalloc(size, GFP_KERNEL);

kcalloc

> +	if (!ts->thresh_attrs)
> +		return -ENOMEM;
> +
> +	if (ts->ops->get_hyst) {
> +		ts->hyst_attrs = kzalloc(size, GFP_KERNEL);

kcalloc here too



