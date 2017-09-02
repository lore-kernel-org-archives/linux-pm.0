From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] CHROMIUM: devfreq: rk3399: Clear edev->dev drvdata
 before enabling dfi
Date: Fri, 1 Sep 2017 17:47:01 -0700
Message-ID: <20170902004659.GA105370@google.com>
References: <20170901235237.18390-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170901235237.18390-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, dbasehore@chromium.org, dianders@chromium.org, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 02, 2017 at 07:52:37AM +0800, Jeffy Chen wrote:
> Currently we are using edev->dev drvdata to get rk3399-dmc data, but
> it would be inited to edev in devfreq_event_add_edev.
> 
> So we need to clear the edev->dev drvdata before enabling dfi, to
> prevent dfi from getting the wrong rk3399-dmc data when the irq
> triggered too early.

Your description doesn't match your code. You say you're clearing
evdev->dev driver data but...

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  drivers/devfreq/rk3399_dmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 1b89ebbad02c..12f9f03f349f 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -429,6 +429,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  
>  	rk3399_devfreq_dmc_profile.initial_freq = data->rate;
>  
> +	platform_set_drvdata(pdev, NULL);

...here you're only clearing the drvdata for the platform device. Is
that a mistake? (Hint: that's not what you uploaded on the Chromium OS
instance, where you presumably tested this.)

And if you're really trying to do what your commit message says:

We're having two different files fight over who owns the edev drvdata?
That seems like a big no-no.

We should work out who's the real owner of 'drvdata', and find some
other solution for the others.

Brian

>  	data->devfreq = devm_devfreq_add_device(dev,
>  					   &rk3399_devfreq_dmc_profile,
>  					   "simple_ondemand",
> -- 
> 2.11.0
> 
> 
