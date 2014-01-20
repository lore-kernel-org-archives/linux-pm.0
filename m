From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC/RFT][PATCH 4/5] ACPI / LPSS: Support for device latency
 tolerance PM QoS
Date: Mon, 20 Jan 2014 13:15:19 +0200
Message-ID: <20140120111518.GE18029@intel.com>
References: <5434847.aCyiWHNRe7@vostro.rjw.lan>
 <12327024.lrSi2qfq01@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12327024.lrSi2qfq01@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 17, 2014 at 03:46:40PM +0100, Rafael J. Wysocki wrote:
> @@ -415,11 +472,12 @@ static int acpi_lpss_platform_notify(str
>  		return 0;
>  	}
>  
> -	if (action == BUS_NOTIFY_ADD_DEVICE)
> +	if (action == BUS_NOTIFY_ADD_DEVICE) {
>  		ret = sysfs_create_group(&pdev->dev.kobj, &lpss_attr_group);
> -	else if (action == BUS_NOTIFY_DEL_DEVICE)
> +		pdev->dev.power.set_latency_tolerance = acpi_lpss_set_ltr;

While trying to test this I noticed that BUS_NOTIFY_ADD_DEVICE happens
after call to dpm_sysfs_add(), so LTR field is never exposed to the
userspace.

> +	} else if (action == BUS_NOTIFY_DEL_DEVICE) {
>  		sysfs_remove_group(&pdev->dev.kobj, &lpss_attr_group);
> -
> +	}
>  	return ret;
>  }
>  
