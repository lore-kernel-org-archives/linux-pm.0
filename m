From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH 03/13] power: bq24257: Add basic support for
 bq24250/bq24251
Date: Wed, 2 Sep 2015 09:16:34 -0500
Message-ID: <20150902141634.GC24076@borg>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
 <1441073435-12349-4-git-send-email-dannenberg@ti.com>
 <20150902081912.GF12822@lpalcu-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34195 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbbIBORC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Sep 2015 10:17:02 -0400
Content-Disposition: inline
In-Reply-To: <20150902081912.GF12822@lpalcu-desk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Sep 02, 2015 at 11:19:13AM +0300, Laurentiu Palcu wrote:
> On Mon, Aug 31, 2015 at 09:10:25PM -0500, Andreas Dannenberg wrote:
> [...]
> > @@ -686,6 +704,8 @@ static int bq24257_probe(struct i2c_client *client,
> >  
> >  	bq->client = client;
> >  	bq->dev = dev;
> > +	bq->chip = (enum bq2425x_chip)id->driver_data;
> > +	strncpy(bq->chip_name, id->name, I2C_NAME_SIZE);
> id is NULL when ACPI enumerated... In order to check the device was
> enumerated by ACPI, ACPI_HANDLE(dev) should be non-NULL. Then you can
> use acpi_match_device() to fetch the acpi_id.

Thanks for the advice. I had seen similar code in bq2415x_charger.c.
Will take some glues from there and fix it.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc


> 
> laurentiu
