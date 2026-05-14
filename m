Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C753C4165
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767401; cv=pass; b=tUd3BiXhv9wDwVeUXLOdBI9MvTYaUG3u2nxWS//ySC22SQmXe+1K0SyiYqkyEUSmpw64Gpoqtbno3zLz6HQtg4rAFn+xEHYWMWSuzaDRuv9hmnTJ5HK6oWAIefMu+IAYRoYoBI0q/EVr+0XwHtYB/cyl1NDHGWeYvopmjXf1820=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767401; c=relaxed/simple;
	bh=VwNL5SFQSLsBM6TMMRqQ2lHSx56jQ+n0P1chNoMdV9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdnXpfIoRbfFcnPF74YsRBX1wGOajFQbSZwJjIEmId8eZprvGlpeNbjkcc8sCWTwcAaFadwUtat6T1VAwThnm74NAj20UxTaKDakodApwuxFo+obHI5vMSoetk3VyzyhnzAqm7mPapSD1b0EANlENx7Ov6uMZ6WhQgTCKnRRSpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MMGxd0fT; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MMGxd0fT"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so3308724e87.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 07:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778767397; cv=none;
        d=google.com; s=arc-20240605;
        b=OxZIX+ZgUgf2yNP9FcrPaEnWXryStI3iwYusvnQGQgOgRs2Kxf/A6Pjp+wJICRD0FR
         dxTqIoG+YEznyH7LPykPwwqWU/dUujO+9wwV6h+UUnU3c07eAaE0kF3saaNGw4hmkUmm
         4+OKc3XTkJa5R8FKlaoBnd0FXLll4orF+z4IDTOUW8AcmywpJ+Hx49lnlfE/97Mrfca+
         zfW9QgjjkcPA3mwNC77pkQiReHYoIDOYAef0xbPlo+qSkkqiaMWw58wFEEig5Qs79y/W
         JeJeXTPdAkL08Ik3aiHQf7u8r+VoZQOFc4uaGjxJ1M73lQKOxkxFFjekAdjO7DMc39Am
         jFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7BHEehGGNMhKvwv8Vl/50ol6VOhkpHoqMa4cnhCwak0=;
        fh=rAtpHELHD5FAChiabMzfouBi3lVDsqVApdr7v5NKeqs=;
        b=dcMXgREpL4xvCaNnaxxXN/p/3SnCCRNPPykFTyrmVJvSOLqX2h5xMzLe3HFfbdafZ+
         elBcDJxcyOgNmDBjHZlEcvF7kDndzMFVg52ammh+USe5oaP1cLWfuE77ZN4hFI4Gvg39
         Ydxrc6JRVWPGDEA27h4/Jt7PYhjGPwzERDiVQ5LQM77CuJPBhTDNE4bwal5PTTX9ElC/
         oXmCRFM/iEqDHSGgtZiw6sr3Ojre9+VGisjFTciRrrMn7npbrjxQVmZfrYN6ce9lEKsg
         zqLR+i1IbVpCpJ43PZGoclUPkpEBL675oh/ixjwqA09zAsVQf2mmOtYrPnXQqJ/W15bZ
         EGkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778767397; x=1779372197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BHEehGGNMhKvwv8Vl/50ol6VOhkpHoqMa4cnhCwak0=;
        b=MMGxd0fTu7yW451z7Pi5leF6TT0CAW63xQ6tYaPbXwmzDNY3xGyd9Tq38L1jS3gVop
         d5Y2vsbnqmoiYsc0H8GU46k65ijQQ+I63J1qEbvoHMV1sWaqLYEYNWghzhoFfraV/XpH
         QLPoyg4M6PhDnj6oomuhyw/8wmI3+ZZkCEQYzkjXg4G+iymsJ0eRZG0t15OezHWw+h0o
         lP2fYPWpfrhvxaSgDl8soLfY8gtSvTOBMZOKTr22rdH0QjQ/Gjd3EjjPzXlHu4NcN4m4
         IZzSVSzdjvWiQjrenQpymBN5cfaGLo0uM4Vx15s/V+4MIFxVi00cHLYqrjNTe9qbMBg4
         xWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767397; x=1779372197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7BHEehGGNMhKvwv8Vl/50ol6VOhkpHoqMa4cnhCwak0=;
        b=WwMeseH4E9+f9rz6wi2pMKPjxo+bSOHujRwhr4uZRI4+wfToneAINDw5WOt/vw44JJ
         E5xDocQzR+xCP2ULxfD0uSSk8Aa58TdYALcaqyuxA67fb1/QF2L/KVv5YfYNfJOYWwGV
         eio95fXtsr0eQ5uZibELf6Ua0R+qLpZjb5rCnCucSzuA9S0H29QApfOk5YvKw1EEJNNt
         PNJTjBT1A3NwLqBQEO9S85WfzrBsK4xhcQXQhVEWY7Gqi2MBK8ZiivsE96df3lZnEuyD
         /Aq6RIrr/NSaWR2ZoV2OFYxfCKfDs5Q2F3jvfuHsLnZepXXPYsrfAtt0S6U92Sb/8K7r
         U9KA==
X-Forwarded-Encrypted: i=1; AFNElJ93YXKFpVrq+GwDmnKPT2Yc5q0Z33xZgENXBF7tThTpnL5kKt9qH1PLXDaOPw+Ilxo4UK98q15C2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYetpoJmfN4pTqedQBdenH3RUwZTt6KujluOXKD0eAwHOvzD7
	qguTGULGnb+dOjLA3fg/iQCVODuh7bqErY7nIvlhEwVQuq3sQFI26BOt35g/wpRHSxmweinHD/d
	Pkaa+XO1SVZTsp+h1Xb1yW18NS6Xt+rOCGPJj3J66UA==
X-Gm-Gg: Acq92OGTBrsOBDndTTjTe2QLI+GEjnwivRr9/24fX/o95Wd+ksYLS+j9fuqvhOnQa1C
	tHVnquiYvc4aTuJ+nV1RuPmTfWezDv19F49znzY1NORwbjOWtMcDhc8GFArx9vBnNg8mSDo9XJ+
	ahBopvl4pXglB4u+8StCH28p/kiRRL+su+TCjvPUYYM57wbUulGl/HA7dcSucnVbfi4tZJbvRzq
	3F2ocLNIe6/0wQo3tdsjZua5cLrcRRYy3SeHOng4QXuMCnC7CkWrlA9UAIKqc27vtYW5pVJElNf
	8ZyOCWDxFD4GjPS/+n2c5Lx8RXphw+CFoLOkMC9xerx3p9wSAno=
X-Received: by 2002:a05:6512:65d8:10b0:5a2:b514:4fbb with SMTP id
 2adb3069b0e04-5aa0b70911bmr298964e87.11.1778767396849; Thu, 14 May 2026
 07:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514132901.275477-1-marco.crivellari@suse.com> <CAJZ5v0gGyceLJfNtiS+Asi2BRVP8SPjJDxKJrDK+gi9Bov3P5w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gGyceLJfNtiS+Asi2BRVP8SPjJDxKJrDK+gi9Bov3P5w@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 14 May 2026 16:03:05 +0200
X-Gm-Features: AVHnY4JkXLuQqeHOSX3inBst1UT9J22SexAPFRLlIBpTzCB2yfZrPJYR3TXEosg
Message-ID: <CAAofZF4UMwpFz8-CqvPJzGEze40x+r_uXx9vTLqQGc3396EgiQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Add WQ_PERCPU to alloc_workqueue users
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 3:53=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> [...]
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index 2f4e2dc46b8f..691c5e749c3e 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1889,7 +1889,8 @@ static int __init thermal_init(void)
> >         if (result)
> >                 goto error;
> >
> > -       thermal_wq =3D alloc_workqueue("thermal_events", WQ_POWER_EFFIC=
IENT, 0);
> > +       thermal_wq =3D alloc_workqueue("thermal_events",
> > +                                    WQ_POWER_EFFICIENT | WQ_PERCPU, 0)=
;
>
> No, we actually don't want that here.  See
>
> 26fd03effa94 thermal: core: Adjust thermal_wq allocation flags
>
> >         if (!thermal_wq) {
> >                 result =3D -ENOMEM;
> >                 goto unregister_netlink;
> > --

Thanks for sharing the commit, I didn't see it.
Quoting from the commit log:

> The thermal workqueue doesn't need to be freezable or per-CPU
> [...]

Currently, alloc_workqueue() without WQ_PERCPU is already per-cpu,
so drop this flag it doesn't make the workqueue unbound.

If you want it unbound WQ_UNBOUND must be used.
If it's okay with you, I will send the v2 with WQ_UNBOUND.

Thanks!

--=20

Marco Crivellari

SUSE Labs
