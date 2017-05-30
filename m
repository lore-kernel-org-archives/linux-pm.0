From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/7] USB: of: document reference taken by child-lookup
 helper
Date: Tue, 30 May 2017 15:40:03 -0700
Message-ID: <eda774a3-7bd2-94e4-a5b8-67a93ec2fcf4@linux.vnet.ibm.com>
References: <20170530162554.26159-1-johan@kernel.org>
 <20170530162554.26159-3-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751007AbdE3WkO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2017 18:40:14 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v4UMcUsp137561
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2017 18:40:14 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2asgj1j98t-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2017 18:40:13 -0400
Received: from localhost
        by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Tue, 30 May 2017 16:40:12 -0600
In-Reply-To: <20170530162554.26159-3-johan@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@freescale.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/30/2017 09:25 AM, Johan Hovold wrote:
> Document that the child-node lookup helper takes a reference to the
> device-tree node which needs to be dropped after use.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/core/of.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
> index d563cbcf76cf..17a4af02cf5b 100644
> --- a/drivers/usb/core/of.c
> +++ b/drivers/usb/core/of.c
> @@ -28,6 +28,9 @@
>   *
>   * Find the node from device tree according to its port number.
>   *
> + * Takes a reference to the returned device-tree node, which needs to be
> + * dropped after use.
> + *
>   * Return: On success, a pointer to the device node, %NULL on failure.

I would use the same blurb used throughout drivers/of/* for consistency.

 *      Returns a node pointer with refcount incremented, use
 *      of_node_put() on it when done.
 */

Just my 2-cents

-Tyrel

>   */
>  struct device_node *usb_of_get_child_node(struct device_node *parent,
> 
