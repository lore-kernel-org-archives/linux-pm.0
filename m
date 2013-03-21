From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 06/16] thermal: mvebu: Convert to devm_ioremap_resource()
Date: Thu, 21 Mar 2013 18:04:58 +0400
Message-ID: <514B138A.7060203@cogentembedded.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com> <1363818997-23137-7-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:54456 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433Ab3CUOF5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 10:05:57 -0400
Received: by mail-la0-f43.google.com with SMTP id ek20so5248525lab.16
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2013 07:05:55 -0700 (PDT)
In-Reply-To: <1363818997-23137-7-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hello.

On 21-03-2013 2:36, Ezequiel Garcia wrote:

> Convert devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.

> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>   drivers/thermal/mvebu_thermal.c |    6 ++----
>   1 files changed, 2 insertions(+), 4 deletions(-)

> diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
> index ef04e4e..089b43d 100644
> --- a/drivers/thermal/mvebu_thermal.c
> +++ b/drivers/thermal/mvebu_thermal.c
> @@ -86,11 +86,9 @@ static int mvebu_thermal_probe(struct platform_device *pdev)
>   	if (!priv)
>   		return -ENOMEM;
>
> -	priv->sensor = devm_request_and_ioremap(&pdev->dev, res);
> -	if (!priv->sensor) {
> -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> +	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
> +	if (!priv->sensor)

    devm_ioremap_resource() returns error code, not NULL.

WBR, Sergei

