Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29F4307AE
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613245; cv=none; b=lK4YJR3ZLUdAmjNxYJz134LrOyiAwfUvVWn8ZKm/LqUEJfaZig5pDRv2KPIkBTEgSE1bgD82yO2JZzeMvVm8HNYscmCQRO00uUDLiO5FNqXaMGeMhyLZxIy2pzvVJfkM+Xh5sBf45O6ozr2NTUyfINSrr2Zqu1kPMSuLAbQoIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613245; c=relaxed/simple;
	bh=TfiHSLMBjZ80AM2O04NWCaLK29aZWfR88RfiqOuVlcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM4lXe5IM4ENM6vtekPWVIYnwfs+oHRNcWhlmVVSmXdCvlMHx5lstm92/2mKebq63fFoiK39IEnkC7opBmd3JlswOC0aEeMhz8hSK4FiZEE76QvlL+g0UX4dDiz1TM0AbnKyCU80yGzlSBEhGytizCQwnoYYfVrhdQTfKcZPIEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBDFzVUC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBDFzVUC"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84867f07d63so538285b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783613243; x=1784218043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ysgGA9FNs2LC6p8SRgBycN6NLmY0OUHVJV77+UK20Sc=;
        b=cBDFzVUCfbVwT+blU5hStVzsUa9sb8BUQReUAD95t+v/joFsWgfLfXi/KIYxD8YffC
         G44nohEBHc4A/nR7D7lCwVu7n7m6GnBUohblqBMtnNboRz9jv1s3T8fqiNn0YFZSb8Ei
         GU6IEyMzABSKWr4Ez79eNWQhkEsGMiYNZMzFIp5S/zi2DtL5fYYZ0Gt5+yUI30u63f8P
         LT3Rbbx/a38OCfPOodVXurkG7rdcLGcZNX4Rn59NbE/aP/hB3OCL7Dc6xvPuPMNgplfq
         wVWIlSkYSqo5m2elj56+rgscbhddEMk5vloWmpLVBaZ54LgZb3Vo765+eLawjm4pdJbY
         Shkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783613243; x=1784218043;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysgGA9FNs2LC6p8SRgBycN6NLmY0OUHVJV77+UK20Sc=;
        b=mp4vj/aKAli1S/17UcSisu/KliXmzCBSnE2c7ZOJqHJIZ2v6V20zuBBWTBBQda9Gut
         sI0pFqqs9xucVpD1ZFZkRwyYm1O1AbKG25z1DxkrcDwmf6zRvV/P4mVbMFFcE3mavvTE
         Q4CwiTRWP+axegsOcsffDDvmEZO0getqRxt2jIy0lHG8OYOhPsco9aDyoVfCqbipGLdf
         bfb5aUO1l58YitDgmCTFjOvsnS255otV7OUUhyk7MtcdEssrx81oEyodRNhT55JHxXH1
         k28DI2GJt1b41muvf9dqU85F2fBoi/4pl0G0CVgSON+7uzxJDdRiJpO5ZWNHaspro/G3
         frwg==
X-Forwarded-Encrypted: i=1; AHgh+RptNTLR5fDqv9nFK/xEo5GR0i1ozudeKB/v7FL8QEhpClSlyvctbd4n0FabHZlSOlLMy+kHwK8kRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWfQDE7UpgHEl1dsmz+KQ3uM+EZGqCXTyDx9muPVmbpq+cpTtJ
	NctJH0zb9Sx/mXmBYQKIlJg70t6v1WQNrmdUCrxxedR5BHPXrTa2Z6du
X-Gm-Gg: AfdE7ckWIltukr57cqBg73iQvJEamRUimabOIx6Ji1LB8C7cC37/HBqQj4ziWkHnqdo
	/EjudeMltEPDs5+lZOckfJ7XoHeq0XRoC215EQ8b3D9yNaFYNG6t9h2J+AMuutU7rKYPKRNmPqQ
	30bOYqaprXddwvH3jgvQRiRiU6pubF92Qi3r3L7fV57dY4TY5987gZjtTdrdrm1g6+HXBMPF2xA
	d8h9u2mmVIiywlYuIyOohBXlf3q+tbgJLdkgEhPLZpptywmIibu7vSTcwiGxSvp7Fjb090zeYZe
	0XTAOjjzsyhBH21i2NvbuKNQt8TJO3FaJE8cto2fhsq0rUEQD3kenXH5oK0TX+YOp74kV/4DscN
	MCpccJ0Yaa80m2kf6DPghNvD0scvCFOpEHkVi0zrJquzXZEfltTBwH0DuS6WXjBQZrwxtdX2+H+
	CX4qsR0EvYwi7XbBrqCpvs8mK5/w==
X-Received: by 2002:a05:6a00:91a9:b0:848:44d2:72a2 with SMTP id d2e1a72fcca58-84844d2940fmr6740302b3a.27.1783613242449;
        Thu, 09 Jul 2026 09:07:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8484d465991sm2206257b3a.47.2026.07.09.09.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:07:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 9 Jul 2026 09:07:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@amd.com,
	vincent.guittot@linaro.org, Souvik.Chakravarty@arm.com,
	Alex Shi <alexs@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	David Lechner <dlechner@baylibre.com>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Pavel Machek <pavel@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yanteng Si <si.yanteng@linux.dev>, arm-scmi@vger.kernel.org,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"open list:ENERGY MODEL" <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH] firmware: scmi: Make SCMI arch independent
Message-ID: <6cc90547-a3d6-40b4-8914-a1ff60944cdf@roeck-us.net>
References: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>

On Thu, Jul 09, 2026 at 03:27:00PM +0200, Michal Simek wrote:
> On heterogenious systems like AMD/Xilinx FPGA there is a need to talk to
> SCMI server from different architectures than ARM that's why remove
> ARM/ARM64 Kconfig dependency with also remove ARM from description and
> rename folder to reflect it.
> From specification perspective only ARM specific transport layers should be
> available on ARM/ARM64 architectures.
> 
> That's why get rid of ARM prefix and description from documentation, file
> names, folder names, MODULE description, module names, Kconfig and
> comments.
> But keep origin Kconfig symbols not to break existing users.
> 
> Hwmon, pinctrl, powercap, regulator, reset, clk and cpufreq scmi drivers
> already miss arm prefix that's why synchronize all of them to be without
> arm prefix.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Likely I missed other locations but I wanted to send this RFC to have a
> discussion about it.
> ---
...
>  drivers/hwmon/Kconfig                                 |  2 +-
...
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2bfbcc033d59..cda0aedb36ca 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -401,7 +401,7 @@ config SENSORS_ARCTIC_FAN_CONTROLLER
>  	  will be called arctic_fan_controller.
>  
>  config SENSORS_ARM_SCMI
> -	tristate "ARM SCMI Sensors"
> +	tristate "SCMI Sensors"
>  	depends on ARM_SCMI_PROTOCOL
>  	depends on THERMAL || !THERMAL_OF
>  	help

I agree in principle, but I don't see why this would have to be done
in a single patch. Also, both the Kconfig file (SENSORS_ARM_SCMI,
ARM_SCMI_PROTOCOL) and the driver itself (""ARM SCMI HWMON interface
driver") still reference ARM.

Thanks,
Guenter
