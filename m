From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/7] USB: core: fix device node leak
Date: Tue, 30 May 2017 15:55:56 -0700
Message-ID: <9aff0d42-ff3e-963a-7aaa-752c2f592d0d@linux.vnet.ibm.com>
References: <20170530162554.26159-1-johan@kernel.org>
 <20170530162554.26159-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530162554.26159-2-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@freescale.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Peter Chen <peter.chen@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 05/30/2017 09:25 AM, Johan Hovold wrote:
> Make sure to release any OF device-node reference taken when creating
> the USB device.
> 
> Note that we currently do not hold a reference to the root hub
> device-tree node (i.e. the parent controller node).
> 
> Fixes: 69bec7259853 ("USB: core: let USB device know device node")
> Cc: stable <stable@vger.kernel.org>	# v4.6
> Cc: Peter Chen <peter.chen@nxp.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/core/usb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 28b053cacc90..62e1906bb2f3 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -416,6 +416,8 @@ static void usb_release_dev(struct device *dev)
>  
>  	usb_destroy_configuration(udev);
>  	usb_release_bos_descriptor(udev);
> +	if (udev->parent)
> +		of_node_put(dev->of_node);

If I'm following the root hub doesn't hold an of_node reference, so does that guarantee
that dev->of_node is NULL for the root hub? If so of_node_put() is safely called with a
NULL reference, making the if(udev->parent) unnecessary, and further no need to remove it
in follow-up patch #5.

-Tyrel

>  	usb_put_hcd(hcd);
>  	kfree(udev->product);
>  	kfree(udev->manufacturer);
> 
