From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/3] PM: Renesas: Remove dummy runtime PM callbacks
Date: Thu, 25 Oct 2018 01:20:28 +0100
Message-ID: <20181025002028.GA971@kunai>
References: <20181024135134.28456-1-jarkko.nikula@linux.intel.com>
 <20181024142200.GA5637@kunai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181024142200.GA5637@kunai>
Sender: netdev-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pm@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> At least the I2C driver part of this was on my todo list as well (just a
> bit lower :/). I wanted to find out why they have been there in the
> first place. Do you know if such callbacks were needed "back in the
> days"?

I see now that you referenced the relevant commits in the patch
descriptions. Thanks!


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvRDEgACgkQFA3kzBSg
KbaDBQ/+KTpFHWvtzXdOg+h3bFKG7Ta8pS7RAhlNLEuHAJ13puGdNoGIS09aVuQW
WgkAj7osjFqkLApx2t53T3d2Aps7CCTHNfeqMTQYEzAUQvDYlI3ryw0J7XJZNzHF
MOzbHA8KOQVFkGY99n2YPVmc7lmFQA7ZmcTFwEMyzvAIeMMLW6W8PM9e9Ju80HG8
BpiyIu1TUAzxvS/dp2XUl3e6+MIR0QPrt3uViKS5otlBxa2ATz6Fs8zHs5ASyMuw
EQPgextL9Xd7EAQ3/PjCCFVmhBy0X0RMFGmMYBpwkmweXqfxSOQ6ojIMclgd83O1
DLPrnlyRVbpWf3JAwKC2m9zLkt9fJao5wgSeTTlwcZqfkAib6RISfaIpZt01wkfH
wmObxb7Q6AjVu8T5Fi/gKIagKp0lzrioRbV+XW1YbJ8U/gHRkFwa5eR/wsoRtsu5
r3d3ZWfRjY5pkYpUCsXS9x3/Xf+XVQsDjtcf9KBafz+OrX38vb7GkvdMedmQk9+Z
F4bfQlKlXGzfu8LBK74h4BMfkayeT7Og4orPmYeJrNDTFXzIWH96UlNJEuyvjqzv
1kAw2GXkglirdOCYMqr+C51RSyPJn1/8T/NObpTXrZHN2E7XmqFIJ8FDorgiVNZo
qt2yUCTkvhveE2k9EXmGSCPmMshV98UyqeANHr0mXOQOKo/o4HI=
=O5ra
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
