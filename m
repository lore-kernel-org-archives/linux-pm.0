From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC v4 1/3] PM / Runtime: Add an API pm_runtime_set_slave
Date: Mon, 9 Feb 2015 10:58:41 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1502091055460.20425-100000@netrider.rowland.org>
References: <1423479726-23140-2-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423479726-23140-2-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, khilman@linaro.org, rjw@rjwysocki.net, len.brown@intel.com, ulf.hansson@linaro.org, tomasz.figa@gmail.com, kgene.kim@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, pankaj.dubey@samsung.com, m.szyprowski@samsung.com, geert+renesas@glider.be
List-Id: linux-pm@vger.kernel.org

On Mon, 9 Feb 2015, Amit Daniel Kachhap wrote:

> This API creates a pm runtime slave type device which does not itself
> participates in pm runtime but depends on the master devices to power
> manage them.

This makes no sense.  How can a master device manage a slave device?  
Devices are managed by drivers, not by other devices.

>  These devices should have pm runtime callbacks.
> 
> These devices (like clock) may not implement complete pm_runtime calls
> such as pm_runtime_get/pm_runtime_put due to subsystems interaction
> behaviour or any other reason.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/base/power/runtime.c | 18 ++++++++++++++++++
>  include/linux/pm.h           |  1 +
>  include/linux/pm_runtime.h   |  2 ++
>  3 files changed, 21 insertions(+)

This patch is unacceptable because it does not update the runtime PM 
documentation file.

Besides, doesn't the no_callbacks flag already do more or less what you 
want?

Alan Stern
