Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452B42E432
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 04:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447400; cv=pass; b=UUDY2KowkYN85zFTXKdV32T6HQvHo4NBn6nQbRu0hZnbSvFA9rfwum64V1Evrs/i29pQIQKzsgbDoNAKEcPH8hvmbOXo3GelvfTgXnYvwglkHr0KxDSFjgqWzCI7vb9lxMd0YehN8WVA54yKRMEW5zyLsuWjtN4jQKx3KKbfuPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447400; c=relaxed/simple;
	bh=UoOAQKGYJOU9cLqt1H/9UiJiW7vYwYjslaP7yC1APho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6D2pPYCJO0qjg02iQ40F0Q2LJ4JSHKf4t/6KxiKeUINY103foiSaY5KX3y0rPNh5TszRvVC9p0tluT/IunolDLE+4h2Xq3pu+2ta1bPhkifNTdkZFRN3LRq1umZZncJHl63RuxlbuWeI/H8ZIlkZ6jBq3/XkSzk8v8uvx9Zxww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ8R94iD; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ8R94iD"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe5so410948066b.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 21:43:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789447397; cv=none;
        d=google.com; s=arc-20260327;
        b=OexL5lIkwTDrtN9fMzR26cU6YVHKnGXW9EpyNVjrK3rbJ9bi8uly9c64eRbMXF7iSj
         ggKnQ/ModEA/zAJ6Lf5Sq1aEu55kgkeew6Vi9v0oxseBDBzKn7yVYJMXBaCORV74qBuE
         FG9k2+L+b6fOqCSUs5ypKuJRbPfAexayay9kCeczS1p/4Y3UNHFGB5FEeAuZ7N69kspv
         Sun7cyRy+jMThRnlKcR0mNMk8u9d5Kixt8rRox0WcsVIO2MHdFVkwW3w4YYLqOB71APw
         0+7VDx+dd2p+vEK3DpzJYcQX8KDz+i+uGdjc3KVkUKXDNLaQU5hRfCT9HfG/Bn3ToFPA
         U4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UoOAQKGYJOU9cLqt1H/9UiJiW7vYwYjslaP7yC1APho=;
        fh=R0SP9ugPYBK96mvi08vI1Gxlz4ARdabNMAuucyzyz/c=;
        b=N9CHRIHFzzCiokAmMCjUO0hNNceJAlv5gbPv+dF9VPuiRaZuhlOUe/yjdLdplvbHT+
         LIAWhsGpb9Yqzp4tOZ5Sk7WJWtzgvSUmCcJHENCfwEmiXEv/8X1RxvIR6xFMhrEb4BPY
         oLtW35Db22sg4Ika8ZOZzWjw9tLuaAb51TjkozAM9jCD46PR4FsVoVVGMA6LYFpYeOlw
         jDdK8MxajcGo0EXzJo/q40cWZ2oZe6Qdepv37cFInn6R8v8tJKmebkP4I9QyZjVqKN3Z
         mkqVYF0Ggz3CJdPxb3e1LL5plTgXwcYkNzro5FEpMNXkKl4YYxV7J1TiEoI6Oz5W5cjA
         KkHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789447397; x=1790052197; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UoOAQKGYJOU9cLqt1H/9UiJiW7vYwYjslaP7yC1APho=;
        b=TQ8R94iDFwXuJX7e14L8JdC4fweRv2qVAmZU/jAi6qsHVzhqAaj7nr+GXUKXCzvRoI
         thn85S3kjCkA1cyuDHqjGcbqmKDE2+PAJk4Re+5yJPczSLI8X5G3v32HgYqLFD8nZVCd
         QfXWZ0W3FMzavuYh+n6X+REVhPcer3q95CI/qoqRbRwfzFbZGTuEjFhYBEdVnjbsWl0U
         4MHRNUZFeUXh5uFkHYoVKXxi60mCuSpdBV2DZTxWFXNtzLojwOfcUlXzp62RzO9YB03O
         401yW1UPVYTxjXKZeKs7zsF2heAkCsciqeeQEfl5b45Sg/eVImKV6zds/cp1tAzbjMak
         MiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789447397; x=1790052197;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UoOAQKGYJOU9cLqt1H/9UiJiW7vYwYjslaP7yC1APho=;
        b=sm21VkWQN5kTXyqdjr4ITjEmE/xScWCxkAQcWoZtM0/hw+Tad4s5H4x4OuGHY41vXw
         huoijWVd0aEmgtH4uDvlFNdBQHVzsnDkjq2lrPZp1sN5OUcURJVyZLwi4ntIiC6y/rVE
         RGEgnbUGoXEd0OY9P6tR/VYUgt000B2d0Sup/Pu9chBVn/HEUpG7Qb8sihGpFXfJ/Vzc
         /3W24lXc30ZrsYJaQX1D9T8ZDQDlCs5nJPAI3UiWPSYqZhVOezdkBmSi4Q4G3HQI7ZwM
         lZl7M8s7/fGMOjGJnRYvIceI+Yk9bkdihp4mr2v+U3HqWAOpJVZXGRy7Om24kzucAARt
         ZUXA==
X-Forwarded-Encrypted: i=1; AKwUvBywM9fgOrnacZ6o9LaA6Q1HLCW1R7EzDh+B9H863x17DRbzbVdCzqGf/lBni10rnodorxQW5Xg+jw==@vger.kernel.org
X-Gm-Message-State: AFuF++nUVrlnPuVGgXarDbK7yOxEcBn/mdQ4Vdt8hq805mlO1DYiTjt0
	9ZS4Ol6CQftKi8rddDB04tOeLB+7Xhxo21RUN1P474sRWr8Sz7Zr2XmSsUjedMXh2zzQlrh9OuR
	+gVZtQjWhIXk/kT97OIWBUG3ErqoCnqE=
X-Gm-Gg: AYBFou1/V6SX1LjFdThs5bN+pDglVu80OtJIISFW6Fe5sO1gyOmRcU96RqAgp72bb0A
	ubo8EDk1VzDtsOILR9xGppnLyfLDzKnM1xhYgfnMzI3zNUboLuwEB175JgLyax9dPnTamaKWXkz
	9rFo6DEvJqEYInu0g7C6QkuNboSsHyH5GVmeEIL7fHUi53CqRaIzUdm8KB6OWgrmvp+GBcLDVgb
	LfPRW1qc4xkN/GEBKeetDm6KSty196vcmAZrbBmOVhs5XdVaaTEY5WW2+c7YelcxrwI0cWXPd7T
	+7j4eqQEYEz2WyJnCini/4TrxA0lhm1nayD7WTBUAtcdm/L8Bywagw==
X-Received: by 2002:a17:907:1ca7:b0:c24:87e3:b8b8 with SMTP id
 a640c23a62f3a-c29b85faa3bmr342332266b.17.1789447396541; Mon, 14 Sep 2026
 21:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913145905.9404-1-linux.amoon@gmail.com> <20260913145905.9404-6-linux.amoon@gmail.com>
 <5c24248e-bee2-4256-af8f-a80be6744431@kernel.org>
In-Reply-To: <5c24248e-bee2-4256-af8f-a80be6744431@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 15 Sep 2026 10:13:00 +0530
X-Gm-Features: AcwNN1URmaKTajm5R0ygh2EGOJeV70g6e6uI0S2uQ6QQ5XvRrWbqrXu2Cftp_OY
Message-ID: <CANAwSgR6sEz8am8Vd_32EhnNjfybZAr=JR1MUjLHidZ+5mdTww@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] thermal/drivers/exynos: Remove redundant
 base_second register resource
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for your review comments.
On Mon, 14 Sept 2026 at 12:36, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 13/09/2026 16:58, Anand Moon wrote:
> > The Exynos5420 TRIMINFO register can be accessed through the main TMU
> > register space, so a separate register mapping is not required.
>
> No, the address is misplaced. You completely ignored entire point for
> second base, without any arguments, any data, anything, and just drop it
> completely.
>
> NAK
I removed base_second based on the observation that it is only used to access
EXYNOS_TMU_REG_TRIMINFO for the CPU and GPU instances.
It is not used for any other TMU register accesses in the driver.

>
> Best regards,
> Krzysztof

Thanks
-Anand
