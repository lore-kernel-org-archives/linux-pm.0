Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEB32B10D
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464000; cv=none; b=JAluJpFYphemiYAc4EVFj6qf+LoR+SyqGONFagGLQlfXkIw6wmwRy/aNz5Y81DLdIrsB22XX3mNx1uoPIUomNbuTYMzMwlRpXTNS9s4HzYrvYyjf7ScD90HGcORR5dZe+4fFaLNWGYJh0/T4pcW0C2WyRTo6qjs55I0ZM3j1peY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464000; c=relaxed/simple;
	bh=Tu2dSrBQnavKqtFMzRV2jXUSSDx9ZygUM22V3o+37e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxzcnVIOqWQcqBXhpUh5Oz1LYFJ5TyayxNxlKwct9CvbZ2rHXqrmVJ5gzTT1uTK0JhQMmcwQaaY7vvfocRRdcJJzcPDvFHWM3Q0wIpnBAPclOC50N64KIfHauZaS+4aHSQ8mvuKTUvSztODgBUrscNKoAp6dWb1dtiIwewdBuW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0i2LBA7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0i2LBA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DFD1F0155C
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 15:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779463999;
	bh=ckkZ9rPSDdVH84BUrlor3t95Yr0kGa1Cl9MeWzIX5aw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l0i2LBA70LUn9XV7oS+GDlKykoUrEraKD0B5u0cESrImBJfunqUVPP7tF4Xa1Et5K
	 CBQ4sEk/j99jsVEdOG2GKr7nwlha0AvZODnWPqO37gWglT3GoJfYLCDb4HvYJvIY6a
	 70udBjCl/PAONCGBpMvdKQfuXMMSTAjliw0ZEWYwqub8TOvXs4C1dl9G5XBjKF9Unz
	 FLdgmfM1JkIu1ctkAr9EIz7uWSuIGCPREUjI1ccWvewJjXlBRtxhsh83g0hiiWLdMt
	 7auugvH/Hh66Z22ED3BJSWhkzQqjkAuEpBB++FEGbNC14ShWCEjfso+0neUq1tjyHc
	 0FpFKENy5wm7g==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so7142272e87.0
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:33:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Migsqeb/LAJ1t3gH+VHdH0a6RpiUU2Mn4LUzcKJerskDCdTlPKYyq4u+YXcNMwIJN/8KmOB/yIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Bv7rYw4d1kxvTPskxzDC7sS34PklGpuGEbgQ9LEbeZiKbf+q
	EjTGRondsVYITR0/+CB0SD56L/iDChR6+TatVW92OUAP5/+8IRLPM5G4T20IOVE29mPsGMKYG3L
	/j0hc4UMy3VofR9i/wnR+VyxYQa1wvVw=
X-Received: by 2002:ac2:4c4e:0:b0:5a8:89d6:93c3 with SMTP id
 2adb3069b0e04-5aa323bc5dbmr1225669e87.21.1779463997519; Fri, 22 May 2026
 08:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518133457.2408463-1-zhangpengjie2@huawei.com>
In-Reply-To: <20260518133457.2408463-1-zhangpengjie2@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 17:33:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gj2Qa_gy91QQ-wwWH6zGBhuO1SujSVXvr8UYp935btoQ@mail.gmail.com>
X-Gm-Features: AVHnY4IvMxnx-fW5FH7lORMWVquEvE-K5lCPGGtA6lPS_7Da8kE-OIFWKujdpAE
Message-ID: <CAJZ5v0gj2Qa_gy91QQ-wwWH6zGBhuO1SujSVXvr8UYp935btoQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Documentation: fix sampling_down_factor range
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, zhongqiu.han@oss.qualcomm.com, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, zhanjie9@hisilicon.com, 
	zhenglifeng1@huawei.com, lihuisong@huawei.com, yubowen8@huawei.com, 
	linhongye@h-partners.com, linuxarm@huawei.com, wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 3:35=E2=80=AFPM Pengjie Zhang <zhangpengjie2@huawei=
.com> wrote:
>
> The ondemand governor implementation accepts sampling_down_factor values
> from 1 to 100000 via MAX_SAMPLING_DOWN_FACTOR, but the documentation in
> admin-guide/pm/cpufreq.rst still says the valid range is 1 to 100.
>
> Update the documentation to match the actual code.
>
> Fixes: 2a0e49279850 ("cpufreq: User/admin documentation update and consol=
idation")
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
> Changes in v2:
> - Modify the title.
> - Add Reviewed-by tag.
> Link to v1:https://lore.kernel.org/all/20260515094930.273599-1-zhangpengj=
ie2@huawei.com/
> ---
>  Documentation/admin-guide/pm/cpufreq.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/adm=
in-guide/pm/cpufreq.rst
> index dbe6d23a5d67..fdca59c955dc 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -516,7 +516,7 @@ This governor exposes the following tunables:
>         of those tasks above 0 and set this attribute to 1.
>
>  ``sampling_down_factor``
> -       Temporary multiplier, between 1 (default) and 100 inclusive, to a=
pply to
> +       Temporary multiplier, between 1 (default) and 100000 inclusive, t=
o apply to
>         the ``sampling_rate`` value if the CPU load goes above ``up_thres=
hold``.
>
>         This causes the next execution of the governor's worker routine (=
after
> --

Applied as 7.1-rc material, thanks!
