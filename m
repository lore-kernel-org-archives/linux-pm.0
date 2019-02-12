From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/2] soc: imx8: Add cpufreq registering and speed
 grading check for i.MX8MQ
Date: Tue, 12 Feb 2019 13:44:22 +0100
Message-ID: <1549975462.2546.30.camel@pengutronix.de>
References: <1549974071-8284-1-git-send-email-abel.vesa@nxp.com>
         <1549974071-8284-2-git-send-email-abel.vesa@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549974071-8284-2-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Abel,

Am Dienstag, den 12.02.2019, 12:21 +0000 schrieb Abel Vesa:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Register cpu-freq platform driver for i.MX8.
> i.MX8MQ has different parts like consumer, industrial and auto etc.,
> different parts have different cpufreq set-points, this patch adds
> fuse check to select correct cpufreq set-points for each part. The
> default dtb has all set-points available, then kernel will check fuse
> to disable those unused set-points, definition as below:
> 
> OCOTP offset 0x440, bit [7:6]
> 
> '00' - Consumer 0C to 95C
> '01' - Ext. Consumer -20C to 105C
> '10' - Industrial -40C to 105C
> '11' - Automotive -40C to 125C

Shouldn't this read 0x440 [9:8] (SPEED_GRADING) instead? According to
the RM those 2 bits directly encode the maximum ARM core frequency, so
we don't need to guess from the target market.

Regards,
Lucas
