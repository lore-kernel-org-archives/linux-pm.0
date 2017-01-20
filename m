From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: imx6ul: power-up using the RTC
Date: Fri, 20 Jan 2017 13:12:10 +0100
Message-ID: <20170120121210.gm3wcg4yyvrigpn3@earth>
References: <b516070d-6539-98d1-c832-d79ac89e8d43@mobi-wize.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4lskj7sct7d33jpz"
Return-path: <rtc-linux+bncBDXMLNOH5ANRBIH5Q7CAKGQETVXEPLA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <b516070d-6539-98d1-c832-d79ac89e8d43-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
Cc: b20788-KZfg59tc24xl57MIdRCFDg@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--4lskj7sct7d33jpz
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Wed, Jan 18, 2017 at 04:49:11PM +0200, Guy Shapiro wrote:
> I'm trying to use the low power RTC of the i.MX6UL to start from
> power-off state.
> 
> I started by hopefully running: # echo +30 >
> /sys/class/rtc/rtc0/wakealarm && shutdown -h now The system was
> powered down, but it didn't come up after 30 seconds as expected.
> 
> So I dug into the datasheet and the source...
> To activate the power on alarm, the flags SRTC_ENV, LPTA_EN and LPWUI_EN on
> the SNVS_LP Control register (LPCR) should be asserted. The wakeup time
> should be written to the SNVS_LP Time alarm register (LPTA). The code that
> does this is on drivers/rtc/rtc-snvs.c:snvs_rtc_set_alarm().
> 
> The first problem I found was with the use of the syscon-poweroff driver.
> The "Turn off System Power" flag is part of the same register (LPCR). The
> current code of syscon-poweroff set the register to the "mask" property from
> the device tree on power off, overriding all the existing flags.
> After setting the "mask" property on the device tree to 0x6b instead of
> 0x60 (asserting the mentioned bits), the system do power up on timer, as
> expected.
> 
> However, I didn't like the idea of keeping those flags on even when no one
> set the alarm.
> As a quick test, I modified the syscon-poweroff driver to ignore the bits
> that are not on the mask:
> 
> diff --git a/drivers/power/reset/syscon-poweroff.c
> b/drivers/power/reset/syscon-poweroff.c
> index b683383..a5da02b 100644
> --- a/drivers/power/reset/syscon-poweroff.c
> +++ b/drivers/power/reset/syscon-poweroff.c
> @@ -33,7 +33,7 @@ static u32 mask;
> static void syscon_poweroff(void)
> {
>         /* Issue the poweroff */
> -       regmap_write(map, offset, mask);
> +       regmap_update_bits(map, offset, mask, mask);
>         mdelay(1000);
> 
> 
> After applying this fix, the wake up alarm didn't work. Strangely, when I
> added some debug prints to investigate the case, it worked again
> (sometimes... depends on the exact places I add the prints).
> I suspect that some other driver clears the flags during the power down, but
> I couldn't find such driver.
> 
> Do you have any clue what code may change this register during the shutdown
> process? Any other insights are welcomed as well :)

To summarize it looks like this?

| regmap_write       | 0x60 | broken                     |
| regmap_write       | 0x6b | works stable               |
| regmap_update_bits | 0x60 | works only with dbg prints |

For me it looks like the debug prints may delay the poweroff driver
long enough, that some other driver (rtc?) writes the 0x0b bits.

FWIW we can't switch from regmap_write to regmap_update_bits in the
syscon driver, since that may break other users. I guess we need to
introduce a DT property providing the update mask. Unfortunately the
register value property is already named mask :/

-- Sebastian

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--4lskj7sct7d33jpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliB/pcACgkQ2O7X88g7
+pr5iQ//WDf8FBjLuSR7/Yka8tJCxxQATGo/zeaH5nYiEMmfDPB2TMjOKeJDDnl4
FNd+OL+bpBkns9PAUXV9mWlqy2FWdG9HORdI0J00ih//yXDea7UsPTEWRuow4Eoq
CVBm9Y1QHzFqxFZsFvW3mIyG1FFzPdxG2sQh5nYyOpntQxz1Yf+eamqhkeG8L3Jl
xNBICrP1yqYMtyGKuTDi+qn9OqVL6unNDeAXVFu+5yWGz/OCVciJz6P3M8w+nI3c
I42LXJOX5qMI08zes+B2Mofyz7uL4XbI6ab1ba76OHqBukCWAkWROEl/IuYZhgZb
4KGiE5xU7e9O6T1qClRNyy37X/05XuhiVbWq6BJNK5BGmWO7T5QH1QioVyiUW0OC
3dG5eWrPKqDTq0m9FnKWfRvGCxg5X95blQ/MbKmOlZYgZdwM+zvltmPu31+uu92U
eSsiZ5V/3OEuqgxmqYLRmKDyOgoAMlPzmYNw2cU7X2H5qDIp2VGpHsYCes0Mb5A3
dzwXMyIIiLLkKNz8mf35ZGLA2pZJAWv8rD1mWytWPgEFcja7YRxXUifnERV4+Pnf
qn1gfNCbjJgnJX2myRwzTHCMYPLQWsXnJVmKaN3W8WoEuzBHkElSTppFI+QuMjBC
Mkx7VNcL55yUgbgIFp3h+VjsNbM2mLbYhsTDfJ+uoaiemCv7icQ=
=ecmX
-----END PGP SIGNATURE-----

--4lskj7sct7d33jpz--
