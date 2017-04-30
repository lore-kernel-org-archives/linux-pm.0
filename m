From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] Add support for OneWire (W1) devices family 0x26
 (MAX17211/MAX17215)
Date: Sun, 30 Apr 2017 22:53:37 +0200
Message-ID: <20170430205337.kwuwcyesofvqjddl@earth>
References: <20170429143429.5685-1-minimumlaw@rambler.ru>
 <20170429143429.5685-2-minimumlaw@rambler.ru>
 <20170429155911.7li5torcliaoerxh@earth>
 <ee2edb43-2353-6655-a95d-ea3f3fb853eb@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5g3kwszmf5v5jqdr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1949804AbdD3Uxm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 30 Apr 2017 16:53:42 -0400
Content-Disposition: inline
In-Reply-To: <ee2edb43-2353-6655-a95d-ea3f3fb853eb@rambler.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, zbr@ioremap.net


--5g3kwszmf5v5jqdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Apr 30, 2017 at 08:21:51AM +0300, Alex A. Mihaylov wrote:
> > > Slave device provide software layer for access to internal registers
> > > MAX17211/MAX17215 chip.
> > Please convert this to regmap.There is no generic w1 handler, but you can provide custom
> > read/write functions.
> I think regmap be overkill for this driver. Here we need access to a small
> number of registers.  Registers are extremely simple on the internal device.
> As a result, the software layer of regmap will only complicate the
> readability and understanding of the code. And also increase the size and
> time of code execution, and even complicate the perception.

I did not ask for full usage of all regmap features. Just register
the read/write handler as regmap handler and use regmap_read/write
to get values.

-- Sebastian

--5g3kwszmf5v5jqdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkGTtAACgkQ2O7X88g7
+pp//g/9GyVbZKqGx6TZmsL7cw02agdGsXi8Bqhw/rRwYcpJ0w/WfFp09W5ZXCUP
AMzAUTGfwByKrTTebfHtVkU4f6LkXfqF54hYQpcAd6VP1vmY9QEuEUOmbCBVpPlG
W5dXX+NYPVPHr7eSihCrR1eCZPR2sS3Ar5apTmQQYlMa7vL2x9n/7PJNkNip6i4I
1TR4gFYz7FjfFWFZfG6elxFmMbs7/MhKhqqzKjSKnbvPN4S/SgSey+NZQMhrYnQX
CzyyrpNjp5zYOol7AtLFkOt8D0WbC59FvHVL9g5lJqVI32atsQ2jYwlyNMR97VRv
RLz922iMu4gYqE1G54RSeUbRhuQi7c6mAITZ7acP8Hu65P4u8V4FwYvfDoQWgF92
KtulTk+/IdDw2bPYVONsXBca/60TTt9Z5enkIjhYD9v+IyYHz9K1/usuwxycH6rS
bhbIHPPNHt8wdIzBG6Olq41XQ+rxJmvxkHjK9MzbxKOWuiRabiwTEzZhpsWnNSkU
b1O5RtMHTZ0duF2+VXs/HkGLuhMAIQqSUvTGIi2BUTMUm8My7A8hx5M63TAT8diK
jbkPiA5hLitS5II+DHWa9lo3hkeRpzymdW0vC/CIyO5E0DC4B4s+hW+QHoyGp/xu
1e7TtLbb6ZsJZNQmgsnw6qjR29OHkhXDJkTIfT9t48/g9XaGQgk=
=n9mT
-----END PGP SIGNATURE-----

--5g3kwszmf5v5jqdr--
