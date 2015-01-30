From: "Narendran Rajan" <nrajan@codeaurora.com>
Subject: RE: [PATCH] thermal: Add msm tsens thermal sensor driver
Date: Thu, 29 Jan 2015 16:55:55 -0800
Message-ID: <001001d03c27$81243810$836ca830$@codeaurora.com>
References: <1422331786-19620-1-git-send-email-nrajan@codeaurora.org> <54C73B0B.609@linaro.org> <002f01d03a81$07fabf10$17f03d30$@codeaurora.com> <20150128235240.GA23506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150128235240.GA23506@codeaurora.org>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Stephen Boyd' <sboyd@codeaurora.org>
Cc: 'Srinivas Kandagatla' <srinivas.kandagatla@linaro.org>, 'Narendran Rajan' <nrajan@codeaurora.org>, 'Zhang Rui' <rui.zhang@intel.com>, 'Eduardo Valentin' <edubezval@gmail.com>, 'Linux ARM MSM' <linux-arm-msm@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Siddartha Mohanadoss' <smohanad@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: 'Stephen Boyd' [mailto:sboyd@codeaurora.org]
> Sent: Wednesday, January 28, 2015 3:53 PM
> To: Narendran Rajan
> Cc: 'Srinivas Kandagatla'; 'Narendran Rajan'; 'Zhang Rui'; 'Eduardo
Valentin';
> 'Linux ARM MSM'; 'Linux PM'; 'Siddartha Mohanadoss'
> Subject: Re: [PATCH] thermal: Add msm tsens thermal sensor driver
> 
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
> > > Hmm.. I think you should remove this global variable and find a
> > > better way
> > to
> > > get hold of this.
> > >
> > Didn't find anything simple enough. A few other drivers seems to use
> > global as well. Will look around. If you have some quick tips let me
please
> know.
> 
> Why do we even need those dev_dbg() printks? I'd rather see that
> debugging stuff get removed and this static singleton removed at the same
> time.
> 

Agree, it was more convenience and unwanted singleton. Will change.

> > >
> > Correct, in polling mode (which is what exists in thermal framework
> > today), HW interrupt do not make sense as the trip points are set to
> > default and never updated based on Dt values.
> >
> > But the code under the #ifdef THERMAL_TSENS8960_HWTRIPS supports
> the
> > HW trip point mode.
> > This code needs the additional patch
> > Please see https://patchwork.ozlabs.org/patch/364812/
> >
> > May be I will remove everything under HWTRIPs until it lands in the
> > core thermal framework?
> >
> 
> That patch is half a year old. Is aynyone still working on it?
> Perhaps you can pick it up and try to get it into a workable state and
then
> port this new driver to it?
> 

Let me remove the dependency on this patch for now, have a simple polling
mode only 
Patch.
Will think through a more generic patch post this.

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux Foundation Collaborative Project
