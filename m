Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794238056;
	b=EK38PVUerIvuH+77uKj00y/KWhEVCChEz2u/M5jR2GP3Y8wiqAWSjeLHrOlPlWDTt4gE
	 fPtXOrJPljQQpiaZ4F20z8k+K7tq0Of0XFLCBgbj7XH8BGAM+ZSB96e7SLIqHxs+juLSF
	 YczZs9DZQSiWm7XAcy0IKs/bg/Xl+kL+XJfKHwgbZGUe70oGJSQSTFs/iR8JPQEHm6/HB
	 ELzUrPJleUy0f4SUIMW0iv2e38rcwl9TBizGTw/gTSqSDbF0TFHppUZycPiWu2KzLQHh5
	 ryrJ/aT3SGtYMea9d5hekKlF4tVvhnzR/XoYv2PWNvsrGFa/pgRThbCqVJuqEB0evPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CkHUCom+pnwRgKBsSTRZm1uBXmondET4nnHsAW2LsKU=;
	b=ficnGJEtklZzLsCfXcNrM79Ui4Rn6F2x/yeRSiYahxMxwRhyvsGQvu/dGpdvXf1OJvqT
	 6HZIgGIlCatm3vcy1Vb3NY28AzrAOxY2NgiJSV+eO/sMSkSSIzVr5947yg2Z1R3vK6CRU
	 eBazPhgo7r589sqNLi8CDjBtlKPKg0U+G4C9S1Jw/bM12if/+MbOO4Htc4Dbpxw3Cnfal
	 wLdx8hThJUISmUsADgHg+xhNFtYSUX6hQZqcZctLq3V4E4upNviJEikaCoGZpQFIOsZnx
	 Gd7KA0bn4nCmh931uuBrXvlgfwL8Cd9S5dLvrqoDBXOUV0JgmNczudW/vayrM/EcDTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="iCNvQNn/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B83606A321
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76B83606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iCNvQNn/
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3b4944abeso193943c88.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 07:27:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794238055; cv=none;
        d=google.com; s=arc-20260327;
        b=mskpxjOV7aiuSl4frSa1/EnYH3rBL+yOGHie1xUYdI1w0aWRhRqMy2vtr8qOXKmHKd
         hRIrjx1GF8olYTAWmoUWyZ/YGNE/tlHNr4Gdb8e8x8PhckH0LPy1u03lJuSV/rBmIeQw
         M+othfOwWFDo0SfUjcKE+05r0NU+/UmoCFY+IDaC85Okm2kjVoynVTTQPbFp8hrR4zUi
         sbxPAOYf8Yz3VNDJv0lLxpcNPyAxqABvrzyWGJjYpbYZq+gXXJlcxZtR8Uv4Uz6wltbc
         JM+cdS5Iud+O4kWtufHwCh42dIMlqcOHpW96xeHbU+i61hvepgWFX0Pu65+HLGujzj2E
         TdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CkHUCom+pnwRgKBsSTRZm1uBXmondET4nnHsAW2LsKU=;
        fh=Gc789R7Ttzt5BsM8RjPVOXDczwHwIWYAbY1dG78BOKs=;
        b=DobmgdqTK83/yv+E/7XvqVnypL+COl6YShAgBPFD317Y/h9WpG49s5XWL9a43DbT7c
         epFA60MLFNvga4ol/36gbu2ApjVoS7Yh3Gy7Qhu+Qrci2Hww6vSjX1hZ+jI10DqvbWIF
         tP3BvI0IDcSe9D5Ho0NcOTvt0zAMn7/h34JN2sFih9DXerjniz4EoFuvTbQBzcp18dLV
         N2ufFC1gvYW0nO7V8xfC7kzNKc4qhVQ7acxmO7JdK/LjDyQqblRwBzDS2qx65rzRnKtf
         +CIN0gvF1PjoQdFE+dIMKVi8IulLC1lak7L0f2wEpyQGfFAM48m/tTgpv0pCSho2/KXa
         Ly9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794238055; x=1794842855; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CkHUCom+pnwRgKBsSTRZm1uBXmondET4nnHsAW2LsKU=;
        b=iCNvQNn/0UJ/59YGohB3G99zDX081O2aENAo9nH81WKcbVOa1rncgjeC42J6PLa1Fu
         yUqRtILJr3oTjHVHihXpAcrQOFb/uFOun6JbGwvrZTu/fahKGXAwtH2mAv7RO5dDLYqE
         S99Z5kUega0CsW/GuB8MCGg2CoXe1zEyqyrfclga7JnB8kuCwjIDhWKu7H/VppaOiELK
         IIFIOi2Bm7dd2dJ6GH0QVtqFcC41XPoR9QdCZRLtwmYAvfXFUcpgOd/jtmdkzYpVVPiw
         SD6dKwgQkMRhR2Ykieh5k6DlnUifKD8w53qipUspy6v9vSq3mgf60C80E1Ep50MY+WW4
         iLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238055; x=1794842855;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CkHUCom+pnwRgKBsSTRZm1uBXmondET4nnHsAW2LsKU=;
        b=pQBO6lYvTS2ahniqw4RANOyvpz5emXloLz5fh5HwgwAai1BLR8WUvzGcrpWWj447N1
         XLDROjWS3tLnNhUAKRo75FvSHMEZo3WV1COxmfU8IJVUZBjIcBRYZocH1HKvxROX5SnJ
         6EtzMkmTyaod1ag52U/EgVqJXA7ZZJoH4ez1IzMLts2R3j4miUrVbsejKtzrLzdVn9Xj
         EzkkbrrDycgIH+7ldD/fthsV1bJAZwJEBzg3v7JCp2Mv/WDnyuE7DlrBBKCbaMIyfHns
         84TDDl/gi0mcBHYy4mZ6OFiyhXAE84LOBiazU5PFws/G9RyMfyFJWM1rRwjnbVsNp/HO
         fa6A==
X-Forwarded-Encrypted: i=1; AL+hErE/mNFh7+U/DHWoZcfa4OIB/BqnlKtwxRcAN6bQ8TNbe13Mp+jItczdpbTjoOelHv/9MAwxVCy3sg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9QWnb6uAQUnypuBHxGCIwWSsJJXoallVAlU+GitB8hldNfLjGX
	v8il8FwGQfVNXALObq901//e2Vovk1pDoGWVpMY9s9410o9i0zfKJAMNAoSkoHUnCCOEqqy11Oc
	RnDM8oQj5FIPHWsh/9Q/h2qMhNy8XPjj0Y6jdOD4m3g==
X-Gm-Gg: AYBFou0ePCF07GFlNLu/cT/XVDSXfNlOAfPW6qqgYrOl1FVnbCQalc/kMiWFL6pZbTY
	CddzdlbkToD+ISMtAxlSvfR/FQa9T+dvMLgGZV77pEbPjgJQrLmw2kzO+72TeMVQt/kHRYcnU/y
	uJTOCJzeVaWrrgpKb8DUjqkWp0QKpDCMiE8gko0qRw7p+vIwiy2/BX5iS50XZA69LKzX95ve084
	zxbviagwVraQVrlAlJI2w6tWiiKmPUVG0mcn/dpFbv9qRMvB8pdujHkmy5/4RW5WFlT8VydA03v
	6BbCrwf1MxWcBGYugwG80BqdVdb8gFiJ3Qf12BX7p2BDgZ5A910VZNY6Z3nwyN+UFWBO0p4HuXf
	uyCDayTl1nVh18XEn4bibHGRicuS8deog+FOcYLfg3tXpy8a6Pi9Iz1gOaVMRdnxyrt0yvThThY
	BpVsKOUYqUDu9H2PU=
X-Received: by 2002:a05:7022:28b:10b0:1b0:430d:d81c with SMTP id
 a92af1059eb24-1b39feab6a4mr6840400c88.25.1794238054264; Mon, 09 Nov 2026
 07:27:34 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-3-vincent.guittot@linaro.org> <au38gSTzmvPKmqWT@scheduler.schedules>
In-Reply-To: <au38gSTzmvPKmqWT@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 16:27:14 +0100
X-Gm-Features: AclHuK9Nrs4TS1OKNzgmtAWPa6RLxFRPHbepbecLp2IzICCD5FnYMRrJefiIp4c
Message-ID: <CAKfTPtDXo8_3tfXt=UH+BKyO1rJCWjRAVXjO5nFVHO1NBd8LyA@mail.gmail.com>
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 at 17:22, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> On Fri, Nov 06, 2026 at 04:19:29PM +0100, Vincent Guittot wrote:
> > @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >
> >       dequeue_hierarchy(p, flags);
> >
> > +     if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
> > +             cfs_rq->idle_seq++;
>
> This needs WRITE_ONCE, no?  3/20 uses READ_ONCE().

I hesistated to make it WRITE_ONCE but i concluded that it was not
strictly necessary because the READ_ONCE is only used to compare the
value but not use it for any computation or sync so if the compiler
wants to do any kind of optimization what we really care is : is it
equal or not ? so any intermediate value that we would read would be
ok

>
>
> Cheers,
>
> Kayra
>
