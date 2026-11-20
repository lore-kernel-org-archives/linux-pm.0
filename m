Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195861;
	b=Ohqgc0PhWPSD/Zut8u+2ZafhCGUa0qgTGNv50bhtnFm/fMXk0c6Csf34Za+cdNTC5iLQ
	 l32p61ARiQ3ByWFWlqY4EtoobFwnYyz8jfVJyYUodfrlUc2Z88Cn3N+H1YAaxz2Un4CHn
	 dS7vc0oq0VI/cYvjA424fKgRLQAfctqE0Vxjcbo1/Xagk4z+QLx+opA+ooFcpacbswmve
	 aaadeXhtJ0C3+4u9AbnMQ+b98dQtCzQWNCJ/OVXRTbrwyEiAwXvizKIUriEo/X1Nuwk+P
	 zrQvqkpf9xsXgA5fsokOylwKflo+ZDnM9cC949I/xQjF6UEwDc+MWw3drGL7Y8VT0tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195861;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ktVUBt0SgA21/go1jQ1Ztwg+0qzh3ORMwImoqmt31D0=;
	b=cPWsc5avrdbw40Dz2egvsxTfAJ/fFSbLZSy0tdTtgwcheTWp2kc0oqAGNlm9jYUzejME
	 iJmOJ+m0NNiJ1s2vqD5xutds/nPK80DrGW3h1ZmbKISJQWhPasHnjrq/U95r7FowBWPvT
	 HupYnJvsORyx9QdRAAH7xZHLv8H79f5vcdjOdsO357ZuRQbGYXd9SDzEn/dCv9VDMoO8R
	 LKAUK2ZHhMDlVB8tbq9M1ojoh4fGFG1lLeXfgQ0tpvvszaJ9wBMShpryxHaNAqejkIBLi
	 //iNTI+rfQEjJTp7qJtLPTCMWLd54qZmSPfHW3bfp2yZm+Oeg9EDSkfD69CQxbje78Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9IU407c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E1C60A2636
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9IU407c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1651F00AE3
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 17:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795195860;
	bh=ktVUBt0SgA21/go1jQ1Ztwg+0qzh3ORMwImoqmt31D0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I9IU407cBOhW9pGnof4ZzFjoqWHpzPMbyDeH3k3NkDQvGqbgwwaaXUwVjsBBy+XUi
	 s6EDB7O6dLABmrJgftkV92ZovP9vtdNbyug1KG/MUL/Sors+4j9oEqYf/9Z300gwj8
	 7smwXRDj3VfrxUzci3M11XQuUGFmDHfI0JT+1uPejapFKK5dMjzex5QyYRf1tPdB4k
	 NeJ1yG/b7G9A1sU8BplWNPLFih4Jsguq9n7ZixwIAH44jQo0d46qp5P/etB1wQDJID
	 95+pKlOyLZVH4RwYTIqL7cIm9gphhYmTsc3kfYR22kTePe0UcA8/LfnLq1U+R+Qmt6
	 PVi7aeqUjTpyg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c1479a959aso877000e87.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:31:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEPhlxCSM/fry9tXEMMtSQUmeD+VORbPkor2F6DckLuTiSZqrkC1x26R3G2ez6RYXk/fXSVvGD/OA==@vger.kernel.org
X-Gm-Message-State: APuU4Z97zWPd7whWHczEK/Kt6CYDdjYmZqjlfoxaXA10TTYs4CnMjVxo
	6aqusQthFKvRXRfvAGYuR+NIH3s5QwnYGJ6djrmkC5U95dfFzl3O9HHbZKH5BJ6McK/IEPqsNSi
	0aetWdaGWqwJqrCvTBE5K8VuGj3NBbL0=
X-Received: by 2002:a05:6512:3d14:b0:5bf:d54c:c189 with SMTP id
 2adb3069b0e04-5c1bc660a0dmr1344617e87.5.1795195858912; Fri, 20 Nov 2026
 09:30:58 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115003113.1852160-2-wusamuel@google.com> <09C404BB-5914-4658-801E-4DADD3411CF2@linux.dev>
In-Reply-To: <09C404BB-5914-4658-801E-4DADD3411CF2@linux.dev>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 18:30:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h-EFQi48VLv4zqgPWR7Gp79WAV4WXrA=vKpnoMQs+AWg@mail.gmail.com>
X-Gm-Features: Aa3M54o1T8MqVs-2VBz8UCNLyu51S6hF_xM7U086eBEKIimWtJ2SwhIJqetgYFM
Message-ID: <CAJZ5v0h-EFQi48VLv4zqgPWR7Gp79WAV4WXrA=vKpnoMQs+AWg@mail.gmail.com>
Subject: Re: [PATCH] freezer: Check frozen() before freezing() in freeze_task()
To: Bradley Morgan <bradley.morgan@linux.dev>, wusamuel@google.com
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, pavel@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 1:50=E2=80=AFAM Bradley Morgan <bradley.morgan@linu=
x.dev> wrote:
>
> On 15 November 2026 00:31:14 GMT, Samuel Wu <wusamuel@google.com> wrote:
> >During the freeze stage of suspend, there are multiple passes over the
> >same list of tasks. Each pass tries to freeze non-frozen tasks, meaning
> >that the number of frozen tasks increase monotonically, and that each
> >subsequent pass will mostly be iterating over frozen tasks. Therefore,
> >it is faster to *first* check that a task is frozen before other checks,
> >especially since the frozen check is computationally trivial.
> >
> >Check frozen(p) before !freezing(p) to short circuit the more expensive
> >freezing_slow_path() calls, while retaining identical return semantics.
> >
> >On a v7.3 Pixel 9 device, this consistently reduces freeze_processes
> >latency by ~10% (~4.5 ms).
>
> 7.3 PIXEL 9??? WHAT HOW? THE BASE ON STOCK IS 6.12!!!! WOW! (Please do fo=
r
> pixel 7, I want flair :c)
>
> >
> >Signed-off-by: Samuel Wu <wusamuel@google.com>
> >---
> > kernel/freezer.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/kernel/freezer.c b/kernel/freezer.c
> >index a76bf957fb32..1adf09321389 100644
> >--- a/kernel/freezer.c
> >+++ b/kernel/freezer.c
> >@@ -166,7 +166,7 @@ bool freeze_task(struct task_struct *p)
> >       unsigned long flags;
> >
> >       spin_lock_irqsave(&freezer_lock, flags);
> >-      if (!freezing(p) || frozen(p) || __freeze_task(p)) {
> >+      if (frozen(p) || !freezing(p) || __freeze_task(p)) {
> >               spin_unlock_irqrestore(&freezer_lock, flags);
> >               return false;
> >       }
>
> Good good.
>
> Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>

Applied as 7.5 material, thanks!
