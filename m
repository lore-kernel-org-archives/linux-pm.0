From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/1] wm831x_power: Fix off-by-one at free_irq()
Date: Mon, 15 Jun 2015 12:32:37 +0200
Message-ID: <20150615103237.GA2535@earth>
References: <1434282918-6980-1-git-send-email-yos@sslab.ics.keio.ac.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46141 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425AbbFOKcn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Jun 2015 06:32:43 -0400
Content-Disposition: inline
In-Reply-To: <1434282918-6980-1-git-send-email-yos@sslab.ics.keio.ac.jp>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Takeshi Yoshimura <yos@sslab.ics.keio.ac.jp>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Jun 14, 2015 at 08:55:18PM +0900, Takeshi Yoshimura wrote:
> An error handling in wm831x_power_probe() mistakenly frees a failed-to-
> request irq as well as other irqs. I added missing decrement of the loop
> counter.

Thanks, applied.

-- Sebastian

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVfqnCAAoJENju1/PIO/qaAjcP/A2C0SM9ZaB53G2Mpkv5xxAh
+iyF566RC/5uTCRrO6/vabmIHAClvXP5IhVqeJrl27Hvm0KKVa5DCJ6s9HF5FCCO
zw3h3gXoHQWK3DTYFHrPRGTrXqnCErY7nX3J4NClDGfCBdjSKKNJ0F7B7sT4Rm3g
vXNlOwdlnveQxAh87ap1rjhYKqY3jzVquxMLw7tqAYtQgWAkrF3jDhPIME7Ujb4l
0gS2ajNKP90vHUg98ChuA+aKB+FBoE+9OoRXWVrRaeXL1xoZ4SK/Rgnkp0LDkOhh
PgGXUNwnYPpoOw0PraFHcR4NIDykxrPUwvDDcZcnpTMgB92fH4PoA13SiPQ6AtAE
ChKKCS9X+ocvPqaIFZz6FaOk/PyHNCSv8+CFkjVda1dldYRm17JnOEcq7IPmKGa+
r9gHhOe7DC3FBbZ02oCqmbxMdxeYJ1/VQFAEqG+0yYhCgNkCBU/NT7YBe8wnlGg4
/jx5DPXeDFica+fz7at/E8v3rLEguZuSS1vASLJnNaoK68j6J3C6jtjRsgH1T9Z7
TMFdGp6ux0ID4YhdF6QCjY/SCzppiFUGxr6hfFnsMNNAWerzZvWVz8NaaCLHjl9Q
k7HAMLQY9u8cqsTeqr6welypj7bKefKrFgJCrD9iUwLxhEi2t/Crizke5IRiGNet
eO8wcuj0sany1mc9TFF1
=q4VI
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
