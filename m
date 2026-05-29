Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87143C054
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080572; cv=none; b=Z5U5ZVCZaW16rd9akNGOlSaLbTaBStSGOwDbPosEPgMytiHH7BW6MNd1ldo9SXjKTfSXSGCsuw3q0QSkfD7HZC/tPMRLh8yQ1F5qHgATeAAzh9ZNSP7KSEFFYwLX4U9FIP0gj44Z0jhmqQBxGxWEhenOIvmE/lk6MdcY/J1JNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080572; c=relaxed/simple;
	bh=lp4vtffxigjSJ7RW/i4Jgv4QK66o94cv0dvcll4cQ/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jba5/AAI+ldJK5stmOHg33OCxbmQcECZuwH/L4cMPBiB3vx6xWf36R2V2x4ENkN9roWj1Ya1xF7AbC8C5WuPmU0BbgLEJPDeMPqVcjlwVloDAC0c14nwDJclBzZgLbHVAqrWfrmsrXv0fpFy3j+lg7aL7E7zI8DGYA7ueySlpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=PT2c/SHL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="PT2c/SHL"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ed18d8a1bso2904742f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 11:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780080565; x=1780685365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lp4vtffxigjSJ7RW/i4Jgv4QK66o94cv0dvcll4cQ/M=;
        b=PT2c/SHLWWVReh4JVbObtDwQOCTMAnMb1ruHq1KIYIFbkdDuvWsXKPrvK8gPaW/mlj
         yGBW+pYzqer9RxtpU9ZoOqJpWRuJL9r8m/+qSQe5rLQlodXdTxYOHDdgMOfRoruKevEi
         R10Deic1rLnOANHCWXiV2r7ui3XS0/XoVd00UpyVUwKMIvcCGxuMU3r7964FrpWBx97A
         xYL1C68ezRSZmXSXcaz9AXEh+FaLHMUJl/18N5YmslkeH0fSAfXwyiwCJx8Du+a7A8rO
         SoHJCZq+PkyFw1fLVp0CYf1fRN74rRkxoHVtEH50smR9BKOCPlu96103StF+Ihp6RCWx
         B2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780080565; x=1780685365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lp4vtffxigjSJ7RW/i4Jgv4QK66o94cv0dvcll4cQ/M=;
        b=I6Zwjl/1sWMT5HdxKbzBT4YJx9ziibNbBaWvGDGnkrH/DoXpt5rfdkySqbDphMey9E
         JO2qbkskb9axZXTdn+q6lnsAu1zszn+fYD26uw5q3j6wFIutmKqD2rNX01czBz14mpMn
         TuI07F3TwhHtuHjQB4qauvAm3tP3oYBbeo1l6C+bdTAxJpnbEpgQtsaeKQ9Y96sRneug
         rxFIghKswzEb2o2IqrOJ5QoKF+fIIB5RD3AhfsS6kz7nN0zxxtHLLSS2M95ZARDe+QNs
         2l/dfLUpSW797xpnFsI4ayK1gYlS3z8gVO1PglQSYGvYiEiblVtYZIvsackF5rxPMTR2
         GJOg==
X-Forwarded-Encrypted: i=1; AFNElJ8TCDyeWHJHdFmQqtqrvQJAAnzQ1MPVzCy+1EhdoATzfL1rCENk2GU/d0EgxRFW5XYcRPnTN/euow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhokRBnfVnW81kB6I5SL7TXfMJoiMHF7rgjxEQzAsV15UXBgR
	SNXPyLz7Yd/9EGu+nKESUqafFjPenX7n42n/CAFk1bzP0wY3FHecwoEbwNUF/qhT+0Y=
X-Gm-Gg: Acq92OEVFT0z/wZHjFqXcLfRCmEX+wcPGOZe0i46I+xDOP2Adfwf6pPkAAlCTKdm2PG
	/PM0mK5Xb0dhNst9liKPysfnOoAU2BuJCDcPbnfxquRcmkbHvUXzaNSeruQe8ZhiZ4eq0oI3nVZ
	8LXT57Fdj/uBlfYA64SSaV3t16zbTrWJB29IQ9jVzxixhOHrgs7KBeat33QuUilAzfk/2AjoN9b
	GnA8JepvAH80y3P9xWkXxjJuETp5lPqyDSnMG9ESnLbuCbkhntzlLLrykA6VtSllhxG4XC8dmEX
	NJKM1s2J5feGNLYbIJEBic5pkegqGcPn/XtuFLRRpqZyi1VDEFn2swf/NoSHmh87BzlnJJdoUF8
	5RS5UmO0KcT+PldRK/eLly47TLJRrBdz41HOv3XXyZC2nK9I5G/OY2fJRpJIN/I0lq/gQcM9g43
	xclaq/lajzcID65KNkHBCvi/UuOTDfwXfLXYI/Vs8=
X-Received: by 2002:adf:e609:0:b0:43e:aa88:f1a1 with SMTP id ffacd0b85a97d-45ef6b92502mr1248001f8f.30.1780080564532;
        Fri, 29 May 2026 11:49:24 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45ef34b47eesm6096276f8f.9.2026.05.29.11.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:49:23 -0700 (PDT)
Date: Fri, 29 May 2026 20:49:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Joshua Peisach <jpeisach@ubuntu.com>
Cc: Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Andreas Kemnade <andreas@kemnade.info>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Amit Sunil Dhamne <amitsd@google.com>, Samuel Kayode <samkay014@gmail.com>, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v1 4/6] power: Use named initializers for
 platform_device_id arrays
Message-ID: <ahnev6lMK5tiUybP@monoceros>
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
 <1ceacf4f9c3f827bcad85b378aa04cdca1c04635.1780048925.git.u.kleine-koenig@baylibre.com>
 <DIV4J6UGUQGG.28KL8EGBZWJSJ@ubuntu.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pzwfvojoqum2whq2"
Content-Disposition: inline
In-Reply-To: <DIV4J6UGUQGG.28KL8EGBZWJSJ@ubuntu.com>


--pzwfvojoqum2whq2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 4/6] power: Use named initializers for
 platform_device_id arrays
MIME-Version: 1.0

Hello Joshua,

On Fri, May 29, 2026 at 07:29:08AM -0400, Joshua Peisach wrote:
> For macsmc-power,
>=20
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>

Thanks!

> (I'm not sure if one can "Review-by" a specific section of a singular
> patch, but also the other changes in the patch look fine to me, so
> consider it reviewed as well.)

I think what you did is quite usual. The restriction doesn't make it
into git history this way though. Another usual idiom that can be found
often in git-log is:

Reviewed-by_ Joshua Peisach <jpeisach@ubuntu.com> # macsmc-power

(intentionally added did s/:/_/ to not make tools pick up this line).

Best regards
Uwe


--pzwfvojoqum2whq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoZ368ACgkQj4D7WH0S
/k7D9wf+K/Kbjth006e5cY3RbjoS8K9jW3NQ01G+VBxY+lHExj1dG+49FF1HI8kt
qfulP3y/YdWSh2JA4Iu/NK5mHfXtx3IWR9T8IuNyDfXpEJECZipp2WG77R9slfko
t4zpckQ+iaOMoUDYB7CB93ltVHaeYHp3Y079Vm1cylL5z2/tessr8YqNr+o5lP/l
c/36Uyh8+f0J9Vm+OEsK5r4lyPA9YxyotfCCx4qbxxAjgGbQUW+rj6MZgm5AGfmK
rcXLESM1abNV6atU3liVQQQhtTPw4t6YXGDZVfGZbyMLtuZTrVZKCQF24odWnbJ6
juiDjaO5lCkS75qD+EK1IeT4tTF/hw==
=+SnX
-----END PGP SIGNATURE-----

--pzwfvojoqum2whq2--
