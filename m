From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2 7/7] thermal: export thermal_zone_parameters to sysfs
Date: Mon, 2 Mar 2015 14:17:51 +0000
Message-ID: <20150302141751.GA5756@e104805>
References: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
 <1424977233-15965-8-git-send-email-javi.merino@arm.com>
 <20150226212958.GB29288@developer.amazonguestwifi.org>
 <20150226220423.GA5451@developer.amazonguestwifi.org>
 <20150227171904.GA10658@e104805>
 <20150226221004.GA5564@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47220 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752511AbbCBORy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Mar 2015 09:17:54 -0500
Content-Disposition: inline
In-Reply-To: <20150226221004.GA5564@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, "tixy@linaro.org" <tixy@linaro.org>

On Thu, Feb 26, 2015 at 10:10:07PM +0000, Eduardo Valentin wrote:
> On Fri, Feb 27, 2015 at 05:19:05PM +0000, Javi Merino wrote:
> > On Thu, Feb 26, 2015 at 10:04:24PM +0000, Eduardo Valentin wrote:
> > > On Thu, Feb 26, 2015 at 05:30:00PM -0400, Eduardo Valentin wrote:
> > > > On Thu, Feb 26, 2015 at 07:00:33PM +0000, Javi Merino wrote:

[snip]

> > > > > +
> > > > > +static ssize_t
> > > > > +sustainable_power_show(struct device *dev, struct device_attribute *devattr,
> > > > > +		       char *buf)
> > > > > +{
> > > > > +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> > > > > +
> > > > > +	if (tz->tzp)
> > > > > +		return sprintf(buf, "%u\n", tz->tzp->sustainable_power);
> > > > > +	else
> > > > > +		return -EIO;
> > > > > +}
> > > > > +
> > > > > +static ssize_t
> > > > > +sustainable_power_store(struct device *dev, struct device_attribute *devattr,
> > > > > +			const char *buf, size_t count)
> > > > > +{
> > > > > +	struct thermal_zone_device *tz = to_thermal_zone(dev);
> > > > > +	u32 sustainable_power;
> > > > > +
> > > > > +	if (!tz->tzp)
> > > > > +		return -EIO;
> > > > > +
> > > > > +	if (kstrtou32(buf, 10, &sustainable_power))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	tz->tzp->sustainable_power = sustainable_power;
> > > > > +
> > > > > +	return count;
> > > > > +}
> > > > > +static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
> > > > > +		sustainable_power_store);
> > > > > +
> > > > > +#define create_s32_tzp_attr(name)					\
> > > > > +	static ssize_t							\
> > > > > +	name##_show(struct device *dev, struct device_attribute *devattr, \
> > > > > +		char *buf)						\
> > > > > +	{								\
> > > > > +	struct thermal_zone_device *tz = to_thermal_zone(dev);		\
> > > > > +									\
> > > > > +	if (tz->tzp)							\
> > > > > +		return sprintf(buf, "%u\n", tz->tzp->name);		\
> > > > > +	else								\
> > > > > +		return -EIO;						\
> > > > > +	}								\
> > > > > +									\
> > > > > +	static ssize_t							\
> > > > > +	name##_store(struct device *dev, struct device_attribute *devattr, \
> > > > > +		const char *buf, size_t count)				\
> > > > > +	{								\
> > > > > +		struct thermal_zone_device *tz = to_thermal_zone(dev);	\
> > > > > +		s32 value;						\
> > > > > +									\
> > > > > +		if (!tz->tzp)						\
> > > > > +			return -EIO;					\
> > > > > +									\
> > > > > +		if (kstrtos32(buf, 10, &value))				\
> > > > > +			return -EINVAL;					\
> > > > > +									\
> > > > > +		tz->tzp->name = value;					\
> > > > > +									\
> > > > > +		return count;						\
> > > > > +	}								\
> > > > > +	static DEVICE_ATTR(name, S_IWUSR | S_IRUGO, name##_show, name##_store)
> > > > > +
> > > > > +create_s32_tzp_attr(k_po);
> > > > > +create_s32_tzp_attr(k_pu);
> > > > > +create_s32_tzp_attr(k_i);
> > > > > +create_s32_tzp_attr(k_d);
> > > > > +create_s32_tzp_attr(integral_cutoff);
> > > > > +#undef create_s32_tzp_attr
> > > > > +
> > > > > +static struct device_attribute *dev_tzp_attrs[] = {
> > > > > +	&dev_attr_sustainable_power,
> > > > > +	&dev_attr_k_po,
> > > > > +	&dev_attr_k_pu,
> > > > > +	&dev_attr_k_i,
> > > > > +	&dev_attr_k_d,
> > > > > +	&dev_attr_integral_cutoff,
> > > > > +};
> > > > > +
> > > > > +static int create_power_allocator_tzp_attrs(struct device *dev)
> > > 
> > > I would rename this to thermal_create_zone_params_attrs and remove the
> > > ifdefiry.
> > 
> > Ok, I will remove them.
> > 
> > >           If you are not exposing the complete info under tzp, then make
> > > a comment about it.
> > 
> > There's nothing else worth populating.  The governor_name is not
> > interesting, you have the thermal zone policy for that.  Similar for
> > no_hwmon.  For tbps, weight and trip_mask are already exposed in the
> > instance.  The binding_limits is currently not available in sysfs, but
> > if we were to populate it, I would expose the ones that end up in the
> > instance, as we do with trips and weights.
> > 
> > Is it worth putting this in a comment in the code?
> 
> 
> Well, I was more interested in governor specific / internal data,
> accessible only in the governor file (e.g.: power_allocator.c). Do you
> think we need to expose something that is accessible only from the
> governor code or do you think the current info under tzp is enough?
> 
> 
> If the former is the case, then we need restructure with callbacks. If
> not, meaning, if all you need is in tzp, then we can keep the code in
> thermal core.

I don't want to expose anything from the governor file, I think the
current info under tzp is enough.

Cheers,
Javi
