Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793875865;
	b=4FweafQXTG72kYl6Ng107TdY5krhWjlemUAsTRSDOiVdXiJJ5+0DBB3UqH0NDYI26Ugd
	 OfQpuv93+345sySK56LBcWSm1gEiMEeEwK4JtYpVtDMaNVCaYumIVVVDgf7Ce7rjpR4Xz
	 I/kKNM2lQ1vNxZpebNV5jAXELShsWTufEed5L60ZlvDOJHVlbV3jpdMhP4geaJnYR5D2R
	 j2/XFjKiQu7PfT/m0yX8j0M85zXXOpByEpfvXNfMK1ggNKezojjV8+JY24jSSzFHNLWhq
	 JNOeauGVuN9l+R5uNqHvE/x4hC3wro5RrguKYvrp/BU72SPjV2+LDeXI2Fjn7bCORpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875865;
	h=DMARC-Filter:Date:X-Lima-ML-UUID:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=7doXEY6tEGN5XpIzKlfdDifPRAKlhLQY5Fydrjzk0gk=;
	b=1sHGGhbyPEb9+0UFYsZ2wk59SjHJ7hTN+omncSXY9xYQchFL/T48M2uuXnNyY3SaZD5H
	 fJfP5tDhwNsgDxe+UDyvabb99d+++oMXRPuqCjjhpAD8TXtItPSYV3H0ukS1Q6OSks4qH
	 X+G2FHpB/mZxDvcCVRptki+Ak/kmVQYXosYjHf0tM9C1hnNgm6wv0bpVpHmELkpMCuWai
	 Wxb7om0Ub/EDZ7+IQQRkKG57sc8Su/vXczt5OLpH5K8LjikJIPtoblgIfncGtumJpekbb
	 Vz0RtqfgLndo3QQRpxG/WGoQbkIU5rjQao0NzWgVVEHiSggnXLV0UFz3gIVk3ewvaPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=ZsDmta6p;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA5606A31B;
	Thu,  5 Nov 2026 10:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7FA5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=ZsDmta6p
Date: Thu, 5 Nov 2026 11:50:57 +0100
X-Lima-ML-UUID: c2133058-0a16-48fd-a715-ac6746bedd72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1793875861;
	bh=7doXEY6tEGN5XpIzKlfdDifPRAKlhLQY5Fydrjzk0gk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZsDmta6pBve8jY+VNr/QVkzxn8A09WLJ74OFTgDN26hqDkDqbSOHckIow2DOHDyKh
	 8YMj851StYI+d8UvNQwMkkgVrdpRo1YIDUz+GBMBVBxq/f0K9Om2yqOW4HmSU2xP1H
	 gxoPkW3NObZ0e4/5evRovlFUqmN8w6zwSWMF6UBqqFzadLvvtaab/XDrhY5yJpbZYj
	 PlokuxOw622TqnQZj5saXfktP4OfNqgDxznJeraSCkTyHI9b50tJqTh3kPbgXYuZMw
	 q3VenZSSUQJwfewT6Wr03HfVkYFPIoQQUjci/HihwqB4P82iQs7Z1azSFkfc2APvHS
	 LT2Mt5+CEyhEA==
From: =?UTF-8?B?QW5kcsOp?= Eikmeyer <dev@deq.rocks>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <linux-acpi@vger.kernel.org>, "Len Brown" <lenb@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: x86: Apple T2 systems need early CPU offlining
Message-ID: <20261105115057.573c3725@kait2en-mbp15-1>
In-Reply-To: <9bc46362-6b3b-48e0-b1a0-0cc7e84fd151@intel.com>
References: <20260812120326.155226-1-dev@deq.rocks>
	<aoCJGj8HixmJ9oaZ@wunner.de>
	<9bc46362-6b3b-48e0-b1a0-0cc7e84fd151@intel.com>
Organization: KaiT2en
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Aug 2026 00:27:53 +0800
"Chen, Yu C" <yu.c.chen@intel.com> wrote:

> Glad it helped! At that time, it seemed that the issue might have
> been related to broken Mac platforms, and we were changing the
> generic x86 path. Maybe we can wait for Andre's feedback, I
> can try again / or assist Andre - or just keep it out-of-tree;
> that's also fine.

And you waited for quite a long time! Sorry for that. I had to fix
other things on our cursed Macs before being able to investigate this
further. Hybryd graphics offload etc... And in the meanwhile, I forgot
about.

First of all, I tried Chenyu's patch and I can confirm it works as good
as mine and as such we can forget about my bloaty early offlining.

But! The actual cause for slow smpboot is simply thunderbolt pm on
suspend. We don't have that issue when using pcie_ports=3Dcompat or
acpi_osi=3D!Darwin. It happens when using pcie_ports=3Dnative and also
without param. The slow EC-unblock is caused by aer. pci=3Dnoaer solves
that reliably. I could not find aer to be used in macos anywhere, so I
think Apple doesn't use it.

Well, however - OSDW acpi tables are significantly larger and more
complicated than !OSDW, so here is a bit of work to do for us in
thunderbolt.c.
First attempts are looking promising. Resume is even
faster than with pci_ports=3Dcompat. A second or so. But we are
struggling here and there. Especially with rtd3 and such. I would like
to have this working before submitting.

Andr=C3=A9
