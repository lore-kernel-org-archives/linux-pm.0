From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 03/13] power: bq24257: Add basic support for
 bq24250/bq24251
Date: Wed, 2 Sep 2015 11:19:13 +0300
Message-ID: <20150902081912.GF12822@lpalcu-desk>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
 <1441073435-12349-4-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441073435-12349-4-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski.k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 31, 2015 at 09:10:25PM -0500, Andreas Dannenberg wrote:
[...]
> @@ -686,6 +704,8 @@ static int bq24257_probe(struct i2c_client *client,
>  
>  	bq->client = client;
>  	bq->dev = dev;
> +	bq->chip = (enum bq2425x_chip)id->driver_data;
> +	strncpy(bq->chip_name, id->name, I2C_NAME_SIZE);
id is NULL when ACPI enumerated... In order to check the device was
enumerated by ACPI, ACPI_HANDLE(dev) should be non-NULL. Then you can
use acpi_match_device() to fetch the acpi_id.

laurentiu
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
