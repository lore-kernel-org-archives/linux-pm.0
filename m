Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793309009;
	b=GD7RbUQOVw/O4Vu0G8Takb78itnJxUre+OzDCTZ+r4vNCBNxyYIrzM4QnpgdMRe3M8Im
	 QcfFDnRYGUiRf9EEWyj/4epQ7a9dR6f4Naj/IqD9MEHsbuCg9NiD57Ylzqj1PlyqBj5Si
	 3WoaYE2IiRiBs/+sHSiVG5EySJLKNspbWH6hRfjh1KPpTJEMkQbnUH7e+NMuG0il2nd8x
	 k88+iOc9XGvh2y9qIhCbBXo+fCBEDytAmTNpS9Ig3EBpzzbUQoX2vw0NycoaXOwgmvWf+
	 cK0Me/64LNct0aCV3EE9oOl6uoLIc2bs4mdTNdFDAXHMh+G/giHgID7xVIGUAnEVnJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vZ6sfD1Cq4yn5SkeI0KItQ3A6Fhy07jsp0RUWk2vsno=;
	b=ViknSFYhpkruDwin39R903Xvse53cap40dE9FtfDENDu6SPL24y9gfBMt+wqaVRYEd8Z
	 RJhaVY7OsPalx2BFgDW40DYajySD5D35z5ZDF7ImVGshYB8C6qERVuR/Lf9DvzYXCBDdV
	 Nnybg41o1aTVh5Wy043zk7TdDpvCbi7IuTJ5/mOV+A6hSNs6e7niOMQh9jBg8cW/mn2B5
	 KEvPTKScKK4RE4gsdRJqayYHGvJbG15NhThrIKDB4diDKEb+4Qg9nuA5J/iQltD2wbDUR
	 F5qC/JsctaNT95X1cqF0kCt0alvnPg8MHR+cmU4J48fuoi1VmHkrKGkWkmBCu1wSKaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUpItgfd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2941D606A31A
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 21:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2941D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gUpItgfd
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6dd7070699eso9437eaf.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 14:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793309008; cv=none;
        d=google.com; s=arc-20260327;
        b=B9P6NsskC+eeoY+FYGlKAKImR7Fy9VZlCfuAJDCQs7ZGAv3sUrYcpuvi617D1QjaUS
         /HMomDocrHtQ8EfFstHqwE9pFx+KXxkpHJ/FFbpYdweWb5zL6EZigEypsb6Ztqr1dZYP
         958WSfs7b+SPeNmkJ/pf1IE/NO4Ef5LjzN+TYdXfhnyW0wYctJLzhgcMUu1qTOvpPYU+
         2m+vxhEsrMw3v/dwiHt3SpCULRPcNHqj/moBJblt9s62Rfc1dAWLjg72ZOtNSM/wh3wT
         RHsxuyzjloIlhiHQ1za4jAbJCQrYmxnXA5be9W2BC+VJHCYF9JojAHpST/joUqXbHppz
         gwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vZ6sfD1Cq4yn5SkeI0KItQ3A6Fhy07jsp0RUWk2vsno=;
        fh=aTPq8md7xPwAk2FRlLQVwX+vwZYsFfTTBpIv1sdjvPU=;
        b=n8wVcefsuDSnu06fKHUXNkSskYOH0OUZXZtc4lZQMpN708RBZiIZb+ka2hxfTylzY0
         G7Q0td7iDlx9VkomC7Ax7taSH8pvXReA5of9PYZPJMgAr+6Pw0TN0AlwVaUFXYzq1ohC
         Ygo2FCd8DFZr8TjX7ZD3Oxw7F0qrlPkZhj6BpFaRdmzAu9ZQz/e3NtN6hcEQFi0acwXN
         8VHsLznjwP9hraEC0WqPAf/Yh7eM/9aPyAlAuQ4EJr400X/SE2AXF48cAlLkfFFSq/pc
         SEeCpe9/sLQ2RGFh+M6gLD8+W6PEcJr9NAlyqpk1bDatGM7aHDMBI9sJqEWfgoQqDvuJ
         tUMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793309008; x=1793913808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vZ6sfD1Cq4yn5SkeI0KItQ3A6Fhy07jsp0RUWk2vsno=;
        b=gUpItgfdkLL5cunEs15SdHYlNF/SX0yUwlUrFqZRBN0nclSxu2fka2abPtUQVuWgA2
         Rs+mD5bNbUfLGzlaJ3UfN3P6rLMbUh8+99f9KqEpw7VbOW/yqI1+dmtjV3vq1aaN67Cw
         eYCzA00VecWb9QXkKh7M7z1C6+9zLH51gFq1vr3P+zYeUH+6COYyG5YXZF1CVDzJ5Z51
         q+1QR9z51TSo/VNvja3Ljw28NF92svvRnuMniBTyAo49WkOD57KifaWXA9sbKUVccKp7
         gHPY2mtasiymhm1vQ46nbhGoq6uDctMGaOpZMAUX7TFKJzuM+H/9flwEylFBAYffGLNg
         JmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309008; x=1793913808;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vZ6sfD1Cq4yn5SkeI0KItQ3A6Fhy07jsp0RUWk2vsno=;
        b=NuolmSRZfW5FcfIhNaiecdmhi97takvbfPugGc38rbiFcBzquU4D1RPrl9XKtOsA4h
         hCx9xl83rabHGF6i304Gn9hCXeYogi2tOpURd+L3N6DAZ+x5ELcqclkvyO2+kMJMfxOE
         1XMpVugpG+LMI5gmmuwXhG9vgnZxCqas9PmghZD8In5AfKEDDA5HSpj16qV1kw9yrnrN
         aN7er6gvix9fBZNrqRrdWPeZAC7pbfZU+Ok1JO8V4cS0VoUseNraFd/EuI+l7B+6/Ml7
         voHytmwXvPZosMq/T4Yz6//b/Ofp5IY+ocF4wDQQJMg3B+sCphkwDQ9ybxIC3cq/PjgW
         yqow==
X-Forwarded-Encrypted: i=1; AKwUvBxBfy4lI1Gj2AlYBrqR328dRkALzcdgzuroCtcfLe220f2VWY0kYzk3j2VMplZBkh0p+NB5VBHRSg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK9oBCfSYScw9pNIYcAVd+NQeP5AsIJ6YoXg4blWe7azAY0xLRu
	mz89p1N0CGlNEv1xbNPaHyBB15soXNowABvAYcd3b1JFy+GoNk6ZXIiD2hUXVLP1tk7hDmktoxD
	AbGMGN0nB5d2SbgzvznqvPDDi7qWutt0=
X-Gm-Gg: AYBFou1VaWuZfCfXuytjkbfzQCdOLarH9YP6HaaG2VGr8fRDeExMffKFN9pQTcY5g/x
	TYsuTdpPslVpfigXYlpf0m1/Dj+LiPs8r8dwqpu3x9cDAEBLYBjokCyaytzRG3a+yHXDtjk8l2g
	tJAe2VCQWdqVuVnS5jEoKJ+m/xU9plDWGk50peIvWX7wtdUd5Ooob8CBjE8fhlzX94UqGSzK7BD
	6O9eGJNvI8mkXRYGIV3aTdV0s6pgZCCqxQN7WlJ1qRHTKzkpWiqT0pnhp/kbG33dRmM149lEju6
	8hn4DAhw/m6ADikTxlFTW6Qo38vFoOiseUgfRmj+0Z8LDNIOE5VUpdRMZ21VFsonOdDvroD5vyk
	ISbevW+8yu5oWIkFnU6BBNLxNeIkWSsTu7zU=
X-Received: by 2002:a05:6820:c2c6:20b0:70d:7738:4089 with SMTP id
 006d021491bc7-714f1fdca82mr350861eaf.12.1793309008049; Thu, 29 Oct 2026
 14:23:28 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027143725.3763827-1-zakbrightonknight@gmail.com>
 <001101dd6631$6167dbd0$24379370$@telus.net> <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com>
 <004401dd665c$97eda060$c7c8e120$@telus.net> <CAJZ5v0gvruWF7VhVuLrn4AgV9_n6Ayektrh+jB=eLY79ufw4UA@mail.gmail.com>
 <006601dd672b$a7d67f90$f7837eb0$@telus.net> <CAJZ5v0jAG7wxxsuynPL3fyo8Kr3sLCC75fpm91JADuDpm10QZA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jAG7wxxsuynPL3fyo8Kr3sLCC75fpm91JADuDpm10QZA@mail.gmail.com>
From: Zak Brighton Knight <zakbrightonknight@gmail.com>
Date: Thu, 29 Oct 2026 21:23:16 +0000
X-Gm-Features: AclHuK9V9JWbjsDCzchj_juYJIkpV7hzVU9wWWFiHxj1haJdv49v8jpThBhi4aE
Message-ID: <CAJsH6h8JOZUCjvNA-SDM0ziG1NoUCwh860k8qjVAs_v60W64Og@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Restore P-state request on resume
 without HWP
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I was about to test the patch when I saw your message. Happy to test
any future patches!

On Thu, 29 Oct 2026 at 20:52, Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Wed, Oct 28, 2026 at 11:28=E2=80=AFPM Doug Smythies <dsmythies@telus.n=
et> wrote:
> >
> > On 2026.10.28 08:54 Rafael wrote:
> > > On Tue, Oct 27, 2026 at 10:46=E2=80=AFPM Doug Smythies <dsmythies@tel=
us.net> wrote:
> > >> On 2026.10.27 Rafael wrote:
> > >>> On Tue, Oct 27, 2026 at 5:36=E2=80=AFPM Doug Smythies <dsmythies@te=
lus.net> wrote:>
> > >>>> On 2026.10.27 07:37 Zak Brighton Knight wrote:
> > >>
> > >> ...
> > >>
> > >>>> I confirm your findings and tested your proposed patch. It all wor=
ked fine.
> > >>>> I had not seen Rafaels's reply about a possible race condition unt=
il now.
> > >>>>
> > >>>> Test computer: i5-10600K, 6 cores, 12 CPUs, HWP disabled.
> > >>>
> > >>> Passive or active mode?
> > >>
> > >> Apologies for the incomplete report.
> > >
> > > No worries.
> > >
> > >> Passive mode has the issue. Active mode was fine without the need fo=
r the patch.
> > >
> > > Thanks for the update.
> > >
> > > Please check the patch I've just posted if poss.
> >
> > Because I had already done so before this email, I tested Zak's V2 patc=
h, and it worked fine.
> >
> > I tested your (Rafael's) patch and it worked fine.
> >
> > Tested-by: Doug Smythies <dsmythies@telus.net>
>
> Thanks!
>
> > I have not reviewed the code and will not have time to for a few days.
>
> That patch had problems found by AI and it cannot be done exactly the
> way I wanted to do it because at least the userspace governor depends
> on preserving policy->cur across suspend-resume.  However, there is a
> way to force driver callback invocation in __cpufreq_driver_targer()
> even if policy->cur is equal to the new target frequency which can be
> done during resume.
>
> I'll split the patch and submit a proper series when the AI is happy with=
 it.
