From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCHv2 2/4] ARM: bcm2835: add rpi power domain driver
Date: Mon, 30 Nov 2015 14:12:39 -0800
Message-ID: <87vb8jgmqw.fsf@eliezer.anholt.net>
References: <1448816373-18235-1-git-send-email-alex.aring@gmail.com> <1448816373-18235-3-git-send-email-alex.aring@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448816373-18235-3-git-send-email-alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> This patch adds support for RPi several Power Domains and enable support
> to enable the USB Power Domain when it's not enabled before.
>
> This patch based on Eric Anholt's patch to support Power Domains. He had
> an issue about -EPROBE_DEFER inside the power domain subsystem, this
> issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
> if we fail to init or turn-on domain").
>
> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> Cc: Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
> Signed-off-by: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

I'm still hoping Ulf will pull this patch along with the genpd change,
to reduce synchronization between trees.  (That just leaves the DT
change's dependency on the header in this one).

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWXMnXAAoJELXWKTbR/J7o0wIQALH9gywWendv2eDXhgKoqobh
NbjV6CoycPpRdeBk3ZJCeetaBuh3AJRx8854ZgiuxQH46C96odXepoQjIRulznAv
I5Qxeg7yD4zSNm25OR8DBOZgyovPbOo4s5WmHaxmyGOInbYOUHq2yC0x+u+3wLLy
mqGb/eO6CY2K3VJr7UT6YWElrd1eKWIBhqp1zGx3aLCj+s9MiBj8LDF1C0rX52UD
wXLo+hdp6xdH6exlUnf9yXVVy5Mj5a7pomjPtV5IWP3D0rHhA9GXq5El7MQfGX4g
GSS6UXLWXzyO7Rjejt9gSBfSYKE7Gm99eI3ndkYk9Njr8kzVCw0dhLoBL3mgSbnU
DcPLgP2hc5a+hINxJn76a17Oi66y7ThiM43S3j50aJg4713u0lEcvaOIjZq0kt7Q
oK4KgjtLnaYm4OctE4fzq2DZ8PYVSkMSjT+qdF5HPZVBlG3Osdgh3PBWwhEBoiWE
b1wMfLgN8X5dEtsRTe6WRNCUpmIA+UQ2LWWpoXtRAA5ppDs7MXGVmPnLys3UgVX6
CGltfOroLMZ5HWgsiN3cuyZsn79JQhAH1fg5GVd8YJvCqBjhIRlNsZ/Kty19lLm3
84kGjY0osdzIPerKMMbcjXTOVy3q1+76ZysTFAgaLSSdY+KQmHYJ/O9DTC6qqxbD
J0PcXnIHXdgU48QL3ihJ
=AeB0
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
