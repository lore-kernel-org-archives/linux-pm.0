Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524B436BC9
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 04:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789447486; cv=pass; b=NFHrDcHQB2ZY8lZSofwli5566EAm8KY7j2jMFcmNocCG23Gw4zUWSc7QnsMc9XeLAd/D792PSfWa3F7/CtFgMH9BpdMcM3Tq/aS1TqF+wlPB/5xF2RzNrZxPpOoXavcYYBEjdFVvyWPIHpEGlgwdbtLRWz5KRMg7WtRFCtGge9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789447486; c=relaxed/simple;
	bh=OuAEPVCCSuU2/NfeOknYQEwV5oigOdlMWrN/kmgtJS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fy95+aJKu7uZm+wUe4/as/D5HbF8h/HrzPHUqJtrsmit+H8B6hybV9IwKtyBVYaKoaOFjVw/q5csKee+kDGlF44VPNU5eLeoZkd8VP+Rncpk6G1RBQ/UwOo1q9rGzMfZ4Dt5udDecS2lTCZ8cUsWxq6oQXVG/zk+ffBSuqVUgUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZyfek/v; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZyfek/v"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99c5de614so4004954a12.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 21:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789447482; cv=none;
        d=google.com; s=arc-20260327;
        b=m1fgC9MkH1B4kgmryEKkxIFbXpTkwZl6b/dQrdDNzhu2oYdfAPAV3YXwL1unNmOTlj
         0g/ZBy7qJkbu5LGC57P7pZ4d/x3ZxxvTiZYAtUzgOwAn9/XlIpMO9Jj349aLPxkMRipj
         o47Bn41T72rRgY6PBKu8TE6VLWbVvKisa8MzlvDi/h2sq7tDa0tj+njIJWjWCdKTaQeB
         DImUtFA+tuXU3eutWofPR9aiC2/Fl5wqLiNDOKIowMslndGyQ3ZtTu5ciynGQjdCg1fl
         LluNYbIPsdgwJc0Mh6aPkAFbta0Mk4pE7VyTHlcODWSFdXRWU1pfebjyDCoLj5hv1eju
         apNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OuAEPVCCSuU2/NfeOknYQEwV5oigOdlMWrN/kmgtJS8=;
        fh=dkRGEFFGkBR1Qvo6/aRJ9cYKAlUnQkFYVzENKqYWgT0=;
        b=eaY/UhWhki/EnhaZs++cTUcgBlLxyj0tQp9x3ogx7I/6UfES/+G3u+P5/+6p+L9+qB
         irzxaBnZwMw8StarEdw/YwuZtRSMiEvfu+WIUefh2mqmT/E1mpbISFXoF6/ZfItNTkGV
         kh9yiUc9IZwVSdM7hbwzrpk13lL3+yeQ1HYYViDapQqlYQBbv2OdDU7q4GIar+NQWM1V
         79S0Vffhi9Z3IRvFESOfRlPdrpp/fodpTNtBLT29tblIOTKoh2AFE6FnTqelATXHlteQ
         RTaCu/3pbcoj4B5e/mHieJjPlqqDMrjRIaTIuZc04ei0AoETemY6FGB+yCaXjMPQg3p7
         TM9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789447482; x=1790052282; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OuAEPVCCSuU2/NfeOknYQEwV5oigOdlMWrN/kmgtJS8=;
        b=WZyfek/v0y5My/4Go6IzmI693eIU9JC3pQ7MpNoRTcFL6MMm4Qd1ROaWIa8qv7tuOp
         zMqQqLd+fGiv03FI5L0jmfdNszWlJSB3Tw5mFonuCzYUjdwWJ5n7PdAXKvZucmNJtdMu
         5DsUpPF9H6YoqH8dxVC5hq+cotHi7qUCI9SGgWEOUS+QhWObJrX6Idhf/XviUjQiFCE7
         IQx4WOaIEDvleSTmlrQJsC9oCXSgvbXbUyZW0WtC3Iu9/uq18fvChD4nsO6UtC7bn1d8
         MA/m1Xoopr9AOdvaku7r7qsFMRTDegDVQBB684gXzfCBUr4bhVkMpc2G1e3vAqBUGG8A
         0vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789447482; x=1790052282;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OuAEPVCCSuU2/NfeOknYQEwV5oigOdlMWrN/kmgtJS8=;
        b=x1MoTKVAu8cbKUErVbilGJyeNkBlprIT7PWMPWHiC3FJ8RCWagljo2zhyNmGs3FsH2
         hU0SQxkbzb0oNcHFRF4XVVJt82jHgrIhSTNMsZvCOF9yYl9wclIaJe6Zw1RhI1tejSLw
         0XCarHYQQmZ0oDXBYGPzb5cVqZtRHAugtdHCgJO4zSW+m+wY4t96FlxtFWk1/YbVzFPK
         /RqwXi+KXQd1XTInR7OSf2wQk2dXdSJSFxK9IUbJ7zreMCrOkA2GKfHbH1zlMz8Y7rGY
         DaJH662uto/LeKqCD8lA/vgGKQI4eqvUpBM1hVGR1lnt7eveeupEndQ4TqXsQq7F28NL
         o2BQ==
X-Forwarded-Encrypted: i=1; AKwUvBx82isDe4XPVeNQq2ERctmRDu9dHZkAFoifU0MO0JjZc6m7cWTeBrEWcDw5umhMuFsHN0zFBqtwew==@vger.kernel.org
X-Gm-Message-State: AFuF++kLtBug8YaA5RHZEiaeD2uSrtTY6k8A3DVVqoZBGquFVsePruz+
	aX+K87uRuvsMVdCD/zNjbXje7fs1S9iWx5h87bMBCeOT/L6BkXFGALgfyx2JBAAuACPVVfDvnqq
	Flny4l1yLzhnQcSonEs2+jZXaA/M6/Fg=
X-Gm-Gg: AYBFou1E9hmvJle3RTZS+KkEcKJrV3hlAXOQo/+8G9ZOYCElp4Bh+fWioIHF13Q0y0g
	2cAhBXpbsT21ji7ECGWvqCzeiitGjLRswGVtlo82M/ialBK3ZlbwYqT4ooQ08dKFZQXK06jnYMK
	2/BQAdi4Uf/T8LCnUwgliJhvInBLuVAQgHXgc+qT4BHwqP9Qz/AktSt0/z5XVsbBIKl8Bc3Gp4m
	3Lc0opnlWv5KOwjGyjSPYSfeKHWDtVYbg//fmkeKr2bZvlMB90w3L9gEe9T3LF7acNKUERDNrnl
	9CZSE5vruj6e3AMmKQuU5vzogJ83+iJiDmHJgkK9GW6w5gLy0LhsCQ==
X-Received: by 2002:a17:907:3e07:b0:c25:8c05:902f with SMTP id
 a640c23a62f3a-c29b86b7559mr700042866b.13.1789447481668; Mon, 14 Sep 2026
 21:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913145905.9404-1-linux.amoon@gmail.com> <20260913145905.9404-9-linux.amoon@gmail.com>
 <8d547f65-a260-4b8b-80e4-4695d4422497@kernel.org>
In-Reply-To: <8d547f65-a260-4b8b-80e4-4695d4422497@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 15 Sep 2026 10:14:25 +0530
X-Gm-Features: AcwNN1UE0alxnYRR3jtRD2u3dEd1ayGXdU2bhjTuNvTUC-ZbJLtS9W7X8MU3WLY
Message-ID: <CANAwSgTEJf0gYQZKPQm+=90S5i2dRpJzOLv0gkyt+4ZmUTWZ=g@mail.gmail.com>
Subject: Re: [PATCH v9 8/9] thermal/drivers/exynos: Add missing drvdata
 assignment in Exynos TMU probe
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
On Mon, 14 Sept 2026 at 12:31, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 13/09/2026 16:58, Anand Moon wrote:
> > Add dev_set_drvdata(&pdev->dev, data) early in the probe function,
> > ensuring that the driver data is properly registered and accessible
> > throughout the lifecycle of the device.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> This is somehow confusing or completely incorrect code.
>
> Either this was needed by the driver or not. If it was, then why no bug
> is being described? If this was not needed, then you are doing no-op
> changes.
>
I was looking into other SoCs that use this while debugging the
device-tree mapping issue,
so I initially tried adding it. If it is not required, I will drop this change.
>
>
> Best regards,
> Krzysztof

Thanks
-Anand
