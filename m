Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6D84E9C10
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689081; cv=pass; b=LvDDgItTL09n+VyUxI4OpBR5xpeps/7qC+WUseP8pdUDfz428phkY/hARe0hlqcEvSDH4Kq730EvgORSYdjljZYmmukbvB2zI49djAJbx1C+LPNn3wX8vYhFdFzuF46bbLyudUkpcDah+u/jIf3qatGAHZM2O1gqGkn2LilpJzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689081; c=relaxed/simple;
	bh=dWteTL3BXpa0YmDGmSvykO7S6lZGpo57eTLfGa2OCfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mz3ucGXi7yLqCfRDjHB/3Bd9GK8JtRNkp5k4tMr8JyHyOEQ9PENVC2j/RpckQ5zXCEs1F6JDKPAkVp4eY4dm+OAcAP2xBjSFSJeUimH1WkUCrjtaBZc0jL6zNDvBJIzMgxM3HC3Areur7iVm9517iEsuNnZqg7xgU2FjEXP9W7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LApht90h; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LApht90h"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4887d3c59ecso398060f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 06:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790689078; cv=none;
        d=google.com; s=arc-20260327;
        b=tBh1suK5oKXkFivHlWjbBCziadMkU/XglYdXv3/a1+4lF1A1ttt8BKtA4/2vRary2z
         yZGzesOEkzHeXHBsTRQKn62TkxCjQdmgZ4P3G1NxVTx+oR3JBb4f8fs40ecN8j30uS0v
         8sPZft+cdp7lCugU9+xM/Qt+Al9SrHDV9zRpX+VoWJJ4kjWgVMKuKkPGaaSnbTvlikGQ
         4pdCATM0kdYk75USms/uXeRermk6C/wBWx/jSXNKgsKVqNVpKinKGpnL9svmKjMdlloj
         UlJ+TEH31n5Li+IBX0RoAB7oIQSiH1DESavspfmuOpzqsdSFur+VGdA/cM/UyigxxCBU
         Z9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CC9uPIBXjeuQ/2ZOhSRVCRq/2whEZUCcAZCGrx6IVfE=;
        fh=VuHrIMwW2VukHyUCdT7Ew55aYiXULK8z0/A+z4zqKGI=;
        b=hdgYodf+qeOeeTicoSFIkT45ChECLyjFdq9r5WDRxzpDta97QU8AXsP24ZqdUSi4Er
         zDT1vtdxzCIca+7nocEzaDHQU6PTOvHODmsTf4wZgHkn9rDjJjcYrlTQXNDvhYl1nD3I
         Z5rShEi/0e79BoZxp9eUhQl6Vvz6Kc7bd2uU0mSdXcMEvCFTYN/fiTZzxGDSflJ3hu5G
         8mtpsqS2vGZ0u965277xGz+jKIHvMCIEiRnBWvywCDr9qA3rfFtHmOWzLZyas+du/d+N
         Wtx+wjAyR3bdChVMqkbgsDIkMF2y/rgjuYLZX6ZVd9+ScXZXVp1VjC0lp7KSR/LWlWgB
         nbnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689078; x=1791293878; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CC9uPIBXjeuQ/2ZOhSRVCRq/2whEZUCcAZCGrx6IVfE=;
        b=LApht90hLVsRxhye+LHCLuamnDjTyVtxPwyHgybPMtwJ7kCSIKZoytaNvIhAj2yybY
         P7rfXNLT8xjTSrtHLWnjdBhAXnnqJLo1ArWcSBl8HwZ24Qmqmp0CoGz9Vn97IF3B2uUb
         ECodhT3nubNohGnw7j8RGyuhRYYMzO7ymxmHNbz+2zG1XAqnYUUhOG9h2Fnj+ECUtOw5
         7NUmu5dAd9hFp+O18L+p3F9pPe2KpwlcmP+8k2RGfi6sB7lvqy+kd+Q7euQglGBpPH3v
         PKQqoUuXViaPehmhRveDBHZ5XoGkWnuGolaSZS9z2SukgkBIA8MMWHkXH4cbN/Hbs/NR
         1eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689078; x=1791293878;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CC9uPIBXjeuQ/2ZOhSRVCRq/2whEZUCcAZCGrx6IVfE=;
        b=sI8c33b9iCp4/XXWZGM10vzQ8X81Vmu99CKojohHls34EIJ8GyUGqWOwlk5shHdtTf
         wwPFPvEUfCtSCElr1xeLVMZFMndQtWR9ELxLThuBHdAuyICJEM4z30cg5a0gPy8u9ha6
         KW+cu/fD68xsY2TRoMcOfw/LCsb3TbqdUK/nAByZIUjcFP7NQts4NLykDnIINbiFrWJ1
         bV/v1g7zR3U5wM+wS3GNGD5peL1tTHH2jlt1zDCsP9KFArMOXa+yLVKebOvS0E/GusOY
         h2CT/v9xAQaXcHiRBXLQt/Onb1Qt6A5mO614+8Rs1lr1jmqS7XDoxtJRcisn2YuZKXWo
         s8Cw==
X-Forwarded-Encrypted: i=1; AKwUvBze0XE982ND9lznKrCUxwW9LA8UqfmtNH0x7JlcZ79zAnlq57YogyhIDcdbUeQUfDSg/DiuC5+Leg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLUNdmbjoDy02WhfyQZNf0CVCUZ9nZYe2qul/7m4LUeQdLJQHJr
	qg8nEtwbWDwnlotuvvCOX9DB/jmNY8KDWeAbD/QdOMWKCm03WLtkF/9md4i4vlTPo+XuLqGdCb0
	+iam5aI3CrfVxhcqnX2tlR0K3CW9yHC8=
X-Gm-Gg: AYBFou1TSiQiV/wX4IulWsu/y0v36I78jQvm61+zZ46it8awuN1mnJ+kK/vEcE7PJIt
	UoyM+K3p+LujXOaJht0nvvURgu76+yjZFNZu+k46tWsi1zQOZj7LLOE0i3Y2rA36EZ8nb7kvLCk
	sYcpBeOHi5Kz0LxD7YaqjTvNGjezv/RztbwK0R37hJwrZhbOHZHy/5in3Nm678gdIXt6sEwHtZn
	chpDWHXwFktq/ASbyQrCZxBYZ5nEXDTTk85p1Bp/MV1ucqVip6CkeTDbactWlnedTquCtubRD3J
	iiXTMx/fQ/hO6mqBasNjZUkCqHyuiPbeq4p2kbXOZ3w4GUB1vLHKR++UNW0uMlp+SJozMu3d48L
	ucICFel0L5QqRuXCkJ4zOr0Az6dkTWrZ01z3oqRPMYkjxt94mR2xtTpj1MsqqrxOFVBw=
X-Received: by 2002:a05:6000:1841:b0:488:885c:3426 with SMTP id
 ffacd0b85a97d-48af1a883cemr6068704f8f.1.1790689077524; Tue, 29 Sep 2026
 06:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me> <eafbba40-a10f-6a7f-54e6-b14d59ad1525@ik.me>
 <99dcb462-5045-4fa7-9f6b-ee0f13ff96ab@amd.com> <4a161dd5-4dfe-81f4-e4d8-ba9d3280c25a@ik.me>
 <6d7773c8-0dc5-4e11-8bbb-088289dd508b@amd.com> <a5611ca8-b28d-4102-0caa-542fc162758a@ik.me>
 <60a5c26c-8fe2-477f-b576-2a18d8b6394d@amd.com> <fc70f3b0-6ac5-7ac9-dca8-595b65785718@ik.me>
 <b29e9341-70cb-4201-99fc-ef307dd10fa5@amd.com> <aab50dd0-5141-bded-0b58-0f01ae9621d5@ik.me>
 <c42ab776-6fa9-4e8e-acae-fa921a5ac108@amd.com> <0d1686e8-a50e-6f3b-2923-a0eca6ab4271@ik.me>
 <b6015026-fe8c-4823-ad39-c630350c0cc1@amd.com> <c58f84c7-bfe6-58db-cad5-6859e96a7daf@ik.me>
 <afb1949a-8465-cfc8-bddb-bc27783af223@ik.me> <8f06af84-c0fb-4d24-8868-bf16a1678b4a@amd.com>
 <3a080b50-6396-bf8f-2e70-011b85c15fe2@ik.me> <b2e13400-d1b7-4a9f-b7bc-a2d1dc7a4912@amd.com>
 <66bbe070-36d9-d854-f0ba-a350634713db@ik.me> <049f2564-3ef2-433e-9206-be44b7885d7b@gmail.com>
 <cbcb15b6-b576-a6be-f190-9014ec02a805@ik.me> <edd73c8b-904e-077a-6e77-0348f4ca5aa7@ik.me>
In-Reply-To: <edd73c8b-904e-077a-6e77-0348f4ca5aa7@ik.me>
From: Mario Limonciello <superm1@gmail.com>
Date: Tue, 29 Sep 2026 08:37:44 -0500
X-Gm-Features: AclHuK-e1rLFCiRxsdO_G9jEMsK0s_T6KdxDS1tpOWY4u99SMqrVrnK8w_aUvjg
Message-ID: <CA+EcB1OuUgGzRQ-cz76B=MJgFsE3kOm+4UbrSGgWHG7Sq6RD-Q@mail.gmail.com>
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
To: Fourhundred Thecat <400thecat@ik.me>
Cc: Mario Limonciello <mario.limonciello@amd.com>, platform-driver-x86@vger.kernel.org, 
	linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > I am not able to test anything anymore. I have erased the debugging
> > setup that I had on my laptop, and reinstalled it clean. I no longer
> > have the claude history and the debugging tools. And I cannot do it
> > without claude (nothing we did made any sense to me)
> >
> >> https://github.com/superm1/amd-debug-tools/pull/58
> >>
> >> If it doesn't work, can you please send me the acpidumps and I'll adjust.
> >
> > but hopefully you can make sense of the attached  acpidumps
> >
> > thank you,
>
> looks like my previous email bounced because .tar.xz attachment
> so I have uploaded the file here:
>
> https://www.swisstransfer.com/dl/01a0ebbb-a094-725c-b9f1-8a8ba0d1da11

OK.  Those seem to parse as I would expect.
