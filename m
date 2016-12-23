From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Remove unnecessary
 irq?_en register writes
Date: Fri, 23 Dec 2016 02:39:31 +0100
Message-ID: <20161223013931.bucigyp4synoirb3@earth>
References: <20161222120011.11652-1-hdegoede@redhat.com>
 <20161222120011.11652-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xjjpmraoyjvwslzr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938995AbcLWBjh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Dec 2016 20:39:37 -0500
Content-Disposition: inline
In-Reply-To: <20161222120011.11652-2-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org


--xjjpmraoyjvwslzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Dec 22, 2016 at 01:00:11PM +0100, Hans de Goede wrote:
> Setting the irq_enable bits is taken care of by the irq chip when we
> request the irqs and the driver should not be meddling with the
> irq?_en registers itself.

Thanks, queued.

-- Sebastian

--xjjpmraoyjvwslzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhcgFMACgkQ2O7X88g7
+pprmA//RuPwz3cRG87Qw4Kbe9qr6NEqXEgwwFLzK9VUDSSwk+xeXeL0mqzrqcZU
CKHbO0N104d2ZM+GoHMXiF2oiYvrhgIFlqqdiiCatYL3o15n5xyK1Skuyxy7eO8l
GWbfwo80x512keo+QqTB9ctEmVdJ0EaflO5pzOsvkq1k1kKdnKvziF8002v+oj2f
ZCE090t89vOKEq2aqWab2/fw1YyBkW5YGdTJceO0M6/WqI6TFGhwtGB2IPkPQY43
qeTM0x3y5RJmqu9br/HSxvGHZNJqr4X9S5n6xcrJ1AiUL0FKLlpYQBzODniuyf0T
Dssm9npjnj52nAaVOJm8kwp7dSFZITh/m8n9qI9uAqDNbHS6f763Udp+xOqAqREV
fhKNkD5bf3vEzA6/dSFLZZO87Rk07KVFkZY41N5zDfT3nUi0HRRykqtss7lzF1mA
QT2UtlM87n4u5TiK5WjacC0ELqYMQ3npYgvfijSqqDO607kDyuEpvhW/PyQAiMVB
C1H5F0wqZuuUn6hJVd7n6wrjPHlALEkEmjTquuPIDmQwi+OZNNUA3AL6jFaSFcLF
Qvsk5F9mnz+zcQPRbRzNiMIKRy2wFej2CFOeD3rVg1uXpHiBfUr3dzRnSoW8J+n4
QMut/AglALmKjNBmDcbvR0s3InSHC0Qhd8SyOeKbCCDhwVuwLC0=
=NOay
-----END PGP SIGNATURE-----

--xjjpmraoyjvwslzr--
