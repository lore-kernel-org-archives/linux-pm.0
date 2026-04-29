Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E303A7828
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450077; cv=pass; b=N5/gmhRCkuSELKYdRzQexjuLhVY91c7SfKPkqrquqM0b7N5AEfGHuc1nYow8h0FVmvOfgh9ZK7XnsOCMSQYSCu3/Lul2Hwq7e3Tnr2r7TDSvcSsQz0ZjcI0e90No2Yk+INuv31S2aPOV6W1exj5jsmCB56Omu2wDdzD7oThgKVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450077; c=relaxed/simple;
	bh=jVRamOO/72w3UmYxi61IAg0s6iEnA3gdt3beTXXuUB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXTgiE9ZAI+Fz12dXbH2HgjIOeLPVMMUnQPybI0+GSXznAs5FliRYPzk8hdt0+W/GqIg7scnrQd+/WyjMajB5MlXNM25ERg2hDb3izuqCIEdCPwIH83c4nhZRTfx0OLNW5SIKLOEIMah1wpp2yxw9IWsRRGaouvj3cCUUk8iWNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7EpGDNf; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7EpGDNf"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d87c138e1so122681631cf.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 01:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777450075; cv=none;
        d=google.com; s=arc-20240605;
        b=lWhG+BYEqy7j/yJX31GtzbbInQ8bFaUFg/ZcwSLQ1pkTWh5eAog1P9HPmElQ8A2skd
         kJL1twPje5oV7iBFfjVspVfWT1U4INrDY5sv1hSuchXmaa7kR6d0LAE+Fqcz/mAbqWwh
         TTdYASkIy9Pp87ffKqRv9QW2vgs+nSijEKQ9pzbvistVXKzbDVNJ2EXIvtONwJvALgfo
         dMaWgCey5/BKnjD/4DB7oJjC2RrMZ3/7YTnDPHtSlhn7HrwePPzRrTx4eHfQTnNZNVzk
         ftiSWaCr+gwu6OcfymWJJxh3tUEympF2RF4ZV3OJXx3ntW0pJ4S7hoefBAtXGWWpUksQ
         2mvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R4vgqVSWQ1DzDgT21DMwC3x5aq70ARBIRF80eGWCgco=;
        fh=2ERdyJuP0pRXpaN6WGqeOjuSsCJBcGDE/TMasUbXNb4=;
        b=E+zOLnTi6/Cmz2Vpab+vVlexd8nXRC4h7tUZcpyFZVlLUR52EqeZ7SKvWOZa6q/Ort
         CtHq+CXwRAfd9fhmXSTl5z31rnRbSZsJ2Ddr+X7V3/YZZPmkCyXKqtsBqaWylVTfl+W7
         YffksOyDzlrwypIR7X8TCtvblK3UGh2ALk7/6T9y4Y8ot9vQaXKzhlCN0jG25t6pgqtM
         Ipjdfqk6rOi/SIaZY5epf9HIik2AtwnrUpa6PubwNnFqdrDH5Lb/JRqL9/Zt00wIhZzK
         j2hkpvdKGaOUxt32deAKFU/CFCP38rxGpcmmGOPl/f6leAxk5vFX/+W/YLAh16wO6Li2
         s0Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777450075; x=1778054875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4vgqVSWQ1DzDgT21DMwC3x5aq70ARBIRF80eGWCgco=;
        b=g7EpGDNfrCGVPSQr0RP0QuYEuPy7q0O6kuko5MdUsEMwj6i3wO3ZEr3Atw+y/UlXqG
         HgXzAAQ8Leziw3yy/itWKkvh8q1dJ9ywGyaladXSu7yBgo7abyCAw2gAVQdu7sSVqcV2
         wC+A+DVsLJjo3m8WZZSPXbUq8bVRg8qPbwaGisQ3b2m9K38TTSRXWOojcLtlkcV5TtQM
         e4+isWvSh39qS3pnE/tdyK2SuWL8sJd92nEo1p0OUquzUUXhRzD5BUq55Xaplk/eWpST
         OkSSNzIUzSMOZav3w8TzjfNeWWQ+oDwa/CcmUG4W/SFp4bpWRmsCrjpq9kjrTXt777Dd
         +7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777450075; x=1778054875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4vgqVSWQ1DzDgT21DMwC3x5aq70ARBIRF80eGWCgco=;
        b=nYvm1Z5eAh3JgYa4RXIu4XHqGLiwwZsfGk6FF67tEC0AdzVQkiklAv2TS2ZKTprBBA
         vtx1TDOnIOgxHfAQ//ASCk4KFPW9HQ2BDBNWMvdieLTBSN9nFEe37XExGY306ktTO0BR
         ynOe8tXkh/K4VlsT2HoQxPefHIXT0VEpa82Sep0cibrTYonyoxdk1j07+DKOBIKb/90D
         FAoVNql2+czdcv/8OhD83HIx2JvqL8nYnQFJ2PfQf4Gnbqo5G0zHuHHyLQ3Q4c76eMBN
         +kA0B24rhzkLZEHb8linaqKPGhDrOhCsd9PSpaTkTwbvFSfH0ECigStImoYMy5usT7Aa
         LuDw==
X-Forwarded-Encrypted: i=1; AFNElJ8aITNn54JZW6aCRmT3jmq6BN3Mq8iQ0PC+Wg63RCpdbAdIzkzvvy+uwHk2xGYdl8ddpjZVWaKURw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/pOZZGoRti1VW0wS7e1EtSZF90NPmB6y+OjijefsMVNC/TLDA
	1g8alq4Aai5V80TskFmwnTkIUrwqePDvwWQF77a9IidnJoXzHAF7dZAOzQMTCCx9m1fGgyMHBwX
	1ZarIjkvBC9/Dco4CZgeQ76LrnsSFEY0=
X-Gm-Gg: AeBDievDKlUeRES1PkrJfkgeXFoOa2pX0JdS0crv2Mu5Mo2Q8IAJ2QlCd6VJH/WOtWQ
	Yf+9BUhuGFizdl9V3IK/YAYikozFivpJsDNeGy6s5Hh83H4G691KZ47wOeLtvjfjrr6NoWfRppv
	xuNyAt+c1etj6FUhuQ/dCvXF/3gvjLqH6SObf3DPiw25CYg1DAWUopqh+CEDbj1+2v8fB0GMu94
	tPFJZmaX1qUPH67CzDs/cucC1TtmDXFzPBp/9B1SAF9efSFPlv/0tEUFTqrxlwwqLsBLIel4PgJ
	yaZKm9yiQRdP8BxwEig=
X-Received: by 2002:ac8:58d2:0:b0:4ff:c17b:5ab0 with SMTP id
 d75a77b69052e-5100e0f5105mr85723871cf.9.1777450074893; Wed, 29 Apr 2026
 01:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427120047.10830-1-xuewen.yan@unisoc.com>
In-Reply-To: <20260427120047.10830-1-xuewen.yan@unisoc.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Wed, 29 Apr 2026 16:07:43 +0800
X-Gm-Features: AVHnY4LFHNiffwCxL5zMPrydkdlGfWNx3f6Mw8wznYQTfO1arjhpvC1v91DjTtc
Message-ID: <CAB8ipk_R8=m3AfB=Fw5Tag3SPONH2ZbKnUR+AZq2DSS1MHJHyA@mail.gmail.com>
Subject: Re: [PATCH] pm/opp: fix race between opp_add and opp_get
To: Xuewen Yan <xuewen.yan@unisoc.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, di.shen@unisoc.com, ling_ling.xu@unisoc.com, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

Do you have any comments on this patch?

Thanks!

On Mon, Apr 27, 2026 at 8:01=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.com> =
wrote:
>
> From: Di Shen <di.shen@unisoc.com>
>
> There is a race between opp_table_find_key and dev_pm_opp_add_dynamic:
>
> dev_pm_opp_add_dynamic                dev_pm_opp_find_freq_exact
> _opp_add_v1                           _find_key
> _opp_add                              _opp_table_find_key
> mutex_lock(opp_table->lock)
> list_add(&new_opp->node, head)
> mutex_unlock(opp_table->lock)
>                                      mutex_lock(opp_table->lock)
>                                      dev_pm_opp_get(opp)
>                                      kref_get(&opp->kref)
>                                        refcount_inc(&kref->refcount);
>                                      mutex_unlock(opp_table->lock)
> kref_init(&new_opp->kref)
>   refcount_set(&kref->refcount, 1);
>                                      dev_pm_opp_put()
>                                      kref_put_mutex()
>
> This would cause the opp be freed.
>
> So use the mutex to protect opp's ref count.
>
> Co-developed-by: Ling Xu <ling_ling.xu@unisoc.com>
> Signed-off-by: Ling Xu <ling_ling.xu@unisoc.com>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>  drivers/opp/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 866641666e41..34cdcf8f598d 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2088,11 +2088,10 @@ int _opp_add(struct device *dev, struct dev_pm_op=
p *new_opp,
>                         return ret;
>
>                 list_add(&new_opp->node, head);
> +               new_opp->opp_table =3D opp_table;
> +               kref_init(&new_opp->kref);
>         }
>
> -       new_opp->opp_table =3D opp_table;
> -       kref_init(&new_opp->kref);
> -
>         opp_debug_create_one(new_opp, opp_table);
>
>         if (!_opp_supported_by_regulators(new_opp, opp_table)) {
> --
> 2.25.1
>
