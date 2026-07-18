Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B69271468
	for <linux-pm@vger.kernel.org>; Sat, 18 Jul 2026 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343714; cv=none; b=hi0bnoPObAHC3uXbXvwxDs1nNywanlF10fRtpgOGbB84togKvqke2N6hgXjk/b+GC3n8x9GI1t59HiIVMmvzSPJY9rxOsjKbaQLp6mRc1NOb6mkvQNQO6D/PqUJRpnecEfL1t31KB32Bm5Y24Iifl18aSv/udWYGhKtYeg20r+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343714; c=relaxed/simple;
	bh=72VpdzycToFx5jYXpTxGZ7WwbQARvNnQ0l5lLRfOF/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JibWfbbY+hiQQksttjgBw03BVtaBq1dUiQiM+OHF9yKSB4RPqZ+pTHcK07zR3LUtf4UIp7VizaE1dG8igtb+XlCDdVZQM48P40T5dhdVudbfbAu2bRV2yeD7+lpRWerq1m6ZuFUEXuygMH0La2H/COatNz4U/QhSFEPGfq1IzTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5mWB3i4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5mWB3i4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc891373e0so103594245ad.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 20:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784343712; x=1784948512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=72VpdzycToFx5jYXpTxGZ7WwbQARvNnQ0l5lLRfOF/s=;
        b=L5mWB3i4qi4xkobO7fZowrtwOMgXzsK3LE0E5vnqPFBD0H8dGWAYfZQC9+L4Jk6J3a
         Ra3ZTMBO12W9loiu7OIkSoVGwY6p41OJHOYkWSx2NEvIgW+2azJABGPfjS+vreHebJaN
         owL9eYmBbJwiHlicyWVx15tgoA6EYQ9NNNoVLlmgSz60aU+m8FlBq9SYvrIIN5niluDV
         uJgEaqohd2NY8Od9QWYxyIfnriFFt89HTtWmdIbSXLAqHqOC5aB5nnUX7XdBlypr9yJh
         9oEbCy5gW/KsVohLSUJLXcbda/brHRMz4qOOHt30elP/nHESzqvpzgZH5ja0Hq3xY+OX
         /Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784343712; x=1784948512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=72VpdzycToFx5jYXpTxGZ7WwbQARvNnQ0l5lLRfOF/s=;
        b=YTGWhV3paBvWILILJKSGbpDmF5nEVNwnfh0aR3opXNpg9aPbkqYqi81mctuozZEpeo
         u/0wHJ36RLP5L6P2jdCPAVQD0qOxMVvswwXsL1bvCXlkmzdVT/7IL+fXostcJtZv03u/
         4c2K5L5B3bJ2xgK7Kivrbn4R++CtXIK9N3Gzp6Wb6N3YvX7OTcH73fcvVAy9dLDamLfs
         SD2RkGLJPMpMXnBNBKY5v3TtQR18RzYHdUGIM0ysADtf+qLA71cmmyVGbbJE+D2ignaG
         CUAGVx2evRkZsplUYcTyv01GpdpYKoh9K6n9Fp+J9IPSZWD0434IU5s8sHAzrcbWK6gs
         YcWA==
X-Forwarded-Encrypted: i=1; AHgh+Row/ztluoqgjMN4VSwIdaWNAFmX5IA7uHUUGyDw5LApJDsQyr6DDHtxoN2xWx1oFpqGmPaPoQQ7+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXMOwtD0RtT9/L6xJF+uKa/dnaDbAplMVAlpqbLAVHP9ZzFS2
	HltvPymJDBkLdx1lydzB6k1Jlu31FX3IRZsssAj6px26nazqYvPnhK1K
X-Gm-Gg: AfdE7cmGpFfxuxssYtxUUHjU2Hw+weDh8fJ+kIpuJzbYANogik725Gj37WY7n/19UaB
	Yi5VWxh3FoO9AXnhP080E/K525FRnzkbVGIGob3vhssai9x8BNLqa1w0OO0q8PlLMATnhcgzixR
	GljtG1Z1GfU48NAcnrP3pr36PWYFKFB9zeq/VrK0dQq1BpNZLdU/40HXlvPIRgC2sAj2Ii7F68G
	5Mpl1t4kCWkzsoEe7P5Md1LAqPlZVKmR3jVHdsXQMQ2SQxXNPC3g80vUWm675v4RJ3h0zqx/AoA
	83s45E6EG05xTtTq14kq02Ub2lVXzILEZCSvbTKLGDw/oiwFKnH8gsMRMYOB166O5u5Gjs9ul3R
	QceLDFzs9j9Tdsy2ztdXa+6SVmIVKrP4CXvnwdRomBYIGMACfWwxgX9BQKJwMkQt1rMVKNJiZ7v
	uvT1bZYzcoDxMjXtN2VfyIdGNXm0aUc16wT4jiZl8B+E+Nao9mkWAhcw/sS5HNoEI3Q7fU6g9Lr
	CiC4p0o9OFbwa+mvQVL0oix6HKROQmzAuo2S4wlq8s2g9cwlirq5jnYrZJjVmmzg6bIMNyqIrQX
	pca2H/Jwj4GIpSNHOgn4hJF0uT4VoAW5FBgxxOVOkSEyRuuE5PISdySCC4xrcc3z/KNA8eXRvvx
	icg==
X-Received: by 2002:a17:902:c950:b0:2c9:d8c6:1dc3 with SMTP id d9443c01a7336-2cf3463299dmr56325425ad.0.1784343712078;
        Fri, 17 Jul 2026 20:01:52 -0700 (PDT)
Received: from ip-172-31-21-198.us-west-2.compute.internal (ec2-54-213-160-35.us-west-2.compute.amazonaws.com. [54.213.160.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3474100fsm20456615ad.66.2026.07.17.20.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 20:01:51 -0700 (PDT)
From: Bruce Robertson <brucer42@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	ojeda@kernel.org,
	igor.korotin@linux.dev,
	gary@garyguo.net,
	tamird@kernel.org,
	boqun@kernel.org
Subject: Re: [RFC PATCH 2/3] rust: power_supply: add power supply class abstraction
Date: Sat, 18 Jul 2026 03:00:58 +0000
Message-ID: <20260718030058.1677-1-brucer42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ak9kAP1SZF8AchQT@google.com>
References: <ak9kAP1SZF8AchQT@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 09, 2026 at 09:04:00 +0000, Alice Ryhl wrote:
> > +/// Register a power supply backed by driver `T` against `dev`.
> > +pub fn register<T: Driver + 'static>(dev: &Device) -> Result<Registration> {
>
> Should this be &Device<Bound>?

Yes, it should. That also lines up with Danilo's comment on the i2c
side of this series that I/O-capable operations need at least the
Bound device context. Will fix in v2.

Taking &Device<Bound> also helps with a lifetime problem the cover
letter flagged: the trampoline currently recovers the driver's private
data via device drvdata, which the i2c core only sets after probe()
returns, while power_supply_register() exposes sysfs before that. For
v2 I plan to pass the driver data through power_supply_config::drv_data
at registration time instead, so the callback never depends on drvdata
ordering, and to add a Sync bound on Driver since get_property() can be
called concurrently.

> This looks like it should be a ::new() method on Registration instead?
>
> I would compare with existing Registration abstractions and mirror how
> they do it.

Agreed. I'll rework it as Registration::new(dev: &Device<Bound>, ...)
in v2, following the existing Registration patterns in the tree, and
look at tying the descriptor lifetime to devres while I'm there rather
than relying on Drop ordering alone.

Thanks for the review.

Apologies for slow response. Was wilderness camping.

Bruce
