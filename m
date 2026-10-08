Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ACF3AEF2A
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 03:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431339; cv=pass; b=FhM+6Q0UTEt+krMxYkqKc+CbA8Io54mKpIU0THzrDhDn3/oYzYwj9d+7vyIEKshDN/Bq/OcVdPvkl8/dwYWPuvTZBWzKKNzsiC0coRXKNcDYtp+xGezHUTT9huAfJ2pXSMEyae4/WExKYB0v3lxKybDC0Os80SFNcTj6rjeru1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431339; c=relaxed/simple;
	bh=LPFU61oTqBQe4zEAKUWR6UAJEHJ7Fl8Qnrkmu7wriAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5mFRtcIKwkTwjq6lz5jscJEU77TZpaIkbG0kuyoJ2lrCY5t6r3WsSjhMxVZG2Zbk7uq6D3aHa2xhEhz7PQmvLugi5Hkiflb3JQxNFSNpeUIGlQWEJKmOMjuODyaTnHnz4Est/TvOd2/jvXXuVkg7B9yurncA+feXwtRoGwRBd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2fN53oj; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2fN53oj"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30b6dad2382so5770913eec.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 20:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791431337; cv=none;
        d=google.com; s=arc-20260327;
        b=s1tV5VOPPFx4BjW7MFVaZphbL0OCQk9oFiC7eKt2+YyJAOEhFP/p+dcuPcmEhP4bSR
         qmGs4qQCim9DY/k7rIo3AuUAK5YonDiXOItcfAGu4fT4AkQeatJJPgSwEO/Nd40QFm5n
         KUv0ELt/9cBxI5n0Mhb08FaVQ3zM/QXFQzm8JAWPq1L0uBsw7HkAMz74EZvuaEL6glVi
         iTRnYWY2hN8fuPxOSdWm+Db7UCp52WsIl1wLLrjMwkQ1FBgeCRPsal3pThKBoHOwTcFY
         CwEpbKD7RcalJy1xrIcVgBn4r3ZbXodfil8iubkvbC0ab9kIrIWCOgMpKdDN9+/Yyk2t
         RWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c4ttmYSwUBzoQan5NiM6BdFKHOxOFt2+5WQ5DGwkjbg=;
        fh=2Mp7SpNISovM2ex6zJZElJfc1SomXB3tvQGvJ6ReIfY=;
        b=GTG53e38y8jdK3udpoRPGeg632gzteNLT+n28eTvaMw+FPjsI9GjJJ1HSHfGlrRjkB
         53vGrhKFN3D4jO7pWtFpXLGVYv6xJEKpHmI6WKywFjRZb0vJz3agel4c7KGoblEx5lpC
         5pOYOZGlGK2akgVMeyo3hb4Nd3pO7NNsaZHE9X2+WhYBFXJUdgxH+97UWvDtGGY9/AMV
         G1x0O7KizXIcXwWficNI4qd5M9QIfwvyDSm/VQZLnmEgy19pG9/T7vliEmUlLmXqtt/X
         n7Z4m6WuM05MIwEV0z4pOFX8m9+gsYMuETEuqEQwO90WpSCJHcFruqSdDu0az4Os82G/
         eEvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791431337; x=1792036137; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4ttmYSwUBzoQan5NiM6BdFKHOxOFt2+5WQ5DGwkjbg=;
        b=e2fN53oj5k6mvaYueIEmQHhhoiwmUA1oOpHEWB7EEVGZDBgo4lfAPEVAVrzuJ1f4rT
         ifjGPMRRHyA40jpJ5UgiAV7Rc/175Zrgj3DijVELTQVoZsdGyNpxUO72sG9Wkt/YDBI6
         +oobtdu5U8B2N+72uzaj3Ddv1PxxEubzKI4Gx4k78ntjFz5vKRrEOTcGCVXhQA2Ijz9r
         Eg6t7qplaEpjut72YB6H6kBsx/l0CqY7i9hBnuZxnSVNBnAScoyPyQVDaLLcld1QZr88
         jWblC5BBgXs2qnEdbVR1FefvBRKWe7ADOZjkAZbZcZw96h8ioegB0OSUU5mIDJPCRgy4
         goyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791431337; x=1792036137;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c4ttmYSwUBzoQan5NiM6BdFKHOxOFt2+5WQ5DGwkjbg=;
        b=mKYKkd/TNve/k/qEnr4jGiZKaHyQG8Hhq894Cq7oWalPj5cVyx7c3ZsRn7X6bT+a/+
         d8qfA4HFMojzNmbYtXhLve40Sg4+3/pmaCowVQ1YJA4clV5CUyzuKnJBJwviMmYKOyjX
         Rk262KmEX1KQnfoJUAW7m3mhRxwTOS0xODuwrgB2PmdX1EIDVWBhi/lXvoH/h+AivPgc
         RSEKVG7qnspZhBo+iudNxvAA+FAmYHMbCbOiRGvwoH/GTgVHHocPtxceth5dggN3E1Fy
         1fK77Qjf9Y5mH1cyoYGrKf+Y5SFhKs7lA5gZOxmBqPovMYWYuy1jw8wWBXe2SHRUE21J
         IDaA==
X-Gm-Message-State: AFq9FYLJnoVz063bpM74Fixu2rYFFWGBINckDVGiJSwRNy5AdV2jFYrU
	1QaAeQrcTA4IqyP/YpIRnrpeDf88+JTBrHar3x68hVJUxG2BRzuzfj0zqwtqHF5IrIydTnQLXcj
	RTZtuwECTXE91eUCzK6y4WHdEwinbozx7T361kS0=
X-Gm-Gg: AYBFou0CS86Flk1JMb9azQawOJ+Pd+3Be9N8Y6MmMTBSLZfvByJXffL0xORJGFV0fUp
	BwJW/Kbhuv1LJFwfAOtoqOK+d7xsYIdjfL4SFhpeA/N9+JV1iKLxGWC5Vpymsfm16OOD5qunyeN
	FXpU9dyhlxd/RCp8JN1bOqstEhCTdkgp9KzJMMOdbB05/Xf5sL7tEPc29ZcuUjFNGUPt7cGaumz
	uWugRBY+t+a8KBA4CxmIrSDgoo2mTafhZ8TojFtXWYDPnabmLSswrfXksO5Fnm+X3CuVvmYUTuN
	PLyiQ2Mg9cWS5ggBb4SrTiIICKRt3BgePapdUIiE7F+BaKB/bgEIv9HRn5BHEAAM0fZqxxfaS68
	pnP1/5IwtXlqKUH7ORdFbJFyQJ3a+/ZYqW1MmFdQ8q4/gPUQ4dMKKI3/W6aTb5Xohiue5ndF9n1
	1W+II=
X-Received: by 2002:a05:7301:b06:b0:351:515b:4e85 with SMTP id
 5a478bee46e88-3515dd78cacmr4880547eec.16.1791431337244; Wed, 07 Oct 2026
 20:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACiNov445=gavzZY=Yz74HNMUgd2BKoYoazWFDRRsz9uhA_rfA@mail.gmail.com>
 <CACiNov6n4Sr4nkAnTXJ9ZmMz022KebfAM8Hf2JV_EZ+KVa9THg@mail.gmail.com>
In-Reply-To: <CACiNov6n4Sr4nkAnTXJ9ZmMz022KebfAM8Hf2JV_EZ+KVa9THg@mail.gmail.com>
From: Angel <angellindo@gmail.com>
Date: Wed, 7 Oct 2026 22:48:19 -0500
X-Gm-Features: AclHuK9YFkSaq6D3ioA4jsLkW7LOkMEvq6st96fcEJeANLoyJjckzhq-Ds0EBNo
Message-ID: <CACiNov5XvayanL6SED-z1pLY9rMnyVbCdf=RyyhLXzDSLcXuVg@mail.gmail.com>
Subject: Re: [REPORT] Kaby Lake-H (MacBookPro14,3): package C-state stuck at
 PC3 on Linux, macOS reaches PC10
To: linux-pm@vger.kernel.org, rafael@kernel.org, 
	artem.bityutskiy@linux.intel.com
Cc: rajneesh bhardwaj <irenic.rajneesh@gmail.com>, xi.pardee@linux.intel.com, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Two more data points:

1. Reproduced on a stock distro kernel with nothing else running:
   Arch Linux live ISO, 7.2.2-arch1-1, default cmdline, no out-of-tree
   patches, no desktop, intel_idle. turbostat, 6 x 10 s per stage:
     idle, console on:                        PC3 93-94 %, PC6..PC10
0, PkgWatt 3.8 W
     console blanked:                       PC3 98.8-99.0 %, PC6..PC10 0, 3.5 W
     + amdgpu/snd_hda unbound:   PC3 98.8-99.0 %, PC6..PC10 0, 3.5 W
   Cores sit in C7 99.6 % and GFX RC6 99 %.

2. macOS on the same unit with the same firmware setting I use on
   Linux (gmux forced to the iGPU, gpuswitch 0) reaches PC7 ~95 % at
   ~0.2 W with a USB stick plugged in (PC10 ~80 % with nothing
   plugged). So the forced-iGPU mode is not the cause.

   Earlier I also tried, on Linux, taking all three PEG links down at
   once (Link Disable) and putting both Thunderbolt controllers into
   the same state macOS uses (RTPC(0) + _PS3/PCDA: Gen1, D3hot, power
   GPIOs low). Package power dropped to ~1.7 W but PC6..PC10 stayed 0
   in every case.

Thanks,
Angel Lindo <angellindo@gmail.com>
