From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH V3 2/5] thermal: bcm2835: add thermal driver for bcm2835
 soc
Date: Thu, 18 Aug 2016 11:39:12 -0700
Message-ID: <87r39lvs4v.fsf@eliezer.anholt.net>
References: <1463495753-967-1-git-send-email-kernel@martin.sperl.org>
 <1463495753-967-3-git-send-email-kernel@martin.sperl.org>
 <87mvn6qa2x.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8067569386241950745=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87mvn6qa2x.fsf@eliezer.anholt.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>
List-Id: linux-pm@vger.kernel.org

--===============8067569386241950745==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Eric Anholt <eric@anholt.net> writes:

> kernel@martin.sperl.org writes:
>
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> Add basic thermal driver for bcm2835 SOC.
>>
>> This driver currently relies on the firmware setting up the
>> tsense HW block and does not set it up itself.
>>
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>>
>> ChangeLog:
>>  V1 -> V2: added specific settings depending on compatiblity
>> 	   added trip point based on register
>> 	   setting up ctrl-register if HW is not enabled by firmware
>> 	     as per recommendation of Eric (untested)
>> 	   check that clock frequency is in range
>> 	     (1.9 - 5MHz - as per comment in clk-bcm2835.c)
>> ---
>
>> diff --git a/drivers/thermal/bcm/Makefile b/drivers/thermal/bcm/Makefile
>> new file mode 100644
>> index 0000000..13456d2
>> --- /dev/null
>> +++ b/drivers/thermal/bcm/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_BCM2835_THERMAL)		:= bcm2835_thermal.o
>> diff --git a/drivers/thermal/bcm/bcm2835_thermal.c b/drivers/thermal/bcm/bcm2835_thermal.c
>> new file mode 100644
>> index 0000000..73138cb
>> --- /dev/null
>> +++ b/drivers/thermal/bcm/bcm2835_thermal.c
>
>> +static const struct of_device_id bcm2835_thermal_of_match_table[];
>> +static int bcm2835_thermal_probe(struct platform_device *pdev)
>> +{
>
>> +	/* enable clock and check rate */
>> +	clk_prepare_enable(data->clk);
>> +	rate = clk_get_rate(data->clk);
>> +	if ((rate < 1920000) || (rate > 5000000)) {
>> +		dev_warn(&pdev->dev,
>> +			 "Clock %pCn is running at %pCr Hz, which is outside the recommended range of 1.9 to 5.0 MHz\n",
>> +			 data->clk, data->clk);
>> +	}
>> +
>> +	/* register it */
>> +	tz = thermal_zone_device_register("bcm2835_thermal",
>> +					  1, 0, data,
>> +					  &bcm2835_thermal_ops,
>> +					  NULL, 0, 0);
>
> I notice that the polling_delay is set to 0, but we're not using
> interrupts to trigger the trip.  Is it valid to expose a trip without a
> polling_delay or interrupts?  Should passive_delay be set as well?
>
> This is up to the thermal maintainers.  As far as I'm concerned, it's:
>
> Acked-by: Eric Anholt <eric@anholt.net>
>
> One it lands I'll pull the defconfig and DT bits.

Ping on this question to thermal maintainers.  I'd still love to see
this driver land.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXtgDQAAoJELXWKTbR/J7o5V8QALYt7BafwqepgqasTM57rYSE
3EXgKVYXWl2rnUn1Xqi6SVesk4mzL3XcMHG0Tom/e+u4GuCGl05+AQSj/IM/whav
5qQf0iaa8yxwYysNNU0OdLSZH2mabJmQfOp0m+LVqoYYnHhe3UaHUbObE3Pmjmy6
XZLlytwDGI7kRijo02oGlkeVz28x569pBghfM74cyANJ2jK3ly4XhJjlobxl98cg
rOGjPV/9MJroAHrIrpxXkE65g/wYEYdZPilGcOcntfECbdXZ8eGoECqS6+cNpNVd
WNiBItyKrzuIhM8tuZ9hd2WcwVJBfw3Bst8rK7HtRFWVeQzzHyMRynoGIFzpYs8x
44p88mhAB3A7NwCr+8s40Z4Rz+w0UYOa2QhBZcc2LH6B9AsJ68/3HNNttvkDrgnD
Q847Jx6NGRniIGEygQB80LV3FrH+DxyG21R0DzVNPqFGksDumpxFx5zApeOBZj+k
1DVb0LNTVfCwbAYEb5F9omG904yb/rUxdqzevJSjL/VQ0U1DcdA/EXCNe8HKsHNx
RI1VZLC2RoBEZVU8ysHxEvNTRtuDLe6MPS7axfbb/sYNYfzn6y19IQ6MJzTiIDfq
0EtA0PqvshteQrpHFiEF7uuR2CDWJNacM8wMmj3+wT+AjWHJ0dYcP1AA52PvdglN
SOjaOLT62H8qcUqAqKMz
=sLQw
-----END PGP SIGNATURE-----
--=-=-=--


--===============8067569386241950745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8067569386241950745==--
