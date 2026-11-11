Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794416205;
	b=OwmUtMqwB4fF1SVeswHFZ6UsVuUDkUuKDvORVDr0udJ9rfWZmovZwZPyIHGtXtk/2w+D
	 TfzdgSL4A6MItbfjkDWEAuDiXvrIOsNyqZVB0coLmAetFqA6YEjfnfRZQyn6Z/mhqoRxo
	 8/36AS2BRnEFK8eEcWN5jRTEDpBX62X7tNg5l9Y45ikjLrKOT+wsHFD4j8YXMRvjA8dNT
	 H4IKP6HOXmh0FAwlZJCXGfGDMKbx1dBm3T1AyuXG5RB/w8hX0r2D13cJRz8B3pZgGKTtj
	 giuLN2jbOiP4ZtI/kpi5ZS+DHbQUAY5GqXY/7Vidxn1Hd/Ox8fsuBSF4yq4VNGg+sNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Aqb51cKCA9gE4CD9ya0QHatgfv/z6SjRqePWGJDJD3A=;
	b=buCOTv3pW4y48WXp1gw7+Vt1UHUVlXpboYlZMs7CVNFLD3pdlcWeJokyRqkYdzFGFtfC
	 6ixGfDmr2RCDZ+BAZH/s1J/Jebc+l7Rl/wWiF5ktLCvukrQ6gKzIhmbSZtSs1m4GvMpyD
	 V1X54MUpUT/oOfn9IW3nYQ+GROTDbeVluUoqfbkBMBemYbT0on8wq03g9CD+ga87l7GNb
	 ME9XDlbs31xmBlFjsfnt2GElmAkiV2nu8vsXmBdwDg9+1LQ71Moow49Df84/7nxLoOKfw
	 V77Dbv+S97TDN3xEwo7/0jp8tSzRf/TNZR8zmRsxjshlt5ffT7QAkN/HTPJfmQ6s5Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HXkAfGVY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD5606A89A
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 16:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02BD5606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HXkAfGVY
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c505c561fd5so278580666b.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 08:56:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794416203; cv=none;
        d=google.com; s=arc-20260327;
        b=obWczUhSJKaau7ry0HIHILAtulV10V5VkFE6jgT14T+Jj/a77u0ctxlYzg3Dqk07Mr
         Lo8ZOo/DUwzgeXl5KDhFFr4qITu+8p6iVCksSacuA/iBq/oFsYFYp0VdvM19sa7ooqWB
         WSQVbZe9E6x52Q+SKqZmv7EmhOpoO4fEu61teuM5SGwYvCTCou8ydvpItjZoFG7tcinF
         G9cU8Y5mNfjTGhVaCkCZ2AIn3HIHpVgwsYDQCx3F/W7SqdyZ1/Ya8FdPwkUP0qREV8Ab
         98NvLbjtOJPLE4Oc8QklZqeJHoQrlZolTMwsFmrHdIHzSv0xRX3tAdGkL9r+LivEjga7
         I7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aqb51cKCA9gE4CD9ya0QHatgfv/z6SjRqePWGJDJD3A=;
        fh=tXB2Mgf0uCvkDR2cV9nBQIkFc1TXilf5sBpQRrAT+uU=;
        b=jeQBs2FfzX8IgYC389hjgVAfvF4dlq18IML2xX6+9NhwvSNIdGGawboSms+6025PAX
         wja1HEctSk6Pw54w07sVzcoFnjF9tjXEgJhzHgv1Pw0TUOSdmA7/lM7X6oqH/7RdCDJz
         DHDo0qaHUnKMk1EITFGvGYvkJgsku8WQWLFSba4cM3lIN5I23LnCGBSOKyJaWfqf3GRG
         Q40VD6t86ZlSRn+J18hOR4yh0P0uXrt6yjNz9EBwUSyGAr6HcCm4vRnL7XDTrXAXOdvu
         4eIdA37kgwAqVYRJM8MSnMILtRnT8ATA3fNAsUdFc361Qx99pTEk7MI9MnyY73Nn/iw/
         Tsow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794416203; x=1795021003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Aqb51cKCA9gE4CD9ya0QHatgfv/z6SjRqePWGJDJD3A=;
        b=HXkAfGVYaHobTnKwMXtQYTmiJD0jmrjhANtEiRxnIBsZxg5VNbUKZfZhyghqhBt6ps
         2+hg2BeuX2rjOPTUyzE/PFkdh4iAC+FIKuNhmS5fV+S8v/86CJdlFXEg9MBRHpINWo6Q
         FRzcDEoOJ/uZ48jfJA6dMBlT995AvHltiIhd+/0Q7pFRGThyPATzGZGFfSYCNZZjcYOs
         U2w5p5eNbfMr+dnvOX2HYodLYZ1PEx/3YlwzekqXEGyxgxeCPLy5UTqALnB4TZfXBrpo
         hTjFjZGpgCXVJQRXViVWDUE2xNRLrKqNA4Jr0BWI/D4Kz2b3DFxJpUJXpw3bfFl46+SP
         YmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794416203; x=1795021003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aqb51cKCA9gE4CD9ya0QHatgfv/z6SjRqePWGJDJD3A=;
        b=xRq8wU+9XlVI+q5rQlkOsQZWw/EUsPzg9EYjAT7FqzBJFUDH3eHRK8yZFZ1iNVWcQQ
         wh9Cl6QUE5Ta7f9NWYu+SBer00wWO1IW5IeTxDhCq8XWWrI6gMScq2jlcAobL5hUqSIM
         HD0DdNc5FyOdexlNGcB8NMGUwTt5sv04zQmSpvIyKCGEQySEmFKsS9QOrwfuIp9cL18s
         RuSJVQlyFn4aOxpWnfKbF22PUu51j0TyjAwku5G2x7FcNeMU0HUC92nTaqEs2ZopvXkm
         e13aHp3ke4IaHi2KBZQ7XwXZkGkKf0vlOCnoT9KoGDsCqsOsiq/dRSzeJnYmXEdw7Rqc
         ZAVw==
X-Forwarded-Encrypted: i=1; AL+hErE3O7+ciNpBcb9hjR1MBL8c9eEKDUb0vILDqTj7Kte1/ZD6OgylJEPb0WKw+5WcQIW8aOFWCpttwQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/PJom6N5Fd4GoqRasgfyNccYe40dkFM+DaU93DTzIvwDQVEr+X
	7HE0gty/z9vx1dZRGHp2s6Jm8r24fEVk810q9NMSyRjwI4WH7+WESF9SBeX7sAZc+zLdmnnGiaM
	UnctIPP7hT5VcTdWGS2BbazE5sODRbUwTe7QsGqnV
X-Gm-Gg: AYBFou0Wy41wB0suiqypnrvq3uiVDrGdLak8Qf4BuhFXefhLoMiy91eS2VD/9dbT3L6
	OEOFTHeyKNW/XlRdMeBmn0auaRxfX6K0M1BX8RZuwCvz68VmeMko9/248AzM3EkcpfyYPeqPpSB
	i8JPAjdDd7+DPy0e2PijGZPMUDTgMLfnICTAfjZXT9dNANAG9my2yypibZIsmHEJrVcTANKTI6r
	OisHzqbkLeQreMlVtl3WefAdWsQL2HfDLWMOELdl/g8oDhj5om2k6RrhOaoRGuYiQzEfbwdFoXb
	wMOPrWUjU246jnP9uqziOD3XmdWGX8ojbkXgeXGtEbhuPSMukZzvvbxHBsAnNKIbtQZ1dr81ou+
	LCGH3YqdVaahGmz+rF3fO9+D1dXisCFTztsH8kzaBe/EJpEGVoGEEd13WaRadtm7toAUSdg==
X-Received: by 2002:a17:907:a095:b0:c43:bf29:1517 with SMTP id
 a640c23a62f3a-c5066abbb12mr223619166b.12.1794416202670; Wed, 11 Nov 2026
 08:56:42 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-pm-runtime-summary-v1-0-12ebf283db78@kernel.org>
 <CAG2KctpRRDMXR8wG40PeohsTyAdoNC=+4Nc9pHGQc1fmw9AXeQ@mail.gmail.com> <20261111101152.00007785@kernel.org>
In-Reply-To: <20261111101152.00007785@kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 11 Nov 2026 08:56:30 -0800
X-Gm-Features: AclHuK8kdD8VwnaBbzLQVqTUgoqU_vlxOQj4ngzBW18PxropehXDJ3jwX7C2L8c
Message-ID: <CAG2KctqMYi+a-NZm7bAHTSc5Ch8=RAaEhY6CAZkvCnGW2VOeEA@mail.gmail.com>
Subject: Re: [PATCH 0/3] PM: runtime: add new runtime metrics and summary
To: Joshua Crofts <crofts@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 1:12=E2=80=AFAM Joshua Crofts <crofts@kernel.org> w=
rote:
>
> On Tue, 10 Nov 2026 19:38:39 -0800
> Samuel Wu <wusamuel@google.com> wrote:
>
> ...
>
> >
> > What is the vision for using these runtime PM stats once surfaced to
> > userspace? Runtime PM and suspend have disjoint portions, but I'm
> > curious if you see any non-obvious areas where these stats would be
> > insightful.
>
> The main things this is useful for are detecting power "thrashing" and
> tuning autosuspend delays. Currently, sysfs only shows the total time
> a device spent in active and suspended mode; from an energy standpoint,
> a continuous 50 second suspension is different from a device cycling
> 1000 times for 50ms each (these transitions can be pretty power-hungry).
> This could help userspace utilities like PowerTOP to more effectively
> determine what is causing an increased power consumption.
>
> From the kernel dev standpoint - this is genuinely useful when testing
> runtime PM functions in new drivers (for example in the IIO subsystem we
> deal with a lot of runtime PM stuff).

Makes sense, there is value in this info.

> > And is there a reason the stats need to be surfaced in both sysfs and d=
ebugfs?
>
> sysfs definitely, as you should definitely be able to access this info
> per-device (and this is the way userspace tools would get this info).

Is there already a userspace user of these sysfs nodes?

Adding these five sysfs nodes would easily create 10k+ new sysfs nodes
(a typical Android device can easily have 2k+ devices). Most userspace
apps would iterate through every possible node, meaning this would be
an inconsistent snapshot across the 10k+ syscalls, in addition to
being inefficient.

These sysfs nodes would have a boot time impact, a non-negligible
memory impact, and constitute a permanent ABI.

> The debugfs summary is however pretty elegant IMO and useful. I'm sure a =
lot
> of people investigating odd device behaviour would like this (plus there
> are overviews like this in the kernel already - clk_summary for example).

The debugfs addition makes more sense IMO. It filters with
pm_runtime_enabled() instead of presenting every device, and the
spinlock at least keeps the view of each device consistent. It's also
more flexible without the ABI guarantee.
