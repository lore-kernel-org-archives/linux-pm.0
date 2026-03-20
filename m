Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E7C2D592D
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999016; cv=none; b=f849y/3dnt7BrFpPWAvJepT5NQfxGpQyzoWR8d4hbilyMJxoS8AcUz3ZTYga8JYCv75nqW6wwCkbfoyeUHZiBLHP+UgwFv9bx+zROUpqq2t9cjvwBZ4uYRcGjVZAV8fOezOeMu8/+32NMs2hlW5xhiPB1H4ol8i+bPRBWRZcin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999016; c=relaxed/simple;
	bh=JLhrLc8Qi2YWPiNfV0u4HMUk2aw9RqxcTTQxxMvpheU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdnHCT7LwT8L9gVncq8M5cMh/frd+jRiJw2gj6WNsB8BXTuMf+Xk7N7sE07Tc+Cnschjr1ZxGQ9C8st7KzQeMW929sBwK6fJuM6TIjzqdQukNTXu8svooHo0vFRbAyiOBGsiArw7+0hun+YZN4aUzeJZpXEHKOgkghk3Ns/X6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56ba039eecbso527497e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773999014; x=1774603814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvZpuVVxetN8fW8SGMMv2oOoisnXVtBvFyOxNcmFsb4=;
        b=BRlcj7rJWhv5wRUYWBHp+3AqBOkH3YHxrRL5GqQTyHox9N2NXm3JjszHk+hR7VMNJu
         2HAXZw6Rph6+SAJMw6XjqZlgX/QXMtVGReJAKCmuqnC2qdm5M+dhHTU0BgcbZ4zK/rWu
         8gHI6796RzPkG5xN+WQpfcq7BtBi5FI6n0Ia/0k4j3K8gT2IEtDwzGElGJ+YSN882VW0
         x1+TKXdN6nkv7HRVXSjjtcKtAgAbsj4OKDurqVZgmya/zmYAMtb81h2Ah1fEpg1tvyZ9
         TAmKOC6d9X4xfvXw1I28w28mBYW2UAj/oiauhzpeHQPOI3rQ0G4VAnAWLBmPPr5Kbw1C
         FWxA==
X-Forwarded-Encrypted: i=1; AJvYcCVDlSQcXSbOjC0SIEVzM20UJoqTklH90vfaotE60N+V9PI/h7WC6lev5nyrNIbiUx98lLOB4hmXxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ihKPdCdTItiE/iZDVoE08ibVSNlkZE0BHqDnxfdhE4fPDKXy
	j5gNhsx0RuKLVuVU7pIVxES97reesbpn7ZjVlrfU6LNzjFDbeKLZJi5zZkYBFOrZCNg=
X-Gm-Gg: ATEYQzxg5NaJBjk6ZgwlIHw71SxprU6IIm5PjGaqw1QDmVsfFIl+kOxbULpajgbKEl2
	wy7JtgM6+TlFkcmx+MCR8BlaPavCxyspk7KHFss9i7yx7BfCfj+vwnWBQckKb2MWFPX6MzInBH9
	o5cPSL5b3kn3qJctnKDRrifElNEgjlfiv+KlMlE9cC93IaR4HPrWpDLrxohXWXIEt9RZhzFtLXw
	Bc44XvmIMOa7otljmBRQkFNO8YONHbpdxXCHmwgj5YSxKJqnS0SpmHlAzp0pl1pBTjaS8TCBnmJ
	rd6gMgum2To9nqbgqJvDcLT4Jd+xeMJMptmtgoVFpOlG1X9DwICEWkzkapzNNKDeScTH5NiLd2t
	qHym365+5fEWaKKneqmJCS0IPCSIdtLn+gKnba7R1tpHQFqJpTl8Ilt9TLnLr5ReDb+gZeFAMt1
	kGf1zfl4J/H/eXBlIqESQYO9dkn9Nmf5+g7qfsyS9xRi+9m7uwWJB5kMYl5gn5jjtpvHPq5fI=
X-Received: by 2002:a05:6122:488c:b0:56b:7484:39b with SMTP id 71dfb90a1353d-56cde342139mr1085804e0c.4.1773999014027;
        Fri, 20 Mar 2026 02:30:14 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddcf1554sm1320385e0c.17.2026.03.20.02.30.12
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 02:30:13 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ffd57b6fc6so428414137.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:30:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVou5yk6YqGuvhPexXKtiRFXJNc9QzGuDj69QTbJdGBm2rYE9CybeVoai+kSybudJxwJLXo78NjXw==@vger.kernel.org
X-Received: by 2002:a05:6102:32c2:b0:602:9b21:eee7 with SMTP id
 ada2fe7eead31-602aeda064cmr1023651137.35.1773999012540; Fri, 20 Mar 2026
 02:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303132305.438657-1-ulf.hansson@linaro.org> <20260303132305.438657-4-ulf.hansson@linaro.org>
In-Reply-To: <20260303132305.438657-4-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Mar 2026 10:30:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV_JRyi6c0gSqUQx15O4P=Jwgk+KF5_+-6Vgmi9Qhb7bQ@mail.gmail.com>
X-Gm-Features: AaiRm51lImfBHRAJToTl5QmKb5jcgwY_5cx4HzzxJL5S7cMijXzTjCMGdCoxrjo
Message-ID: <CAMuHMdV_JRyi6c0gSqUQx15O4P=Jwgk+KF5_+-6Vgmi9Qhb7bQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] pmdomain: core: Move genpd_get_from_provider()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Mar 2026 at 14:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> To prepare for subsequent changes and to avoid an unnecessary function
> declaration, let's move genpd_get_from_provider() a bit earlier in the
> code.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
