Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793665535;
	b=uXycVqL4a0ix+RAH7g2v8AhHAxYXvtJV4itdrBfPvRSCrbycAeiaEXbhpdKIvNFiqDm1
	 i82maOREHaS95TIK6XspS0gE02HxwticceyRzDHbt+5cDu5ULLoR1d4b61rhBJ7cuL62W
	 0tWtrbsMNGUvCOvaN6g5zNP714qpv7hMOVVec9u84ZmLLdkAVVCZa5ZBO1h6E31f77kEC
	 yXXbBttt2J12UuuFSuXik3yESXrJrdEaABekBAANHX2y13+mDW/e0zjEg0/0RcgSFoDAa
	 Dkt6N6kRAoQzdDEEhVTN169LMkjo9GNtgT6EqMykuvTTnd9wz3mhfvrwbjm0ofWCGvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=5+VCCiM+D2qWYPG5zUwtRFwnvX7JDWRjCGt0HwL+73c=;
	b=BJmbMGPMz9mNNGb6Sk5AiA2AiTAVLxlF+DHypqxkSVBQHiOv8gSaQUf3SFuBzybCGeBy
	 Hejks/AoQU86PI3HgOeCTDdwNKg5fnNqU2EGq/tDp21Da+wvn4DfjF9TlpTT9UZrYfEz4
	 BmhcCqAIy3/3aBubm/nRo7THtZS0Oy4wAaViB1HndbqGkIW9FPxt27tbVkm/ySbRksuPa
	 99MRfAMG1bCrxI/wRckg3y0NZ71XejKHEX4iFMC3qctAN0hqiLEu2TFYH8HTSWV9iyI38
	 HM+6jZiEP0lyalzKas/OtjMwK0G30my7+zVXyof7lhKC7Hp6wejQV+RY5Yseb0VM7Aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CQxDHnhh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77953606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 00:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77953606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CQxDHnhh
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-7143451981fso2605415eaf.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 16:25:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793665534; cv=none;
        d=google.com; s=arc-20260327;
        b=LKV4P7KT+S0oIwnc05VKdSrLbJyTXW0810cKh+oq0cv8bvNABurBDIaaUd4yl+lGMe
         /FfzoOf6grQrvZlYMGpZCKGdwX6hsC9xukmOpZryGRzFSmDHn7ll1H7ChgGdWrOLwwkh
         TNuWdzD2pb7zm/AlSWlDpX82zTCKmxbykMcAfRRePWb993Bj7GdJJbBliXU7hTxl1ajw
         4NpICAiAcANpRvBM83dMZLsZFS1sO9LYOQrJZOtuQSWCTm/zjBmifmMRJeLpy3CPzlv3
         UlZu6XrGdLFIgAVCdgHnVwIhTNbqQfNW6BdhdlkyR3wNY+pXyFyN3A2bT2MX0FyPkoz3
         CGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5+VCCiM+D2qWYPG5zUwtRFwnvX7JDWRjCGt0HwL+73c=;
        fh=AMDk5MWv7Id71qPUUme4X7eYHY76M4RV2p4QrtQnXyc=;
        b=Vp4pOu4zTdZw6m0rp7FvAS/QX7KMZQEM0uih0sOgXIBM37vFDhF/gT+M68fDSzGe4P
         cMy0SZ191QCcI9JJNtCTu5D+/AMEIrooQ/bY2mDTMVLa7CpV9ICrspo1uRvdnf3O9B1i
         +GOU+cWPDhQoqvNeTurdkGWJ2TPvLrZw9jyXP+N0tZjAyWAl1DtH7mcQk6V2DFgas9/c
         AowBiPl6nUw16B/6D6Zi87zE/Cn202aV0wrzNbbuSMxEdogbqY1MvOfZJ7fnqWxAJSm9
         UZ/DPyjQsC+2CvMqFmSyzA91CVR41qAPyfw1PYtrfQGmsTZL1aObTBldgZi4OVHRhHVe
         t6Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793665534; x=1794270334; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+VCCiM+D2qWYPG5zUwtRFwnvX7JDWRjCGt0HwL+73c=;
        b=CQxDHnhhqSffPR3aIxjd7o9Vao6/8xQZTATB+KrIJd06wLjpZd0wj2hlJC7kUu04UM
         HmpPTQXEf0LodlLVLDgSNnU5TrNbDEUvZ6QM0VLa131GPlzvYWM86WhZyU7++ZvBVjFW
         faPe/9HJjRQfpBxzvkZdaWVWZj62AREwBJJgOIcZwIq4RYwJ5L41c6NZP+6imT7mOS9N
         FBBkV0yk552uoKhusEsleLuKGujPJ9dzhDYO5JfFlLa48BvhdpzflQIIpdPaPwZ6PTBe
         HoOCl41cQE3AWjuxB3Qzvg9rstFTpPotYHCHEmwDyU2esTyEj0ZGHPrTQv3bLv47jj5b
         UJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793665534; x=1794270334;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5+VCCiM+D2qWYPG5zUwtRFwnvX7JDWRjCGt0HwL+73c=;
        b=ET+amE0VeQ6ZoE97hJULM2+jk8U1cv1z25hKPwOzoqOmZJ/xYTij5PrrZSijXEVjVF
         lN8eDL7Dwvmp8XEDGFAEGKkPqutw6+g15wLe9Dj+nO5Pvk1EseY7nagRCpvzwu754JVT
         92A2CDM28tOSUnUE2sLPwonZxI04RMhUoJNsMse7XF6SZGODyFTBeauCLfd9zk64Z+tr
         0tmw1OxARcY0tmvdFhWMcp14j2jq225sEvwbtJVV1ppY1WfkE4oLb/lH37K/NFtYF/FN
         9lhnDGCTabgNWNTYosnkZE+jZh/oHChJN5yzPutb92UpCuDM5YJVEd/0k6aHZ9KbG5CE
         NXXQ==
X-Gm-Message-State: AFq9FYLftNT10/QZwgjyE78nmGGrryE9A52+H3esh5/yP1WBypR7dktz
	1x0Dxik/T6OCFQH8H6u+2KejyadxCFAUcCLaJSlKu+lRR7yTqCSUN1KEGOOzvLhmea0uctyrq28
	o9dIoA522AyS+t31NwYAx1SbTxN7n/QU=
X-Gm-Gg: AYBFou1m458CpfRNI9Sc5tKSTyhUyIzaDakqV6TgE6bx6gxVS7YmZ/xid+QnTiDu8Mf
	c/vx51+CytzMnJ/UESY7J6pYgUAWuxqV0PQCBwRXn1h3bKRyV5otg2pUlgqIpCmQBDZ+CVRsE1k
	Du0WDRZ9l7LDu5Ny7mxcb0ra9WJQ6e3TRh0aJPIKO8rLOmUWfRlWLhNbboWpOV6a3a08UTuuNYn
	gVbcna6KPibPaUFGgzJIUddcuKw57b44oJsD3Dfxr17YsZg/utk2o8m1q2ex9SUATAklg7m3X5E
	nX314Ur68dLAle32Fouq1DJ31S06RbX3yPDx3s3Ivhm2o9xHTMPooBB+GR36UY+IXBc9TpO+pAU
	Tsdl7hQEew2jzo1cVJVHV5jB0oOEPVHD3IUY=
X-Received: by 2002:a05:6808:6718:b0:557:308a:9e9a with SMTP id
 5614622812f47-5640dcfd646mr7838339b6e.21.1793665534370; Mon, 02 Nov 2026
 16:25:34 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <5162355.31r3eYUQgx@rafael.j.wysocki>
In-Reply-To: <5162355.31r3eYUQgx@rafael.j.wysocki>
From: Zak Brighton Knight <zakbrightonknight@gmail.com>
Date: Tue, 3 Nov 2026 00:25:23 +0000
X-Gm-Features: AclHuK-Tz4WuE1jJ3kcspMgxEl_lYHhIlKe-fuOjCB8i52WShhNl685O90vHwlI
Message-ID: <CAJsH6h97tOHOmiG30un8_h6-mFNNxccwsB295z7N892vVrYgbg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] cpufreq: Fix synchronization with system suspend/resume
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, Doug Smythies <dsmythies@telus.net>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"

 Mon, 2 Nov 2026 at 19:52, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> This series fixes issues related to the synchronization between cpufreq
> and the intel_pstate driver with system suspend/resume mentioned here:
>
> https://lore.kernel.org/linux-pm/CAJZ5v0hT6aoX4tuJM+rO_5iequFc_7rEXCoaFnHoJBaH3JP4KA@mail.gmail.com/

Thanks for this. I tested the series on top of 7.4-rc1, with lockdep
enabled, on the ThinkPad T520 where I hit the problem (i7-3840QM, no
HWP, coreboot). One S3 cycle per case, compared with the Fedora 7.2.13
kernel on the same machine. The numbers are the MSR_IA32_PERF_CTL
ratio on all CPUs before suspend -> after resume:

- passive, performance: 38 -> 28 on 7.2.13, now 38 -> 38
- the same with CPU3 offline across suspend: 38 -> 28, now 38 -> 38
- passive, userspace at 2.0 GHz: 20 -> 28 on 7.2.13, now 20 -> 20
- passive, schedutil (also with CPU3 offline): fine on both
- active, performance: 38 -> 38 on both
- active, powersave: fine on both

With cpufreq dynamic debug on, each "cur 3800000 kHz -> target 3800000
kHz" line after "Resuming Governors" is now followed by the two
transition notifications, so the driver gets called for every policy;
on 7.2.13 they were missing. No lockdep reports or warnings over the
8 cycles. I haven't tested HWP or hibernation.

Tested-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
