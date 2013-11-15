From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PM / Runtime: Fix error path for prepare
Date: Fri, 15 Nov 2013 16:14:27 +0100
Message-ID: <1817325.VUBkIjsnQ5@vostro.rjw.lan>
References: <1384515645-8696-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1384515645-8696-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Friday, November 15, 2013 12:40:44 PM Ulf Hansson wrote:
> If a device prepare callback for some reason would fail, the PM core
> prevented the device from going inactive forever.
> 
> In this case, to reverse the pm_runtime_get_noresume() we invokes the
> asyncronous pm_runtime_put(), thus restoring the usage count.
> 
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This should be in linux-next already.

Thanks!

> ---
>  drivers/base/power/main.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index ee039af..2a1b06a 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1350,6 +1350,9 @@ static int device_prepare(struct device *dev, pm_message_t state)
>  
>  	device_unlock(dev);
>  
> +	if (error)
> +		pm_runtime_put(dev);
> +
>  	return error;
>  }
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
