Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904609;
	b=Pv89nm4GUKwnBteaAVwo5rtmH4hstVvAFkSPT3bdFuF6nICKerggjn29dYmY5AccG3+1
	 oPDXMEPlTvOxPkumRMdGWcCB0DBx6iN0qCS1ebPcxvP/ovoTGZSNcUXrZJv0HwjjaZD1y
	 ddonzY67RpYJU0MY3s+dglNl5yDJX6httH3mkyxc0Zavq59Hcl3WKi2Gls1sUnYjkurAf
	 YbkhoG/fH6GWDYAJubWV7XLGgAvAkzLCJoFG9r7bVGkMUYa5RB4xKkL/W32yzSsXArXDX
	 0adNFibIA9ST2kYNZ/IXitQzu87+PXBk0FTFT1tfswtR4x0yjLaZDDnx92vTtfBSlOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904609;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3q99sV0CGTP0F9aCb/I8pvy3j/8x97xfdz7qAywgDfE=;
	b=KPFq7w7q//mMHhVNzsdWljtbYK9WR236d81p8mB8O8u0lPVFBDJPhSNZD5TfkOerqWdQ
	 nTd2KmNYvqe6J5VXPDBqA7FzRXZVkjrAdecb8iXLoBkgLT9xDNnPYxOYLJDu5XlsSe0ul
	 IVggf6vp5vfea2T2P6Od6bQuzMspQIrf9S8tP0yO+rTZ8oOXoCsX2o/28HlbI6vKb43rX
	 Z8QTh0J2K2otA+fnlJtO30l7lV7+laEGlkYGgONf/IYzxPPaqpLvbzLnkPvH38ecdzN+M
	 RKhP9ixLssEjvquK5MVpR1+oGAEAnRuK0bwzCC++47/jIZ8N0K/PPax72MPv4b2IJVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIxGvI7O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F0606A328
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIxGvI7O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B891F00919
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904608;
	bh=3q99sV0CGTP0F9aCb/I8pvy3j/8x97xfdz7qAywgDfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FIxGvI7OyYRa7FlYqStpvfldUehSTlvZazbEUiTJ6C24Z+Ua2ojcOWwgaWg/ozh3M
	 ONo9GhyWX13WJTAVYf7jzGq1Zst0scwfSXJDTfbYeAiHMnHVll+0eeMJf6EVy9GgY4
	 5KhaqzUgBnhcvYjM+I/fqKK4DUUAeg3kMdlZnJr9PvgY9q63HbtLUWqXY5ftOAcsvm
	 mO0IYdHdl4BQuMiYpWjKtBN5h/YkTj5PRTh2BXqBOviYM22FH/d/FqnbpT9yk8RLoR
	 dD/UO8gUe5F06DgkFo4NzwJ6PS3onfOfmJT42m3VO/xZY812CuJar9airQUDhi5NTZ
	 k7/0wZCAZ0bsg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ab4c608a6dso27890641fa.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 10:50:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxht2yfvVz8m4BYLxw6dSWqqe0VM9EHemaLW55vYL4NJZi3Oi5o5Mn4LS0Zc+0VXQVnj5VUZIzu4w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Z+JvpjhXO0ZVuEVI/CuARpyZPkr5RzeuTQvD5csOOiFOtxCfB
	OVOREb/dHiYBbz4A8e6d2fipMrpRYIBiwWBC5dZsc8VIQosAXzE4B5U7KDxTw4EdTUm5t9NOhFl
	vBnl9pRQdNDdTzfucQZDXml6xxd6CfQI=
X-Received: by 2002:a05:6512:3996:b0:5bc:dd57:d0d8 with SMTP id
 2adb3069b0e04-5bfd95769b7mr7366100e87.58.1793904606841; Thu, 05 Nov 2026
 10:50:06 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105090311.1026648-1-christian.loehle@arm.com>
 <20261105090311.1026648-3-christian.loehle@arm.com> <663e799b-9cb9-4e31-a6a4-5488d30ad14f@oss.qualcomm.com>
In-Reply-To: <663e799b-9cb9-4e31-a6a4-5488d30ad14f@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 5 Nov 2026 19:49:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i-Xo5VbiFrwkEEXxbRsnEHoNhU3T3zDAAdOPX+LaW=MQ@mail.gmail.com>
X-Gm-Features: AclHuK9gSGNqyC8FM-TP7KH3eG3MRPPzTdrcWUcA8KnvyfWSZe5D-goEfiL-67A
Message-ID: <CAJZ5v0i-Xo5VbiFrwkEEXxbRsnEHoNhU3T3zDAAdOPX+LaW=MQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Serialize global boost updates
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Christian Loehle <christian.loehle@arm.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sumitg@nvidia.com, zhanjie9@hisilicon.com, 
	superm1@kernel.org, zhangpengjie2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:01=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 11/5/2026 5:03 PM, Christian Loehle wrote:
> > Serialize concurrent global boost sysfs writes with a mutex.
> >
> > Fixes: 6f19efc0a1ca ("cpufreq: Add boost frequency support in core")
> > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>
> The change looks good to me. It might be worth expanding the commit
> message a little to describe the race between concurrent global boost
> sysfs writes and why serialization is needed.

Yeah, it would be good to say why this change is necessary.

> With that minor comment:
>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>
> > ---
> >   drivers/cpufreq/cpufreq.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 23a77f5524df..d95c849f79c5 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2810,6 +2810,8 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *p=
olicy, int state)
> >   }
> >   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
> >
> > +static DEFINE_MUTEX(cpufreq_boost_mutex);
> > +
> >   static int cpufreq_boost_trigger_state(int state)
> >   {
> >       struct cpufreq_policy *policy;
> > @@ -2817,6 +2819,8 @@ static int cpufreq_boost_trigger_state(int state)
> >       bool boost_enabled;
> >       int ret =3D -EOPNOTSUPP;
> >
> > +     guard(mutex)(&cpufreq_boost_mutex);
> > +
> >       /*
> >        * Don't compare 'cpufreq_driver->boost_enabled' with 'state' her=
e to
> >        * make sure all policies are in sync with global boost flag.
>
>
> --
> Thx and BRs,
> Zhongqiu Han
