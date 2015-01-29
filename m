From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: Add msm tsens thermal sensor driver
Date: Thu, 29 Jan 2015 18:53:30 -0400
Message-ID: <20150129225329.GF29837@developer.amazonguestwifi.org>
References: <1422331786-19620-1-git-send-email-nrajan@codeaurora.org>
 <54C73B0B.609@linaro.org>
 <002f01d03a81$07fabf10$17f03d30$@codeaurora.com>
 <20150128235240.GA23506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:58036 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbA2Wxl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 17:53:41 -0500
Content-Disposition: inline
In-Reply-To: <20150128235240.GA23506@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Stephen Boyd' <sboyd@codeaurora.org>
Cc: Narendran Rajan <nrajan@codeaurora.com>, 'Srinivas Kandagatla' <srinivas.kandagatla@linaro.org>, 'Narendran Rajan' <nrajan@codeaurora.org>, 'Zhang Rui' <rui.zhang@intel.com>, 'Linux ARM MSM' <linux-arm-msm@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Siddartha Mohanadoss' <smohanad@codeaurora.org>

On Wed, Jan 28, 2015 at 03:52:40PM -0800, 'Stephen Boyd' wrote:
> On 01/27, Narendran Rajan wrote:
> > > From: Srinivas Kandagatla [mailto:srinivas.kandagatla@linaro.org]
> > > > +struct tsens_device;
> > > > +
> > > > +struct tsens_sensor {
> > > > +	struct thermal_zone_device	*tz_dev;
> > > > +	enum thermal_device_mode	mode;
> > > > +	unsigned int			sensor_num;
> > > > +	int				offset;
> > > > +	u32				slope;
> > > > +	struct tsens_device		*tmdev;
> > > > +	u32                             status;
> > > > +};
> > > > +
> > > > +struct tsens_device {
> > > > +	bool			prev_reading_avail;
> > > > +	unsigned int		num_sensors;
> > > > +	int			pm_tsens_thr_data;
> > > > +	int			pm_tsens_cntl;
> > > > +	unsigned int            calib_offset;
> > > > +	unsigned int            backup_calib_offset;
> > > > +	struct work_struct	tsens_work;
> > > > +	struct regmap		*map;
> > > > +	struct regmap_field	*status_field;
> > > > +	struct tsens_sensor	sensor[0];
> > > > +};
> > > > +
> > > > +static struct device *tsens_dev;
> > > Hmm.. I think you should remove this global variable and find a better way
> > to
> > > get hold of this.
> > > 
> > Didn't find anything simple enough. A few other drivers seems to use global 
> > as well. Will look around. If you have some quick tips let me please know.
> 
> Why do we even need those dev_dbg() printks? I'd rather see that
> debugging stuff get removed and this static singleton removed at
> the same time.
> 
> > > 
> > Correct, in polling mode (which is what exists in thermal framework today),
> > HW interrupt 
> > do not make sense as the trip points are set to default and never updated
> > based on Dt values.
> > 
> > But the code under the #ifdef THERMAL_TSENS8960_HWTRIPS supports the HW trip
> > point mode.
> > This code needs the additional patch
> > Please see https://patchwork.ozlabs.org/patch/364812/
> > 
> > May be I will remove everything under HWTRIPs until it lands in the core
> > thermal framework?


> > 
> 
> That patch is half a year old. Is aynyone still working on it?
> Perhaps you can pick it up and try to get it into a workable
> state and then port this new driver to it?

This is preferable. The original proposal was not taken further because
it added functionality that would be only in of thermal. And my concern
is that of thermal must be compliant with thermal core, and not a
competing API. As long as HW trips can also be used by drivers that do
not use of thermal, I am more than happy to help to merge a code in that front.

Besides, other drivers would benefit too.

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
