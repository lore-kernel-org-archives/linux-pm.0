From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/8] introduce the device async
	action	mechanism
Date: Wed, 15 Jul 2009 02:31:44 +0200
Message-ID: <20090715003144.GD2360__36747.3799539313$1247672016$gmane$org@ucw.cz>
References: <1247643516.26272.77.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1247643516.26272.77.camel@rzhang-dt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2009-07-15 15:38:36, Zhang Rui wrote:
> Introduce the device async action mechanism.
> 
> In order to speed up Linux suspend/resume/shutdown process,
> we introduce the device async action mechanism that allow devices
> to suspend/resume/shutdown asynchronously.
> 
> The basic idea is that,
> if the suspend/resume/shutdown process of a device set,
> including a root device and its child devices, are independent of
> other devices, we create an async domain for this device set,
> and make them suspend/resume/shutdown asynchronously.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/base/Makefile     |    3 
>  drivers/base/async_dev.c  |  180 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/async_dev.h |   40 ++++++++++
>  include/linux/device.h    |    2 
>  4 files changed, 224 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/include/linux/async_dev.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6/include/linux/async_dev.h
> @@ -0,0 +1,40 @@
> +/*
> + * async_dev.h: function calls for device async actions
> + *
> + * (C) Copyright 2009 Intel Corporation
> + * Author: Zhang Rui <rui.zhang@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2
> + * of the License.
> + */
> +
> +#ifndef _ASYNC_DEV_H_
> +#define _ASYNC_DEV_H_
> +
> +#include <linux/types.h>
> +#include <linux/list.h>
> +#include <linux/async.h>
> +#include <linux/device.h>
> +#include <linux/pm.h>
> +
> +struct dev_async_struct {
> +	struct device *dev;
> +	int type;
> +	/* Synchronization Domain for device async actions */
> +	struct list_head domain;
> +	struct list_head node;
> +	async_cookie_t cookie;
> +};
> +
> +#define DEV_ASYNC_ACTIONS_ALL	0
> +
> +extern int dev_async_schedule(struct device *, void *,
> +			void *, int);
> +extern void dev_async_synchronization(void);

'_synchronize' to be consistent with schedule?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
