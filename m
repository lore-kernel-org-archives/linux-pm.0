From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Wed, 16 Mar 2016 13:09:50 +0100
Message-ID: <1458130190.6570.6.camel@suse.com>
References: <cover.1458128215.git.baolin.wang@linaro.org>
	 <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-03-16 at 19:46 +0800, Baolin Wang wrote:
> This patch introduces the usb charger driver based on usb gadget that
> makes an enhancement to a power driver. It works well in practice but
> that requires a system with suitable hardware.
> 
> The basic conception of the usb charger is that, when one usb charger
> is added or removed by reporting from the usb gadget state change or
> the extcon device state change, the usb charger will report to power
> user to set the current limitation.

This patch adds sysfs attributes without adding Documentation for them.
That's bad.

	Regards
		Oliver
