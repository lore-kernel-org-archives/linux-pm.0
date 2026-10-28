Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793154219;
	b=j8Q6gZKqryEsybqd/shULOIK928eZVec0HtiEvPuhYby7Wv3qzMEfZWhqjEUWW7gLEhS
	 bPGZa1q35OKB0tdPFhtdCUFKUZ9ksPqdu7Isa90bUTKyJcxbZl+Tfgt7hbNxvwQ9tHMAY
	 6OXYIxr7rbyeTe13t8YE8SKR9bQ3jPTwQopjR2+MlSgbb0qAx4JwmLBDgFEi/OWp5bg/P
	 NhnZZ1pYenwq2KXInKbzMfM9NYcW2RHbneyAzRPF17CMdm0x/ywTYGsOVaxG4Kl6EVeCT
	 p6BCJ5mPWbdCQXM8gBxyV12YaEcVJdMcsJMgyKA6eEgizHHeoJf6bdLjkIKpcMRRSdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=NMQnf8rSmJb2IgSBV0OamLewABgq3/6kweCgJqa8h18=;
	b=LEqlS+DnkGTn6y1EIHqX1I6cfT53yxNIn5aNGs07xndt4rqyjP5n8QdhQUlVhYXszS51
	 gHTWkY2ocqp+wsCki8wtLn8ztuSoE7aJn8VLggy4+YnDvh8rnb9fE728aaE4b8pH/DxyT
	 J6nWivZh9tBZXRNIxpqLUjLcSMiaBhO2aRpbZmuuHrDqu2yQ/xhna8Z4KomRmj6NqgojJ
	 6H0ZIvLBFlp+jNDr0EZ7ZwPusGEC0Wah1300+9f9vJwc5QBDhRTtttRqkmYH8EHCQvhhO
	 vnAx7usfS7EWDjHmTpake3LeDG/XL1U/mGrflXmn1wki19Ms/dgn6x+0uLcStUZ5izw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vl1YUOqH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA09606A31E
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 02:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCA09606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vl1YUOqH
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5ba328513b9so539296e87.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 19:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793154217; cv=none;
        d=google.com; s=arc-20260327;
        b=MS8OkSaP8709pkEzcpyRKMnsjC04UOKZp9mdFXcK0DWsLalppFWRkfh3Oo5+fpQMcF
         ppyA3lWDDqQ8hYT1noSCHe1KnO+ko9XcKjeL44e+uuNWrHg9ToixTl2tO2bFToFXLqiw
         mOa9ZLJLCf1Pek+gGfpGHTwFK8EO/yQ44BlDXnLJwrvGMDeWHoEdDtAoS4jqpPSN+3Z2
         p33qP9gxCcIxpdBXSjMowLEXuqC7MEUJNf4QjSj+NOvaF/fptQqPzO0Hdh35g7TJ65kT
         gHXCK5Rs+JyPunA+V9uyVwB5aPeWZAz0fhGb2jQ9Dt85RrCjiXNXCdCD5bZMKeSeujxX
         rtHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NMQnf8rSmJb2IgSBV0OamLewABgq3/6kweCgJqa8h18=;
        fh=eHYQjX1gcBPWrlLumt4U10+JWmdnxh3tFEy3raM7m4A=;
        b=atICQat7SvX8rYFbLeVC+91/NjKSWNOJd4Ov+BenvGRaysgZ/WX8M0FMd5MiJm18de
         GzYLv6qIePuqzocjtPcyTCf9PN5kH/pwJGSdnum/XgOvkOCzTWwP0MM7vXEju8cyGuP6
         QqKYNiOORiF2dcP8zwqVMGWqdL7rlksYzHPqAr9wJNv4tvBjmlHPFY6EBO2RAaLrHg5s
         jB3WxGJswqPi220t9XFNR3ezNn5p+gNzooP1zOexLqa8a3y0OxllDH8Evegbso1H1Gms
         Tq8zrH3IlD3ypTPCjLXxQqTtYT7xlnvlksP4me+1BR45cZWbyrKNddcYSkaZ7JIDHdLW
         Oh0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793154217; x=1793759017; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NMQnf8rSmJb2IgSBV0OamLewABgq3/6kweCgJqa8h18=;
        b=vl1YUOqHGv4FSVuU+MpRsZ1orgmp7endVR8qRCJ+V1E1NYC+NqRn6KfHuCt5eg6qoe
         P/TLE3L5J2O1uCCame9lT4xTLMAK4LdHNenMrWcBRgHt2RUz4o4FTwwSGqdCtM3gLjy0
         HG3OmmGLMmG1H8BOWggBr+B5kgsnVZ31d0DfGU+yRWEuzKmGE6c9NutPsTR+Sf3l9M0I
         IBZdm0H3pLUMVHzvBZHtr1PwZ4Rq/EHJWkJqN1DToLKC+hH4EpTki66IDU8vO8HEDOHd
         HsJf1eZAC1QA7BgzfHBI9fe44P2Tvk/EVq75qC1g6bS27DphCSZvtihewxjqyiTmLN13
         3Znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793154217; x=1793759017;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NMQnf8rSmJb2IgSBV0OamLewABgq3/6kweCgJqa8h18=;
        b=Zx7ZoawG2GghDy6IjkIg9kbizSxmdpysVR67n6e9Tusrc3R4nUDnruYD1OCi4OcTwy
         853jaWy9IX68Iqf+pMz1ge3OG8ZMY5qaL2Sohj3nrUupNECKnLYekKuZFth6im1piZ0Q
         imCwelmhTKEssIeCz/dcj7K/R25Xp+hBUQa92P0KWnIQAAZJx9JCuJGj82/H+ySGsk3j
         u6lLXUJ3ZIzLIfWkBe2xRk9uUSE49LkMc7GiqsnUEdzgS3zj9kXZs5t8IHsNoLJrD7PE
         UJOHRShqZcDVmBh+lVo+NRHSaih7prkZo9vDzMjEs56c0pAEp0cptszX9vbUsmvGjauP
         sXtQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxx98ndQm/8uwNBKZz8A+7no+XTdPwfFRqFYi28ogKfHWRuVeZektQVsIBY1HdBb2QWnjSKdJHLw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIAHDDSYNLceqLVDQcBuucmFQ44JvbCOe9+YRFU6pyFUy3sNZQU
	zZu/X0kBQRgMa+DY0ID9XCc8jkD1YL+uT9xyooHoD9skM+DTb5FSIt3ijyolItsnQ29MZubO2K/
	hDoeG4suVVq6blfg6vcw8yD1VCjx1+O8=
X-Gm-Gg: AYBFou0tB1DYJb+6R2/ABPTh2kRGksIPrAjIZO69euwYPJ3Cbxs3y3T2oaMt9z58pnz
	78g9zep0UG3aZ3G8gKI11Zjr97PkNHFZxe2zr7L0biYuX3OpfCMKBIAH5Y7hDDie9z/xpBxh0hp
	yTCMThMeyLfLk6lylujFaiU1tN3Mqhue83yjCcv92RC4LSLQqiIkk7jHTPkB62Q8S4jkgdG/uBk
	5+xBX1bPFX0KtON8DNvtcD3s4spV76jRDm0o6e30Hu96Z4vkg5F0g5Va11bs9iG/awLWUsQ6Tw6
	SbCmjq16oXKPSx4DzaTTP//qCJ27NyBRU/XlUYznd2E/O5pI2xcijQMff2AA247lIbs1oor4QTi
	WlvducD5PGDmo1yqQ9ifsE9YJf1w0DrnjvXnVJSTyO76jmBiRcFuPNg==
X-Received: by 2002:a05:6512:1393:b0:5bf:b144:fcbd with SMTP id
 2adb3069b0e04-5bfcad56697mr450920e87.42.1793154216891; Tue, 27 Oct 2026
 19:23:36 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Sergei <fistboom@gmail.com>
Date: Wed, 28 Oct 2026 05:23:25 +0300
X-Gm-Features: AclHuK9TQ3jlszcX3q-6jan3r7y0WdMtqLdNNTXDdvzhKovX-HpF7W_fh9oyHSI
Message-ID: <CAD6ZPytCGim57_DthuUhM2cnqG9iCJw+yP=5v5btQ4cE7JBteA@mail.gmail.com>
Subject: Unknown NMI after resume from hibernation: restore kernel leaves the
 NMI watchdog counter running on CPU 0
To: rafael@kernel.org, akpm@linux-foundation.org
Cc: pavel@kernel.org, TonyWWang-oc@zhaoxin.com, peterz@infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm hitting the problem Tony reported in July 2024 [1] on an AMD laptop,
and as far as I can tell it's still there in current mainline, so here's
another data point.

After almost every resume from hibernation I get exactly one

  Uhhuh. NMI received for unknown reason 2c on CPU 0.
  Dazed and confused, but trying to continue

somewhere between 1 and ~130 seconds after "hibernation exit". It shows
up after 25 of the last 28 hibernation cycles, always on CPU 0, and never
after suspend-to-RAM.

Machine: Huawei NBLL-WXX9, AMD Ryzen 5 4500U (Renoir, family 0x17),
BIOS 1.07. Seen on 7.2.3 and reproduced on 7.3-rc1 (both Manjaro builds;
the only taint is U, from ryzenadj writing to PCI config space). TLP is
installed and sets kernel.nmi_watchdog=0 at runtime (that's its default);
the kernel command line doesn't touch the watchdog, so it is on at boot.

It's the same sequence as in [1]: the restore kernel boots with the NMI
watchdog enabled, programs the perf counter on every CPU, takes the APs
down and jumps into the image. The image kernel has the watchdog off, so
nothing owns the counter that is still running on CPU 0. When it
overflows, perf_event_nmi_handler() finds no active events and the NMI
ends up as unknown. After the wrap the counter just keeps counting from
zero, which is why there is only one NMI per resume.

Reading the PMU MSRs right after a resume on 7.3-rc1 shows it directly:

  CPU0:    PERF_CTL0 = 0x530076  PERF_CTR0 = 0xfffe53fa3a48  (EN, INT)
  CPU1..5: PERF_CTL0 = 0x130076  PERF_CTR0 = 0xfffa...-0xfffe...  (INT only)

Event 0x76 with the counters sitting at about -(watchdog_thresh * cpu_khz)
(23.7e9 here) is the watchdog's setup. CPU0 had about 7.2e9 cycles left,
and the unknown NMI came 69 seconds after "hibernation exit".

Booting with nmi_watchdog=0, so the restore kernel doesn't arm it either,
makes it go away: after a hibernation cycle every PERF_CTLn is 0 on all
CPUs and no NMI shows up.

I don't see anything in the resume path that stops the hardlockup
detector before swsusp_arch_resume() (resume_target_kernel() only touches
the softlockup watchdog), and the two patches from [1] never got a reply.
Laptops running TLP probably all see this, since turning the NMI watchdog
off is TLP's default.

Is the direction Pavel suggested back then (suspend/resume hooks in the
watchdog code) still the preferred one, or should the restore kernel just
stop the hardlockup detector before jumping into the image? I'm happy to
test patches.

[1] https://lkml.iu.edu/hypermail/linux/kernel/2407.3/01199.html

Thanks,
Sergei Gorbunov
