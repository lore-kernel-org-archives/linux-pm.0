Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40871D61B7
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 00:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774054017; cv=pass; b=se8tA60xjdNCfsdNhTkN+6m+7mmTKstiKdUvUocT9XT8Yi2H2yXMKhU0JrGmKZfk1Afxo607hUplEEjjgQFvZ497Zbk9YfUkwvlnHwoHlAJ/q+sDwn0Xl3h52yXK8CTwbAC4Ny8vJDyrHqyPBQQtYaMSNQwCdZ6nDnf+Z+XScco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774054017; c=relaxed/simple;
	bh=GKt4vcoKxRiDc5hKfgsDBKpS+h2PSAqQrw8wYfNmzEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oafa8Ks4g9ug0aqkkccV1l72awL9qzMqbHJ5NteoAMBJUNh141aRDJhp1O1KfBuw517JzMju2imjzAV3aXyEqN6/YxlxmIP0HXS7S3j3fXitVJrPdwMvbF+zUKwv5EmS5W9MNbGW6stOJJ+LgB97+mLfQdDPgIR6Me5al6YXfIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZ7upMTW; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZ7upMTW"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so320927566b.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 17:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774054014; cv=none;
        d=google.com; s=arc-20240605;
        b=SwGIO3N3/P0h03NHBrVo7MfsoakM47ADZ54as0rZY7tPOW6OhH6a0dyl7Onj2M/aMi
         ZDy3E+mgc5okOZKwuFABRtjkvdhUb87Dlizw5nzwYfJqKq9ZNF9nwA/bJ9i3LYArR8CV
         91B59erjWVhIbC/XyqKEuG9e/D1LFMpcvbpmowy2i+td/Owq42DfhS3ivQbW2X1x1CHv
         VI5+PO1HZDRWd31S4fUSy5/4EvmTzuQIWVU4Uj2mDxD+J0c2sPlVbYiUZh32GtDGgDb6
         PWWNghExCwbN98ZYb8e3QHMepiJBXsAp+aQaacz/JQPYYJEooMTuP2/5tsU6jKAqqHQN
         y/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+0bd38FVc9DlY8Rqi/0MBvfcLcfA2IutdpdwWLkr7Xg=;
        fh=xqh9GpYhCotoNU/Umig0umeW1IVmaCK3I0QH9Ahlm8c=;
        b=BdFUMiCPecDccWpeWf9eUvuO1fPsVE8jQHcmELhRcigBYyI1H98HBVNRpT6fb9kTvs
         SOUSKEqQRIWIA0WBS89Nskj4UjwQImF2OWF0/000LX4nvMwDeI/kelI0cGMwCAaEvq/g
         Zo/6zEyKGdpR718erso4E5OWprHP8GfJfFiBZLPyMqzmKBH8AIooxaKK9hCU0G7Vq7pi
         WMcNDJqa8HYmyMS125RUTvMFtdelTkypp0fbA0pylc6l/+q8I561tiivV+lkXLNIy88D
         2ThtP7ED273BuZl+bO5uHpp4CtvDOt4E99Q3sdP5wogJNUt/KGI8VrNbZ//EyFL9UlR3
         CbTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774054014; x=1774658814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0bd38FVc9DlY8Rqi/0MBvfcLcfA2IutdpdwWLkr7Xg=;
        b=bZ7upMTWpf4LPiX/qvbpHcHY0ltz70JGoVfzoO4kId9txbpXwFMj5T53rOE+xzgffe
         4J6wXd+50r3oJChMs0UlEOq7xHDqthSfck5P9k3rvPgz1lOn0Pla+fCLdWTuTTu3yKFr
         d3EA2VtToGrGF/xBiBd7T8yylM2Pw8VQGK3Dltx1eneYiDyzOTjkPohVR7xPdmzaMoME
         LjcQIy/9b+erb+56s+pP6BxaOzUn5ta6pkiVMdkrWdmzrlaKuJRAf8GLT8+sXYdvmzZ+
         QdCLw9zUpSAB8jg1wvPDC4jLYrBimfM4gjmcuG4xu2iB1k3S5g+q8q7hKbt6xrDbEAdv
         lp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774054014; x=1774658814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+0bd38FVc9DlY8Rqi/0MBvfcLcfA2IutdpdwWLkr7Xg=;
        b=PSzoqeN92yZkU7g82KhYNiNAp3RX8AlsZz2pQk4T+GQljIY/lm4COaim2uPAYpIQtU
         HWSxCCl5Bow+wwVJS1/ZBzow1fbkro4yKBXJdoZqgLLqqKtcANq65pB3ln/ojzgYIk9M
         GFAkfTDsfEYHQQlxaPBbUlfGHDlYHSAXeb+/JaHFDexNXPfI5l135W3L9rceT2emC7Eq
         pM+MxgNC6SqM7r8Px1ECmEPTCZAE0AaBBmeA9Qzh8CG01OGNQjrmsyzJuYVcLWWzIv0D
         pgqG3rp7+gGPpBdMRaop/XRXah9mByn3O/xQm9tb46dalkrVLrFPSG14dLpWfaC7Z8my
         MJTg==
X-Forwarded-Encrypted: i=1; AJvYcCX49TR/Aw2yL14jf2D2WXL5eHqvUFRfzkq40YfpV7IEml+3hH5aVkWlVvKwqu3mSBr4NYA7UrW9uw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0znPhHlpoFA14GtzoaJbwc7wZGMthiFszX5KNeTv8J8tyDHYo
	+X7BrkYaH9AAYBFC3bFMb4xWbKK5nAd1ix28OtNcLUwzdf0goxTts7dpk0wkk6pNCOrZPtJa2ON
	jpxMs7LMLLTqPATgcWUTz6pT7jQVfxg2JXDGzwaHp
X-Gm-Gg: ATEYQzwmdwokdcV4wbY7cc1l6QYZ5s3gA5ajGjVjXPaluq9om/+fXIZy7HnKEgf83tN
	x0cDokgw0E3kaOFxjg+F0hFMiYZprdgLdJ126OqJFpN5izSvwciXC8SapttzS4K+ltFH2wTu4jc
	88lXorOMBYLkVm5Z8ZKa/+mtP55dF+I/Uq8hmLVHqkZ4/2KJhE6fM3kVWeGZvgAkVOghd4GDcMd
	uOBm9boxAHxEMvwhC5VuTkcENohzZXjUV+m1CGmit5tAGBvQqAz7U/8YGDPDvDY08WYUps8+m3j
	OLclxxUBVgzyGSrUE82f39Ds8hpSGBg12V1Cg9kO
X-Received: by 2002:a17:907:a807:b0:b96:e3db:9e04 with SMTP id
 a640c23a62f3a-b982f4faea3mr346138266b.53.1774054013710; Fri, 20 Mar 2026
 17:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320160055.4114055-1-wusamuel@google.com> <20260320160055.4114055-3-wusamuel@google.com>
 <CAJZ5v0j-DWOe63meNY0eOCuT3US7Oqd+0M_hStmBO_nPnkA-FA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j-DWOe63meNY0eOCuT3US7Oqd+0M_hStmBO_nPnkA-FA@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 20 Mar 2026 17:46:41 -0700
X-Gm-Features: AaiRm52uidG_JN_iNt0QjtWA1eFaeRgUfs2_72YgoC__7LmSq2GydHxOq1wRUZM
Message-ID: <CAG2Kctqw-11W3fDudVdxmf9G8k2TSFq-iidZUGKPDmCp0Sq=vg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PM: Add config flag to gate sysfs wakeup_sources
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, andrii@kernel.org, 
	memxor@gmail.com, bpf@vger.kernel.org, kernel-team@android.com, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 9:09=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>

[ ... ]

> >
> > +config PM_WAKEUP_STATS_SYSFS
> > +       bool "Sysfs wakeup statistics"
> > +       depends on PM_SLEEP
> > +       default y
> > +       help
> > +         Enable this for wakeup statistics in sysfs under /sys/class/w=
akeup/
> > +
> > +         Disabling this option eliminates the work of creating the wak=
eup
> > +         sources and each of their attributes in sysfs. Depending on t=
he
> > +         number of wakeup sources, this can also have a non-negligible=
 memory
> > +         impact. Regardless of this config option's value, wakeup stat=
istics
> > +         are still available via debugfs and BPF.
>
> Well, except that otherwise it may be hard to figure out which device
> the given wakeup source belongs to, so I'd rather not do that.
>

Since the config flag defaults to yes, this wouldn't affect current
users right? And then the idea is that other users who don't need this
sysfs node can turn the flag off to save some cycles and memory.

[ ... ]
