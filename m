Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461DC3BCD0D
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700734; cv=pass; b=hI0K1V8xHnuXOBrylasVGMPkRKTlsZM4qOQIjY6d9d2c3r5BLR9q3DsHtYITCqmHFmcsy191oErRdi/pezFM68ldTGxZmz9puSG4MSG5scuiqMxrutRAxWSAbZU6Wvu39THOu4wPh5quz7sLfKmTSpMmbpASJIaHcrtScxIgZk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700734; c=relaxed/simple;
	bh=jwf0l5Fw+HV9E6x2wX8XBAM0k7K/aBNmScMWv44UYSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4x3DJigTjAF2f3SR4XZ+8Up0mRLLLQ4rECQIFwlYlmAnTcBxRUfc4ePp9Qu3Lp92SVzjKJ6fir6elZWD/I8eGD/9eU/MCynV7sFgqazc6oU++ylGjCzxvmfceqWlMmi5uiKtUjghDVgIMZ1qsZHg8mkAbZMbyVxxwiN+lImawU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw+61bMV; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw+61bMV"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8eacb7c8fso3795428e87.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 09:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790700731; cv=none;
        d=google.com; s=arc-20260327;
        b=OnDy5w4cwCyv2pjN1pBdg9nGbA2TaU7oZ/+Uu0p8CGbPoQ0+fD2Q+WjRzLOnuWRAQt
         0ARUEXceoKO5T09XfFxvJw9hqThOAIX+A8eoC1HAWTULPVNlByJ6hJds9sf/vIn50ccq
         Nbe9Xnd1yW+d3Au08l0oealIce4513a8fuoSJFqcayP//yPF/ldWzzXywxSBosFKDKzF
         O5xNZHh3G2PrFHtklIgK7UdXSeUdHaZPpO/E2lb0ozda214wejAusS+dNYUNTs6VMsVa
         lpjUMXsrWD0YG+wyXmkuatMpXGWD9KR+WoHHUuc1txBOtzumC9Vt/YWbOjLBK5+RlbaO
         V8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JetRDdCxvex9qzj4077GQtsI0JjV0QDP5tFqeoVoSsM=;
        fh=pF5kUsFFLjKDgpsiBOyezBuR2r09ycO/wIWWH+FFLH8=;
        b=nF2Jzk/vwvOEvZLwhyKcfq9RJgA1wWOALi8gQSZT728QNJ2gmUafYOVVCAfApcRSgq
         /jgH6AuikoLpUChvHiLe+9TOKaPdd+8Mi0p4r3woyVUsNzV13SC7oXIZXlftwrGrSQ4/
         Sgnv1B6RpJFOty4n+bjzAz+uD1DXEQdF8eSkDKdoBepI3fKjd8vo2nVYdUemSaza+yr1
         QWUXG/wBRuJBtDX4CC04/2RRUMK9+qBQS41Ph/YNAKm2YXFhXi8hTATX6SXv1Ruukrue
         umRfL5+16X9uIINXPJOosg4KB2Y1zPZcbaHnrOh0XDOHJi/my0Fy83BRYSRwOVjhWr4e
         FGkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790700731; x=1791305531; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JetRDdCxvex9qzj4077GQtsI0JjV0QDP5tFqeoVoSsM=;
        b=Bw+61bMVBinqQ0CDl+3rQBZ6DRBZ6gbftIAuZvd8jr/NHo+Omd2FfNvmYZLjrYG3li
         usR9Dt9pA0dM6zq49VC+RUslPcfyG2MKqG/rSTWKyPy3++bvIWN4lSH0VjNpMcxkdymf
         HEv8nwldvaO+qzzcZKAjeEyBltNHzTOstv4738Q7roJR+3SkeJwhRiPR7qBXNRgTgxMC
         Uxx8H21dy59XesoB7JKuQ5nx+vd3z0XhI4HyX1IjX6pqP4bu66zN66LkFGb7TFt+qO/Z
         qojRZgf3w39g8JKfMN0PKcrfMOUQm/cg82mefKV6USlVNKQjfMdJyX0oIjDx1MT4qT5I
         mfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790700731; x=1791305531;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JetRDdCxvex9qzj4077GQtsI0JjV0QDP5tFqeoVoSsM=;
        b=ne3vww1y0rUW9ks2vqU7nGGs06bkhn3VsOj7GoKiGeWXRoNRiVgwCdLhKFeWJ0rW4u
         qcjLjZCAfo6GeTMp4blvwOL7mCN+Qiy5VCK7mkFYlCGzq85SIPG7pCz1vVs6Fk9C8U1P
         P2E2GdcJBf8hTIlCiH7GVuhzPtruazXy/jA2uTfEuoPAdtHDi9lerxvTfdHsrAtOPnlZ
         7WwaHWxWqCz+Cwe2W3W9MIrOB3Uh5ecGbaSFZuPsgbVA1rjUqOCjlkiHV2rPHZJWdmwk
         z8IJ1uBoWazfVtlev/srWoaRfyVaMZx8oQLcE4ItS0OhP/gt0vwrp5L2uX+yjFUK371f
         pnug==
X-Forwarded-Encrypted: i=1; AKwUvBxBXMsDqOhF2vdSjjuQ4I5kf7uJTYiGA3dlelyGI9ym/1gNJj11hEbOifgr00mGULPbmOavHzynLQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLKUYsEX2kDyW9V7TckpYzMkGPYymoFC5bT0btTAfZgziJJfY4x
	HAPjr3NnHzXh4/ly6ckNQRqWX5npyfxxaT9SCuAPNyikuNUZxb+2+AJxC7N5gV1BiUr6tQ6P/Vn
	H6NtKal2B7Bn8XPiSTxavIlxeQhvJ4JM=
X-Gm-Gg: AYBFou2ewdKf77S2GpqgtPvX0YvxNJIAZ3g0x9NdGbg5Ag6gDOs/jWdCARKCPL4GLY2
	5764fGMvVZyIYMgXYulyscnrmQEONtDFiwlN+muKTISpiuGj7LKUjWEOQXmPnTGvLxOVJOmlGfZ
	Y2LTZxEtdCYfNv+uTSNroorpbIskstQAbuDlkSc3rq0uyn1UAo6tF5Zgr2/f0KJvLM/qb9UJFdO
	b+Qt6Lp60qPPBJ/j1MaP7iGkBY4XWN22kOl9fXUZRv6/vB1sZv09c+lDpUvetv31IsYXt+7PB1d
	CUbasugaQuVv8+01Dli+Ex966I5zLL0KvqM9gq2O6SVPzTcXzI1yS7tRstRfzuvbk/Uolr3Cu6X
	TKmoLQd5yMuqNAgfIuf8=
X-Received: by 2002:a05:6512:3daa:b0:5b6:1a7c:30 with SMTP id
 2adb3069b0e04-5ba3becf14bmr41478e87.51.1790700730984; Tue, 29 Sep 2026
 09:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926042757.2109927-1-geoffreyhe2@gmail.com> <2c521063-9f79-4c6f-a9cc-c1128066aa6b@oss.qualcomm.com>
In-Reply-To: <2c521063-9f79-4c6f-a9cc-c1128066aa6b@oss.qualcomm.com>
From: he geoffrey <geoffreyhe2@gmail.com>
Date: Wed, 30 Sep 2026 02:51:59 +1000
X-Gm-Features: AclHuK9BoLCeKcX60rOMfghguTPx1LnlcbeSQfOdhwtwXJywamBYVzyznEB7WQ4
Message-ID: <CAHAtOKHeFMLoHG8NspQcEec3BvsneSNODhd+AW7yGF+vFLOO_A@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/sprd: validate the sensor id from the
 device tree
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 9/29/26 10:46, Daniel Lezcano wrote:
> Why is there a mismatch between this check and above in the code:
>
>          thm->nr_sensors = of_get_child_count(np);
>          if (thm->nr_sensors == 0 || thm->nr_sensors > SPRD_THM_MAX_SENSOR) {
>
> (note the "thm->nr_sensors > SPRD_THM_MAX_SENSOR" instead of
> "thm->nr_sensors >= SPRD_THM_MAX_SENSOR"

Hi Daniel,

Thanks for the review.

The two checks bound different things. nr_sensors is a count, so eight
sensors is still valid and only a count above SPRD_THM_MAX_SENSOR is
rejected. sen->id is an index into thm->sensor[SPRD_THM_MAX_SENSOR], so
it must be below SPRD_THM_MAX_SENSOR, hence ">=".

Thanks,
Weigang
