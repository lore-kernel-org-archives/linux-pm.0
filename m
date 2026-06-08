Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AA437C91A
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925694; cv=none; b=gI15tYTbOjtKkJq09pJCH/uaSBCJjVqxBout7kpWMxWguI/ziC8xz7XORWtDX09+5OT2ZZ2hYqdhkrkk8wU6faXp3IZGhSNX8nEc1WN8uWOmzk183Op1bmX9EzQQI7PTcmVJEc/yqhyVlR1/ZKJsVrBJ9146XlBmucaXl9ZpM0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925694; c=relaxed/simple;
	bh=6TP4DXEet8BLt0xczKFky+VO5C6mWL7hXd992e99WYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgdBB7onvgwaz1+btmRPmCs0xOliTM0pWAd1LKM1KM9zUqirvqU1Gbvnn4UlU+bzWV0QF63atvy1XLJooKIfdmdSKVExM301YlNkpXLT5EgcOp+z8ygAEaitUqSeehfvPAir8LJfxoKk6FGv/FcwfrSXlYxVSauC3kqLrONr2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/Qi2/A3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/Qi2/A3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F0B1F008A2
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780925693;
	bh=FTTNnYENiQwmEkIqairk4PrJggGCIdJnX8w+fYMEHkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=J/Qi2/A3UGCYX73wJ/FhDfkURsiR1r3wzmX028Blzjo1qkkNTHyxUYQ2n/1NYQiT4
	 J0MoE8/wj7ZZdq5TCK/2dMLvVMCFZNpkSJe8FIhfJ4IFN4wlqXAIKF1rjtvAYfthT/
	 +hA9YU4yhM97wFm8cZgpo2MIIyrgIl70nDrfEW/2tSJg5bLn0AiWb8OC2PCmu3kRMC
	 +6vCqhK7wDSjvesm+2CmzWgEq1Z1RPnG79ZQrCSy5K3/TnYtH2f8G3ZchLvWKkbfmf
	 FHYHqkvLGXgZPL7J7R7KiAn0b6Jl4rijXZbP9YSlQPUn/35Q+VkmzHz60+3PdwqOu5
	 40TDS82PeZyCQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa88b4f792so3217804e87.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:34:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8SW5unnMykbh2MzfOmuqIFQUF9sObZLla1D+/ncSb45KZInnCg+wBp24ULJMYIa4xvpyAucXc3DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoRHYQDuqZKgssr4O7zZFEJi3fhfy1JlVFsb9a3IXoaN61jnlp
	j0nCzJOHXdTnh4GnorXaWt4NzOamH+qxvLFUXVBdgLKCRtC//bhj2UBNcBBgmqxLfAsfEA+8nF9
	Yzbz+OmAGSQEqBRNS77JEB0nXhErvnGI=
X-Received: by 2002:a05:6512:2524:b0:5aa:6a11:3a1f with SMTP id
 2adb3069b0e04-5aa8865d71dmr2623756e87.4.1780925691684; Mon, 08 Jun 2026
 06:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603055635.1549943-1-zhangpengjie2@huawei.com> <210cefc5-c9f2-49e2-b2f6-2a3c1a42218a@oss.qualcomm.com>
In-Reply-To: <210cefc5-c9f2-49e2-b2f6-2a3c1a42218a@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 15:34:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hopywoftnDebg25rDVfTODKpgJjZ=jMi-3KADMg7FXZQ@mail.gmail.com>
X-Gm-Features: AVVi8Ccht1iHdE91GNmN4WEmx-FuILi41e74vlfK5Xwv1kby_7shZfEEorhsteA
Message-ID: <CAJZ5v0hopywoftnDebg25rDVfTODKpgJjZ=jMi-3KADMg7FXZQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Documentation: fix freq_step description
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: viresh.kumar@linaro.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, zhanjie9@hisilicon.com, 
	prime.zeng@hisilicon.com, wanghuiqiang@huawei.com, xuwei5@huawei.com, 
	lihuisong@huawei.com, zhenglifeng1@huawei.com, yubowen8@huawei.com, 
	wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 3:32=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 6/3/2026 1:56 PM, Pengjie Zhang wrote:
> > The conservative governor documentation incorrectly states that setting
> > freq_step to 0 will use the default 5% frequency step. In reality, sinc=
e
> > at least commit 8e677ce83bf4 ("[CPUFREQ] conservative: fixup governor t=
o
> > function more like ondemand logic"), freq_step=3D0 has always caused th=
e
> > governor to skip frequency updates entirely.
> >
> > Correct the documentation to reflect the actual behavior: freq_step=3D0
> > disables frequency changes by the governor entirely.
> >
> > Fixes: 2a0e49279850 ("cpufreq: User/admin documentation update and cons=
olidation")
> > Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> > ---
> > Changes in v2:
> > - Update commit message to reference the correct historical commit
> >    8e677ce83bf4 instead of b9170836d1aa, as the original implementation
> >    had asymmetric behavior for freq_step=3D0 (suggested by Zhongqiu Han=
).
> > - Link to v1:https://lore.kernel.org/all/20260529111122.3321645-1-zhang=
pengjie2@huawei.com/
>
>
> Looks good to me.
>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Applied as 7.2 material, thanks!
