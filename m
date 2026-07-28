Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE33EB80E
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785224177; cv=none; b=ctiKvCenAkk1Mqt4gkYTFJZvnlTwpkysySiH3NZ2TfiWZfHzChFjzIXQ1G1tU2CSZ2X538GJI1D1S5s7at6YSnbYWGDm31ZR2cpNeZfKQXfLj2w6gzb4P3icXDP0UZVWwMqgW43s9exjVTw8MuOYnquoh+yUVbc4AGr1qTMTSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785224177; c=relaxed/simple;
	bh=zD1KpZCRmFdKHdbkGPXPG5Q1MTBnSFxBZmHtGjMV2IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIIu6clnpCr5HgEO1OzU5BQ50GoQ4seNbkhg9iWB6gEX3CDjCgSWhs3piXzcRQJ3bYWH6Mh5hrf/atx/mCjtmjCpGXQ4tzgmGMpqUQIH/p9Z3KLGpWfxHUN/0J5Sug359Z9xZB4RW5Y9+dev1rAevKMeFBKiuBgYU0HLJjOw72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=bsB2snGI; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="bsB2snGI"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb787dec99so2163820a34.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1785224174; x=1785828974; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zD1KpZCRmFdKHdbkGPXPG5Q1MTBnSFxBZmHtGjMV2IM=;
        b=bsB2snGIbE/MA5vbabJxVrIfP3+LNRF2g2Im5nUlL40uWkvx0yJq5k96YNCiTOprCY
         ymwxg/cHyzZTmXckxfuJFbOVctHvYN0yUmGEFaXRcb2SBs4rmfAhQgw18hgONpac+59l
         JZErel0/SvN8TN6B5NQp+dnLLqhW+jwCSqZVIOQ9MvKWd4S8BUQelQiZMbo7pV8rRp3b
         yT4jg2eDsnve25dhqem5L1zWLkUrY8Ya/274KqaKZPX4GoA1IRg7FKmeoz8imzA3blJK
         nLEOUXUoB6U8nHYdd4hdIudDq6HXB9YqX478ISMzTfJmG0or8+k5dpMDxYv5c7lT/l4u
         80lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785224174; x=1785828974;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zD1KpZCRmFdKHdbkGPXPG5Q1MTBnSFxBZmHtGjMV2IM=;
        b=lD8nCu1Rfk4lCGu8rv1pX3KswxYKX66z0D0Q7OblevPQu8bRMSdnb3T5tDbmL9Guc8
         JfTW+BERqYmcjRrLz4rc1gFYdk3EkrGqT5g2uX5SUP4K+NJ3KUsuL4r5+M3cnOh70Ydn
         LpTDrPvZ7lIaUV0id5vQfKDIoqRdKuntuFc4hSgfhSOCgfDHie8kzwEoxiP2b/sy+Von
         Uua2TYJi+lBSAtOGjZ2VxU5PkIyMLP2pxFohCyx4k37acETNznlRCltyH4F534asrd2B
         k2193zQxxH4MJgzAGa8uXXQ/VRJR3DVzjYzTFY4r11Np48gsVfZgDDeT375sFn12d7hz
         0L1A==
X-Forwarded-Encrypted: i=1; AHgh+RoPreYm8vNvelo8PMWQXdRI3N5XWLP2r5GWyN9QQzACDFPvdxnn+CqHClbP4UPGZm3Uh/OGprVdmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1f3GZIXpcQsO4zyRTBwNylB9ORlrc4/qxbQqoF9tCgQQXR0d0
	isbjHALyy5vRUmOdoBpIcYsqVbRxIM2O1TddZ44in2RsB5PoZ31aFn6YkwoNfHjcDl0C
X-Gm-Gg: AR+sD10Y8bL/MzWpliWtHIYGPI5AUR34LghYmEn8+YJe4pXv0uB/wutJnayDePt58MB
	S5tObGoZWO+BUtLYlTxSYPRnCWYCekvTRhf1AUdakbTUdDlefjAMVxZUND7nS9gm1Jv81QWARw+
	IFY78AA8tdaBnhs/owi69mdMQIFSr3sw/z2MMX0lhB2gTGZX61vjB23bAawi7xxrwQP2f4pduQs
	n6ezGlBGgLDxNKSkZCppl2TGeh/wR/raY3BvbD4TG536seGUXVBC2dBjL52q4EUJ31uohPuHrCn
	MamSXrOa6StTq1nbl7okjzzCMZG0Q9mnG7WSKwFRDYXjKdcaVYfNDZtkZ/PfoJHSaGcnh+977UQ
	TzzU3BebifX+/k/Q49btwBH74f6duiAb7GAx9FTnVRKE6r9BAFDoljv8OWl+9DyjYHVo0tSmElq
	XgT8lAIefJIMW9sB8LcJpbFdsh6wzZSApJd0RaKxUWTKhm4Euv
X-Received: by 2002:a05:6830:2b09:b0:7dc:c7aa:22bd with SMTP id 46e09a7af769-7efff074014mr1032305a34.6.1785224174484;
        Tue, 28 Jul 2026 00:36:14 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee4f10b691sm11081714a34.5.2026.07.28.00.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:36:14 -0700 (PDT)
Date: Tue, 28 Jul 2026 02:36:12 -0500
From: David Vernet <void@manifault.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Changwoo Min <changwoo@igalia.com>, 
	Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for
 recently-busy CPUs
Message-ID: <amhbUVVyl-a-pUKC@maniforge>
References: <20260728073150.54964-1-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ix75mscgt5z7z432"
Content-Disposition: inline
In-Reply-To: <20260728073150.54964-1-void@manifault.com>
User-Agent: NeoMutt/20260105


--ix75mscgt5z7z432
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for
 recently-busy CPUs
MIME-Version: 1.0

On Tue, Jul 28, 2026 at 02:31:46AM -0500, David Vernet wrote:
> In active (EPP) mode the platform autonomously picks the operating point
> between min_perf and max_perf, biased by the EPP hint, and the kernel
> only rewrites the CPPC request on policy or limit changes. A workload
> dominated by one mostly-busy thread that takes frequent short sleeps
> (common in gaming workloads, for example) can fare poorly under this
> strategy. Each sleep decays the hardware's performance signal, causing
> post-wakeup bursts to start at a low operating point and inflating tail
> latency even though the CPU is essentially fully busy while work is

... Argh, sorry, got my aliases mixed up.

+cc the rest of the AMD pstate driver maintainers (and removing Gautham)

--ix75mscgt5z7z432
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCamhb7AAKCRBZ5LhpZcTz
ZADsAP9HLR8AExgpm+XUCKPB1EiyPIZOj8S9wWPJqt1e8f3tQwEA2vOUwaJaTCrx
c8jUm8pEIf8q/kQFB2HHJDnHUSNVLAU=
=TZIx
-----END PGP SIGNATURE-----

--ix75mscgt5z7z432--
