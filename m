Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B83D1AAC
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693767; cv=pass; b=dhnBXTRlzBhpYXgmGR958ni+IDg2GgvRr33TxOeK/PyAhMEbxzlDb3FeXnlj9L/b9MJn/uUbmbAdD33AMF7Tl2mdVzrDxk1j8abGFKwbez9bv54m9WLamvUNzSE+0vkBFqNiB/06MGHr/LwLwngLtlSd8KSkNZctuOXJ4Jw+Fx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693767; c=relaxed/simple;
	bh=hsfY4M3FCyUSSdG4eY3UuT9iyiNLpq4MvxQmfl3Kt9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRh+3Ec5gvJMDjcL4mARXyijFF15Sqdcpbx7Xgi6XpA2KaVKNNE4pGl2vcgAMvDOM8ns6ahddQthW4I+D+LbR2HmB6tsdB1088M2PAjxApK1Xfta6uWFavpPITaGObUpuIGa+xd2FwXQjHxdtSUZVPaAb9kXIzB8j1HHbqGHP8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JX6NSLpa; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JX6NSLpa"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa2d5a1d51so2862719e87.3
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 00:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779693763; cv=none;
        d=google.com; s=arc-20240605;
        b=eAMj+6T670lE1swSSU1Kg19vIZAp6QLdEqMCq521NWBitaUXadNs8Ld/WW4mNNN5+Z
         W88g19PsouFXYz/6gWq/s1zaaUl73Jst7RIkldn8tmNk0yTtj/B8jN0mW6oTTPwzcQX/
         QgEd1I1oO/aDFby2R9wdu51Jma9YbwiK0d2HU0iMs0XCEflWyuF3/hFlBMVTgyRBFdHq
         QuE2IhDkFbvJBYDqCsHxFJJeJK4LpagU3YMD8vYs/sXz/ksSgahmdWPw6xIfDkgLLWQ7
         YwqWBAqMwT7NcIseEEqY/uacQni1CVVLG38d8QnKM50daNFFBpQTCO/6hJELfj7U8isX
         JZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=etVNODqyZnFaIN8OnoPEXmE0+THG5cU8QdS0ReSCQPM=;
        fh=OHSz2RW83zb96/VfNHbt1IqikPOJumTVy0vebUyRESE=;
        b=RlZrBKh9/Lxy1XLSiuSqwUWDPPOss7KEeRlXsEc/qAI6zKkOU3DhTMbOODSpA11c8F
         LkzMqLa56C5KoI2mGquZCbobk3Ule1dny2Og91XZVYAIocPnLqc1EqqmFLe8d82CO1Z2
         nUygSQ77PIPhF9ZVCxhlRqxBcgj90XxNjE5kgP/4SJHpBNz4DnA4Yv24dnaV5BoOp9S2
         FobfwObAB/tUKDM3ouSj8FmUpyuT6j/WS+kjEJCP6gZ3HnHzHNoqijJzngdaUYfNnGWh
         cA/fmUDQtly3w9LAtI3NpiK41attm3tjxNC/dPDp822DukUFgucDPen3L1F3YFVcV2Ld
         /+9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779693763; x=1780298563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etVNODqyZnFaIN8OnoPEXmE0+THG5cU8QdS0ReSCQPM=;
        b=JX6NSLpa/0B+95LqPWAPxKG0paegNMuxRSwFkxRahrWbdP7KhNrF+v6nXHnfFVFmB3
         nPiRMGP+aOCKMQ30ZzwfgGPltR1YB680kZfkENaYpU4cE28dOQbX8uQNg4bEWVn8NXfl
         ON1FzFo1peCdXIq8z6tSFWvDcEgcPEWOWtpe728XNc2ZS8EBXQf5025Y/e/EdXUvsOJn
         o0Y6aHqLQDQ8otOXjqSAYdbDxDR56J7HwPQsPqViLPuNNXo/kIbffBfet4xIsfglVWL9
         U2fSO4DlB59JZACUl5jskgtIqIpfqMp2e3ZMskR9f60ow9q6Vs3fL/NnQw9zXIoEo4q6
         XdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693763; x=1780298563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etVNODqyZnFaIN8OnoPEXmE0+THG5cU8QdS0ReSCQPM=;
        b=QVyGiYserwGAD3wn0rz/XVXxzhikMJ3UAE7OvsmhM8MFfukAQt0JwJxWTe2TrSXh9p
         2kBK4JrixkewBRAxLwI3dneFe4IlR/fusWIo80KhP/dXPnzBfyqtMZN/QojgjAiQJ5Xs
         JZEipP4e2e3B8sc7RUj51ABzg53lYOMZYx9HDqsyCV+1fmsik9qKEtPHCe/kNbXufsa9
         J5yPMYA3AYITVASuZjN7+96ytFqbRsIX9gV1kTytPzxUAVWo5WYPagt3db06adbBEGa7
         xMmu1G2txjOtFhZzlzoU4DhHTKGcBX47826jWQ7jPazWzlRj50pjguWRaoD6x78dyNnf
         0rvA==
X-Forwarded-Encrypted: i=1; AFNElJ/VPAHNDRp+0X23QAjf3r+lZEAoONpRubUPZaqcCw0DBoAynY/KURr01N9EhhaUvM8Pmm5wNrG7TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyC84KzFGgIPSSAd4nVpgAQKqmI7ygvfHPx9w8lIpeCDYOydHe
	2CKcqvjNFT8kLXdblcasUnEpTxPpoDLFiUulPbCof0JbWjUJbGAlmF4cf2KyjD+SyXJZxJ0V+V/
	zjIBfDUjiplyMYj+/AQLfKyYrgWDSGX6Z/kS534g4VA==
X-Gm-Gg: Acq92OEpjAh1gCGJSAbBExRMhIzUMDmMHVuIvAq7kusBk6xVW/E2FqZZAK842lm0t4h
	famoO9WFMFkGCUMgCxXnswUmFK3OYNy8xF4sNPJt2uBHYDfbQffXxmSpbfH422jm+1zduu4Lp5N
	U8+/nmOEd9j66yNVUDKmH47Ys1IY9Cwv2opI/SKkoxftaTAjdMqQ32HOL2fxDi0hwlczu45LZC7
	EEtxbrVpqVPMqzVBvVLugurq5gCWIebxhYkOMcpyWIWMSgJLu2v0wTYOp+3Vcwj3p42o5+3QiSI
	UBcP/MGcLZ/aalkNm4wtGr1vIgPNXEnEcnKcavfM
X-Received: by 2002:a05:6512:38c5:b0:5a8:fb56:e322 with SMTP id
 2adb3069b0e04-5aa323cd973mr2704134e87.36.1779693763385; Mon, 25 May 2026
 00:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515084920.70544-1-marco.crivellari@suse.com> <CAJZ5v0gLuMZ7b4fzc=f5Thk+s0bMjtaFS6HDqu9E8MfJa=jApg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gLuMZ7b4fzc=f5Thk+s0bMjtaFS6HDqu9E8MfJa=jApg@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 25 May 2026 09:22:31 +0200
X-Gm-Features: AVHnY4IBwuSjJEqbEUb9UxoV6Lkrdn0cxYKkYnLVBjw9lrzG7ovjS-Ze7oPQyRw
Message-ID: <CAAofZF7BHU4TddPB2YEQOHNzhU8oKJgV7_2cE3=BrS1BJpSZ-w@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: core: Add WQ_UNBOUND to alloc_workqueue users
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 6:49=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, May 15, 2026 at 10:49=E2=80=AFAM Marco Crivellari
> <marco.crivellari@suse.com> wrote:
> >
> > This continues the effort to refactor workqueue APIs, which began with
> > the introduction of new workqueues and a new alloc_workqueue flag in:
> >
> >    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl=
_wq")
> >    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> >
> > The refactoring is going to alter the default behavior of
> > alloc_workqueue() to be unbound by default.
> >
> > With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND)=
,
> > any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ=
_UNBOUND
> > must now use WQ_PERCPU. For more details see the Link tag below.
> >
> > This workqueue has no benefits being per-CPU, so make it unbound adding
> > WQ_UNBOUND, removing also the WQ_POWER_EFFICIENT flag.
> >
> > Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de=
/
> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> > ---
> > Changes in v3:
> > - remove WQ_POWER_EFFICIENT: the workqueue has more benetifs being unbo=
und,
> >   so just drop this flag and keep only WQ_UNBOUND.
> >
> > Link to v2: https://lore.kernel.org/all/20260514142511.325446-1-marco.c=
rivellari@suse.com/
> >
> > Changes in v2:
> > - "thermal_events" workqueue has more benefits being unbound, so instea=
d
> >   of WQ_PERCPU, use WQ_UNBOUND.
> >
> > Link to v1: https://lore.kernel.org/all/20260514132901.275477-1-marco.c=
rivellari@suse.com/
> >
> >  drivers/thermal/thermal_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index 2f4e2dc46b8f..0b322473deac 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1889,7 +1889,7 @@ static int __init thermal_init(void)
> >         if (result)
> >                 goto error;
> >
> > -       thermal_wq =3D alloc_workqueue("thermal_events", WQ_POWER_EFFIC=
IENT, 0);
> > +       thermal_wq =3D alloc_workqueue("thermal_events", WQ_UNBOUND, 0)=
;
> >         if (!thermal_wq) {
> >                 result =3D -ENOMEM;
> >                 goto unregister_netlink;
> > --
>
> Applied as 7.2 material, thanks!

Many thanks!

--=20

Marco Crivellari

SUSE Labs
