From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC 3/3] i2c: rcar: disable PM in multi-master mode
Date: Wed, 16 Dec 2015 21:48:24 +0300
Message-ID: <5671B1F8.8070103@cogentembedded.com>
References: <1450291460-10514-1-git-send-email-wsa@the-dreams.de>
 <1450291460-10514-4-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1450291460-10514-4-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello.

On 12/16/2015 09:44 PM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> In multi master mode, the IP core needs to be always active for
> arbitration reasons. Get the config from DT and set up PM depending on
> the config.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/i2c/busses/i2c-rcar.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 79fd2aab8fa087..7c523dcaee3e48 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
[...]
> @@ -630,7 +633,13 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>   		goto out_pm_put;
>
>   	rcar_i2c_init(priv);
> -	pm_runtime_put(dev);
> +
> +	/* Don't suspend when multi-master to keep arbitration working */
> +	if (of_get_property(dev->of_node, "multi-master", NULL))

     of_property_read_bool(), perhaps?

[...]

MBR, Sergei
