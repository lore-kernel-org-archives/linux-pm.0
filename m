From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v8 1/4] gadget: Introduce the usb charger framework
Date: Sat, 23 Apr 2016 21:53:45 +0200
Message-ID: <20160423195345.GD15755@amd>
References: <cover.1458822334.git.baolin.wang@linaro.org>
 <612d9e7b1444a2a26923ca97ef1eb1312016c8e0.1458822334.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <612d9e7b1444a2a26923ca97ef1eb1312016c8e0.1458822334.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> +/*
> + * Sysfs attributes:
> + *
> + * These sysfs attributes are used for showing and setting different type
> + * (SDP/DCP/CDP/ACA) chargers' current limitation.
> + */
> +static ssize_t sdp_limit_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct usb_charger *uchger = dev_to_uchger(dev);
> +
> +	return sprintf(buf, "%d\n", uchger->cur_limit.sdp_cur_limit);
> +}
> +

Sysfs attributes... can we get appropriate documentation for them?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
