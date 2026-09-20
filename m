Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A1393DE0;
	Sun, 20 Sep 2026 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789891270; cv=none; b=nxnrXgKAJkpkWhxrthy1E0WAXO9v9+gjimxDj3IQKjQebKxXF8EPf9PBvzPaP7ktJGCvnGAHFsW/IbyhGRiPnnF4+7p2R7XyJuuygKalFx0Hft5cYL7d+y3S40kY3HWkgFehkf7SXzDhZy/Bw7LvBKSQdDVch9u6iec0e+gdQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789891270; c=relaxed/simple;
	bh=Y5tPHoLczDWNnwZ5iXFWT2WFskib+hCciE0xxvvh5Bg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To:References; b=HPgi9efsFEBlvJ8OAHHS2ifZ802G36qpjCNc5Wvk4y2qgIsRhts0lU7pyaL+Zv/wRLTZrfS80isX4ccJreiWQHqaTSUbP42OnHdP2HngJx/fvp7rR6ylFNzTfNe+DCRKFs37EuNrQeNctW+kL/o/ZYbFtDwl/ortpmz9F/aCRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=dC5IRRtI; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="dC5IRRtI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1789891218;
	bh=etqlwVVIRZowk3f8uquWoSpq/cd+t/r2MmegfPcTx4c=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=dC5IRRtIJ/5sHCSunLfzHAt7GvE5WmEKw6BLIpj/sfoXQkaKorUs9N7QxmsyBGF3v
	 dH3qy6S7TmxtqJGcUvi773CWB7Ki8gzhkJBQcgo8OATZLzc4SFqGBvfemuLS3DDKDT
	 fTLC6CNxNyAxnYaxPbowWBJ9ZmqHBJ0uFMed8ej4=
X-QQ-mid: zesmtpsz6t1789891212tfd2b0654
X-QQ-Originating-IP: ++rQGpFiadxZGjlXFjk0ZmTswmyw1WBX7/+cHBxjjtM=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 20 Sep 2026 16:00:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12539381814827415666
EX-QQ-RecipientCnt: 16
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e109c0058aed249261fbb125f7ffb89a9c6eec3c2886db4215a836200e53;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 20 Sep 2026 16:00:07 +0800
Message-Id: <DLJZH96MO7V1.11IN77H2734TN@linux.spacemit.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Ulf Hansson"
 <ulfh@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, <devicetree@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 2/3] pmdomain: spacemit: Add power domain driver
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Icenowy Zheng" <uwu@icenowy.me>, "Yixun Lan" <dlan@kernel.org>
In-Reply-To: <8301abce221e33d827053c54a64aed05f3227f7f.camel@icenowy.me>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
	<20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
	<a4359efeee2220903a05a2383a651ec8ec7284b7.camel@icenowy.me>
	<20260918230107-GKC297024@kernel.org>
	<33b33b2b79763d410bc2e5b4ef46c305aaf6f7c8.camel@icenowy.me>
	<20260919095936-GKA322102@kernel.org>
	<8301abce221e33d827053c54a64aed05f3227f7f.camel@icenowy.me>
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NbgegmlEc3JuESYaEd5BhmnZaMOyQ3XiW1zRP3ssJWGEMRyC1cyRmF7M
	IFxYhhZZehcgH4QJh/37E6fEaPt3KrEOsgPWDoO+hCXKGEtsjJ8B1Oq1SKwz+CA8K2iI5dE
	Oy2sR/YgCJ4ViEK6Gw8J1RaHXzX0rf3PIia0Fn9fTlsqcK3TCkRmSzdkXkBmwkKGE5h632c
	fw1ZLosNSQL9w0XWifdAmQN0lL4LLNLo+GNRX1VhlN+/IY7i6/2rl80S9woWmeBW101B6Xr
	+BHr2HJKdX278Ep8ZN8y7Di9AkSkIAnAuEssrRwakXyvjcM6OyfGRff9z9JoHo0nYzDfA0N
	DRflOYjtXSZ2zqPoUXc+QidYNX++hkO9Mn/dnoMaGokEUgx6XlPtkUHQHoUAhuwW7Py8ege
	FVx+thQ1mh4Rg5K02HtHKk0/ktxlbtLMOc4+VVBAaYpRCreP32kiN8m5ehDMtu658A1lMP9
	8O+dXKdqVw7MQUc3HU/YvAx3d5f4Z+0l7WWiwn9Ns94pIGRfY7mxgNclOH6knrBdzfsa+uj
	+2lN8DUSznh6Eej+rpWN5eYaLdY3nD8SM9HVAaFQ/7tnetmMdj0DZBQEf8e+B04dc8Q/P9/
	2DN7HJuU92uSQ0zK/UGBrdB+k9oqbSS3wHzEzl0BCszxY8oj/ad/BSRzPlY5gGQa4EVYctc
	7A+3vggV1hd4XLTsu8/iWivCzTJ+NONOiogDNgZxARFfZiX4UW/fEhvLHPzgpIZoHY7PrcL
	GJdo5GF9Mjwa79u8Bmm17CsoZp8nzrnaYeo++SgJNGt+e00I+rGZewriFL9IXTFKqsDKmIC
	1AikP1WTI0iV/fvVtJ8rSsSuJ1Ypq6R7/AAg92VgU5/5Ee0/BHaWxmfL+7R8XqUciTFKL+5
	BZvRjU/HOhPxsWvN7Xter8lYgpOOx7IJF1Duk6aaK+pswTAtM23F/lQGEko/hUb4bfS+3Tz
	nEKNtSkmvxcZ6oj+SRuAdxucCQyiV3Tt7DjndMRMUf7GJLd9BbD8ogENnVgr/wNK6gpXL0w
	TmyxaCJbv7yN2XDv5p46KM943WXr2Q3WZW56TYaXqi3aYmDLzJ12BeVcnnX09NAYyQcGjPY
	7zzUmALEMnIVgyjBzs/SkY7rBcjpcHJA5naLmyArTz3RFOd8XIS7ek=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

--e109c0058aed249261fbb125f7ffb89a9c6eec3c2886db4215a836200e53
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat, Sep 19, 2026 at 09:56:12PM +0800, Icenowy Zheng wrote:
> I have seen pending patch for it with multiple revisions [1], the dt
> binding is even already ACKed by Conor, so I think it's not a big
> problem here.
>
> [1] 20260903092347.620060-1-joshua.yeong@starfivetech.com

ESOS is based on RT-Thread, and we currently have no plans to upstream
our ESOS changes to RT-Thread. Our team's scope here is upstream
open-source support; upstreaming ESOS itself is outside that scope.

The pending Linux RPMI patches are useful progress, but making the
complete solution work on K3 still requires substantial integration,
validation and maintenance work across Linux, OpenSBI and ESOS. We
cannot assume that someone in the community will take on that work.

I am not opposed to RPMI, nor does this require ESOS to be merged into
RT-Thread first. My concern is who will bring up and maintain the
complete solution. If our team is not pursuing that work and nobody
else takes it on, should power-domain support remain blocked
indefinitely?

Could we move forward with the direct-control driver, with its
mutual exclusion with ESOS power-domain management clearly documented,
and revisit RPMI when someone is ready to support that path?

                                            - Troy

--e109c0058aed249261fbb125f7ffb89a9c6eec3c2886db4215a836200e53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCaq+Shw0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQvKbEBAM3JGT8zMz/qwCLlFLbDvQLCE51eHJZ+3Dft2z67
kBvuAQDFfQQClaI2mk0/LoEmsI9nsFXig4tdzJ/NoEsP9pSPAg==
=PdYA
-----END PGP SIGNATURE-----

--e109c0058aed249261fbb125f7ffb89a9c6eec3c2886db4215a836200e53--
