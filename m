From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 3/7] typec: tcpm: Add SDB header for Status message
 handling
Date: Wed, 1 Nov 2017 18:20:42 +0100
Message-ID: <20171101172042.GB14585@kroah.com>
References: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
 <4199ae7655886b8ba7a436d3a9938220d2e14f0b.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4199ae7655886b8ba7a436d3a9938220d2e14f0b.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 01, 2017 at 05:03:11PM +0000, Adam Thomson wrote:
> This commit adds a header providing definitions for handling
> Status messages. Currently the header only focuses on handling
> incoming Status messages.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  include/linux/usb/pd_ext_sdb.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 include/linux/usb/pd_ext_sdb.h
> 
> diff --git a/include/linux/usb/pd_ext_sdb.h b/include/linux/usb/pd_ext_sdb.h
> new file mode 100644
> index 0000000..6d6da31
> --- /dev/null
> +++ b/include/linux/usb/pd_ext_sdb.h
> @@ -0,0 +1,40 @@
> +/*
> + * Copyright (c) 2017 Dialog Semiconductor
> + *
> + * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

Same license question here.


> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __LINUX_USB_PD_EXT_SDB_H
> +#define __LINUX_USB_PD_EXT_SDB_H

No need for __LINUX_ right?

thanks,

greg k-h
