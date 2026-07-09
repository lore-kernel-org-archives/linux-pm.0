Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8BA3D25CC
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593418; cv=none; b=axs6hmM0rbKDQyexqsXAl+rHZ76YfSOs/Q9/BYdl67mZ1Rzgwg6of+pzTZX59nyZe0uvDf2diVqbK2udA5FG0tID/KLKJscef1DWJFkucAbnaoBabCExSRKzXsptH7jvD1hofI9ETdFS909tcsmK+4WgBSqmXSzB4kOqXCf+0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593418; c=relaxed/simple;
	bh=4CIPkQb4KkhTWhyWxYY18u//D5r796JDgZpLE+nZYNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIDcZ/m0KunR02lYX7DsBn8CU+1NavO9uXVpZV/GtkOAyvGiEoaoOEEzbPl7IxbWcO/i01Q8XNohSQsL33U2TiFxfTX+JjjmnHr5326HOXH1UwqxnsSwQVlOiuomIVBIfpOh90Ab3Cckhffy9s1q8lgJVmBJ4XLwGpwXtDmelig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-736eea06c3eso565774137.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 03:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783593416; x=1784198216;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=52Mzwh5zuD3pl6tySjFoedOc+SKNqyM0wWZqkOZl5UQ=;
        b=WAZcHMAPeZj2+KCvvyumvopBNep27Owi9slBtEeQoxCl8DXDAGe4+vH0pGOfwRA/PY
         7n4iLb/tvO8OsZOzYyPZp4GLtGLIXsCCZx3LU8M7LCUFSAOC2HG0r1TNPKs/XMMd98tS
         fz5qFMsDIEVVkZjWDGdTCCc0ZjG7diw7zWuszhhp3XnzE+7Xtxo4V/5jYaPrZj1Z0eAC
         QSvHUwsZ7E77cbRJc2efeznzDozATQ9gTrhb0pbcc4oYuGZTexCsihqvPJjB/dHO3g83
         32Nxam7R/r/Sl+wR1mIduGCuSeOdqk8UeRefkIpcZmE+7YlaI47PIm2Fxf16UK+GVzmx
         efYg==
X-Forwarded-Encrypted: i=1; AHgh+RoWH6HY0duehWkVVU13zGS0HUPV5Odc200+u6aNwF7uhTcbh/dH8mD/UFEHElG33r1IyBAsWzmnAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqqj7f3LitfUx576wT9WKI2PYxff+w76yNzmSvpx153xnqfQA7
	fEQlBQN+oVaAjROVkCViHJIH+8odGeGDbsaXto5Js4hQQZq+iCKt52IG4qIjVIw0eTo=
X-Gm-Gg: AfdE7clGBeDIyN05WaeTpchL0IlsLQWGfHwL4AAgkVIStnIL/oibFZR52wf0LFej/VA
	q3pZdQoSgBG1hgYv1q4DO1DP3pg8UUntGzYtt3vDme7z9OCDmJfjg3ko/XQHv/kxNCGtK9X1Dh6
	mMqo8SJfm47W84mp6YKwAdfgVROdu3MYWsDEwn5shZ06QnzlINeDntW2SYa/zVicropW+e2PXyz
	pNpSI8K6Q3eSFK8YbwOOiVc6Sg+WjWmeFFjmvMgGI16kIBqOZQYLtxEIbs7Bza6XH1w6R+WEVJ+
	0axAbVUYWxnA7UltMHjc4G1OAXT159KyCuSpcHoYZjwuhrGra2+vvMeDRnN5HgiuOB42cnFtGT6
	mIFdCWij3t61STWn9MYxsnYEK5/mKKSgUeaoKTrY09NMwyDL1nfPMGUBwk+AN2PgLHZStY+i//r
	J21IgoZFd0JjwK5M93QZPoKySs99Ecb8R7Hp9rbhDw4ijgnzL7IQ==
X-Received: by 2002:a05:6102:f0f:b0:738:be73:55e9 with SMTP id ada2fe7eead31-744dff85addmr3663694137.12.1783593416046;
        Thu, 09 Jul 2026 03:36:56 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed25847e5sm2723005241.2.2026.07.09.03.36.52
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 03:36:53 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9666739d3bcso578624241.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 03:36:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RppALsV/WgxpTmHRymiMfUnQRkzmIHuNtlLxbdC0gJoVNhqQlVwtw7usISIq7szmIqXwkmrbhL0fg==@vger.kernel.org
X-Received: by 2002:a05:6102:290a:b0:739:adba:f27c with SMTP id
 ada2fe7eead31-744e00f5e2fmr3715156137.20.1783593411950; Thu, 09 Jul 2026
 03:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709023048.599150-1-panchuang@vivo.com> <20260709023048.599150-15-panchuang@vivo.com>
In-Reply-To: <20260709023048.599150-15-panchuang@vivo.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 12:36:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhbufoj4PMBN4jZqBhvrVVkNP86By7vcjEjiDRRGz_Og@mail.gmail.com>
X-Gm-Features: AUfX_myNXBXKGEc9hKQlW5AX1iVW4ix7pcbGGCDTwzpx-MfG5CyqtA2qNt_vs9E
Message-ID: <CAMuHMdWhbufoj4PMBN4jZqBhvrVVkNP86By7vcjEjiDRRGz_Og@mail.gmail.com>
Subject: Re: [PATCH 14/18] thermal/drivers/renesas: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Magnus Damm <magnus.damm@gmail.com>, John Madieu <john.madieu.xa@bp.renesas.com>, 
	"open list:RENESAS R-CAR THERMAL DRIVERS" <linux-renesas-soc@vger.kernel.org>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jul 2026 at 04:32, Pan Chuang <panchuang@vivo.com> wrote:
> The devm_request_threaded_irq() now automatically logs detailed error
> messages on failure. This eliminates the need for driver-specific
> dev_err() calls that previously printed generic messages.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
