From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] power: reset: syscon-poweroff: add a mask property
Date: Wed, 15 Mar 2017 21:45:13 +0100
Message-ID: <20170315204513.i3cpl4ptyevtyyp5@earth>
References: <1486472054-4367-1-git-send-email-guy.shapiro@mobi-wize.com>
 <1486482966-4497-1-git-send-email-guy.shapiro@mobi-wize.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wspwyo7wchrwmhxp"
Return-path: <rtc-linux+bncBDXMLNOH5ANRBX6PU3DAKGQEHTRZIJY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1486482966-4497-1-git-send-email-guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--wspwyo7wchrwmhxp
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Tue, Feb 07, 2017 at 05:56:05PM +0200, Guy Shapiro wrote:
> Make the syscon-poweroff driver accept value and mask instead of
> just value.
> 
> Prior to this patch, the property name for the value was 'mask'. If
> only the mask property is defined on a node, maintain compatibility
> by using it as the value.
> 
> Signed-off-by: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>

Thanks, queued with Rob's Acked-By.

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

--wspwyo7wchrwmhxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJp9cACgkQ2O7X88g7
+poUXg//YVvSVFLN+yCg282zEWVPHRSG0sqsj14LykFmOBm6P/x6wlzDRm57AQ6t
RAwigdpSzPdi7BEjXnvNDv2oHx0xd3h52wSx3NdxUHUxQfa3D0K/eNU+LK4HbdB6
Whs0gaRYC4D1SjWrZ6+GFWSDSfIW/r8CBEUTF6MG5uIy1F1ErIVzKeX80KOM+I8I
2eNj6wV2Lq8z5HSrt+Mswmsm5PaKUwucs1zNrl2f56tjkh0DmReXXoB1arYuzoVz
MiRwPlIZq4MOzAwsHf3sH3SIj4NBeMi4Q14O3aS2BsxmvNSUxV2PuMhmMLZ0FzqB
K973y9yS4yuKCNONY4AVEFen0d12jzs74UhNCHLcZBDH9ecX8DaHbDGsKEkgPaSX
BluMFrdBy0kCTkZJKLGVLMwSEtLRmLV4qDjKX4UgW8264uEqJnHV57tMw7LX+BCc
dIxGBWu/r8PrrfuXwUAzVslTEGbA+Agtp6Asz36ZuS+B55J/Dl3/q/j8XjKhgvSe
tlBD1ZxVszngAqbhQ4s1xMOWuHWvVNo55asg1MrmTsGMQJfffAOxxqoxTTIMTbw3
C/h9JJwn/Vm1GPdJaFlMvebKYMDZIu63zKBgbltEc5WkYnSr1yVyiSLWJcUb9AHg
A2rl70vxMLWglhCSqKNGLmlgY4PMZ9YoPmtsmIvkSQFVv6iQa1M=
=auno
-----END PGP SIGNATURE-----

--wspwyo7wchrwmhxp--
