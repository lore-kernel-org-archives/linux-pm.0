From: Javi Merino <javi.merino@arm.com>
Subject: Re: Fwd: Freescale IMX6 active cooling
Date: Tue, 17 Nov 2015 09:56:50 +0000
Message-ID: <20151117095649.GA2880@e104805>
References: <CABH3fy-He02iVU7FzqcPApPemeoqQP15+gr9+Hx87-OEBuHvCg@mail.gmail.com>
 <CABH3fy_KHmOWRDdLYO8_4vpXpD_dJTamDa4GVPY8nSbddgw+Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55205 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753527AbbKQJ4y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Nov 2015 04:56:54 -0500
Content-Disposition: inline
In-Reply-To: <CABH3fy_KHmOWRDdLYO8_4vpXpD_dJTamDa4GVPY8nSbddgw+Jw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Crenguta <catalin.crenguta@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, Bai Ping <b51503@freescale.com>

On Tue, Nov 17, 2015 at 08:12:56AM +0200, Catalin Crenguta wrote:
> +CC Maintainers
> 
> ---------- Forwarded message ----------
> From: Catalin Crenguta <catalin.crenguta@gmail.com>
> Date: Mon, Nov 16, 2015 at 11:43 AM
> Subject: Freescale IMX6 active cooling
> To: "linux-arm-kernel@lists.infradead.org"
> <linux-arm-kernel@lists.infradead.org>
> Cc: fabio.estevam@freescale.com, Fabio Estevam <festevam@gmail.com>
> 
> 
> Hello,
> 
> I'm trying to use a GPIO Fan to cool down a Riotboard (I.MX6 Solo).
> I've read [0], investigated the driver which provides the on-die
> temperature ( fsl,imx6q-tempmon [1]) but it seems to provide the
> temperature by creating a thermal zone (relevant dts: [2][3][4]).
> I don't know how I should proceed:
> 1) Should I research how can I attach a cooling device to this already
> existing thermal zone? (I believe it involves modifying the existing
> driver by adding new device tree handles)

Maybe you can use the gpio-fan driver in the kernel.  See
Documentation/devicetree/bindings/gpio/gpio-fan.txt and
drivers/hwmon/gpio-fan.c .  

> 2) Should I create another thermal zone, use the existing driver to
> get the temperature and bind to a cooling device?

No, you don't need another thermal zone.

> 3) Should I modify the existing driver to not create a thermal zone
> and move the creation in the device tree using the of-thermal driver ?

Converting the driver to device tree is the best option if all
existing users can be converted as well.

Cheers,
Javi
