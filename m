Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F6377EA2
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244525; cv=pass; b=T5SM02Gy0gYAzLgjMN7FMjkxkp/GgIkKCEf3kEunKIEW+CIm9HkN/5TX0XYSoj7ZL+r7Mjapdd2C3sz1pcaB6pbluudZ2BM5TZRdERbUr+CeiGot415l0BCvXEFYtvnekCgbms6mL5GaxzdxxILvqAubKNiL9ZQxIH94w34rH1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244525; c=relaxed/simple;
	bh=BDon4cDpFmYz8mQwr3AAQV3DrhPj3IR/41250WfkfjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+R0k96iTPD6nQavLX8ifDZtrIsYRxtZFdO68Y+SaWl6P8vamuM98UFl4Eke3p7L5iBKQPy5KzMHlr9q4bhS7NVKZMRwlx9kvfcUrwzaVJc4pec0KtJ3iIE+ErDcmE1imwlXJPYJDR2fQo0cQqCX+NgV6BIXiFJCSYEb33KmMIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJuaV8An; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJuaV8An"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a5f968ada7so1429919a12.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 23:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788244522; cv=none;
        d=google.com; s=arc-20260327;
        b=QOTWTHEmaoJ7zlPZRgDmL7n482QoT9yky7YCvmcfL/yKr1zyU/2QCcQ/VstSyJY27i
         XSgZeIoWBXn4NuMm/va9Ar1+50pySy5/8W38SUIoNBsqaFWR/KZG3Knfe/EecxapI0j8
         9bd6k9iNVH5Hmc5nVT7bXZ43pB/lDdEmjcsXx3ztw6unGDIAyfFtM3EkADSRFZRUGqIY
         wr1nvJvIBz+1xfXxW+KFAzgEkBUqb3TsRQcT/DFjxNOZPwTrBlDIvHGJmwaxnQrMEhua
         qZOnWzz5CrD1obfU3CCKOyFEHwOPph7husWEWdoDsJqcCS9gSp7TPBv8e/fSO34k2uPn
         Nzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PBRE3q8NdTAYGu0/68dIptiFGGW6PBAW2Hf2zZK1ifU=;
        fh=LPHEK5pSMT+GDX5Uzf0eyw77vFo/L7ubvTjL7MvJnNE=;
        b=FzbF2cnleuxPFSYPJmYIlgCHzrONLfevjgQOhO+sZVGxLvdLyd/S6OpQ2baYt3o+lt
         8Lka9TJ7nXI/aQ//Za8DKCc877sFxWEh2LX5Rjv6vKkqn4TNDlLXxuvZRgcgtCUo/ajE
         /wd+GRvJZXfwDdP/uGaA+2ixOaq1FLOfxFK3Fz9JCjTejCLsvenlQ6FD29LwsQo6DVow
         B2Ut38H3W8yNEovk/c89hrzxGkYwBrQThlyRFYYgUVo2clG8cVuOezbzpKZRk4SNhnRH
         wre/jC2do6z4Fn7npVciNsROo/Kmoegf4/e83r5mDnshyGjsqPSmeI81FKZrG9HykawT
         eT1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788244522; x=1788849322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PBRE3q8NdTAYGu0/68dIptiFGGW6PBAW2Hf2zZK1ifU=;
        b=aJuaV8AnNKXXOBUpWLK4vmUqa63/rYdfhLrWH4OC8LuQ7iZGjM2qhAW4Zj7AjPB1Wk
         COYUzhhxr3JQoXTMUHkbDDejIEM0R4rEmPDgezWB75j2GMgDPuwIGT0Vukz8ZDjA+prz
         vrI7pDhJLZctnjEWZF+xFx8lZUXJ4AT3PhM7HL3O9yPJqRz+M5Umla29sf2ay/YTV1UG
         i5e6QpUasjkFkBZP22NlMTmzcy7YKD5yDbMEA6w0/ddqDDY7b1vcclRmEyfGmj5N0F/Z
         FYGHIlIOe65L5fN/FXC2C8Z6hufXsqPivD8ogtJujMhae9khHKSVj9SpSirplcC9w6Fi
         cNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788244522; x=1788849322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PBRE3q8NdTAYGu0/68dIptiFGGW6PBAW2Hf2zZK1ifU=;
        b=OzMCHieJ4Ji9oHnxLMWnpywaQyQaxt/F1IjPdqcFCouU3ELsLuYdrZkyGO1w+g4tjQ
         TlkeQ97QvGPIgzqw/jBekadA/ofH5pWoUkblfP7tLekz5nSFev/fdaA4rXbptuPIL4+U
         68ijLtobkG5lhHel7NGOqM1CPBDVhR1uGj3ejIhzd2J2CVpInfOf+BeFvoDviFMkN7Ii
         T5gU9pVyifnyznX+ZEjE9nrjX7SdXtvUZ6emlxy6ADhrQ1kMkd/HiSp81uS+8/jyoHiC
         ZSkN5ujifzHI6tNTTwH4hjp8UqRYq73LkF91ZqC9IUtYpme7+oXPWtlicLx9Cs+vJ1+/
         5fIg==
X-Forwarded-Encrypted: i=1; AKwUvBwFyw5tvhCw+/b50hhQV9yJHIEDy+nT/sLcUzlIqc9X3Y+flGaQOTrE1xPtkM6Ln5qQ1FHTjZGRgA==@vger.kernel.org
X-Gm-Message-State: AFuF++kI2PLEUJnOM0SeY5+ZwJox50+lST8TZURGOUM9ZFLmZZyq6wva
	WyJ1f4iqZ74FD/2adV6mAmRsxOg6xjiiVl15MWt+SVio3UsjAVK1WRQTL9T3oGK1lAMiVfU4eqF
	5maIGScPgrqCkk02hbUI578fVy3DF43XEc+QlLTFvcQ==
X-Gm-Gg: AYBFou1s6UegldLbs7gs/1c5VQ+WdTnXu4ifcMoD07CeFpguAZBSZIT9dusmNPzHG3u
	jyimpfFYeJSGHezh/ra2zYl9MI7GG13DyOEF3vnzsQ7c4Ub/5kp4wjbYPx9zJxe2ufAt/n4FEJL
	e71ffNQ4yN9VTrbhyyxKyC4tREyMz0oayZi91awXtwzSHHZj6nWW/5SR2E4bXuHS+nzTAuFdv3D
	ADgh11ndCKWcDMqGtNpZeAqvp9M6YdOoRO5SRe/cqnecV/NdaECcMYnpiNIFwOMIrG57nHdsYOg
	rCgE1m0L82srMdfbGUu/0hMnzoi7PQSolHuH2aYFfw8+iakVZde8le+RwitcU2+ZAWBPJXq3zrn
	qUA==
X-Received: by 2002:aa7:da11:0:b0:6a3:ec9f:7e3d with SMTP id
 4fb4d7f45d1cf-6a66a611510mr1306101a12.6.1788244521855; Mon, 31 Aug 2026
 23:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
 <20260824150156.1310-5-sreeshankar0910@gmail.com> <apYNXZ9TJEC6rVVf@baldur>
In-Reply-To: <apYNXZ9TJEC6rVVf@baldur>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Tue, 1 Sep 2026 12:05:14 +0530
X-Gm-Features: AcwNN1U5hmy5zAxaLt_MG_Oo1HmGFV9z4ZXwGALePDH7cPQz-NpgtyLXkjVfVO0
Message-ID: <CAA-+ukLm-6FhxytqX1=x4pZUqZU_bmB+hVF_+5K1AW=-ZpPd8w@mail.gmail.com>
Subject: Re: [PATCH v6 04/13] clk: qcom: Add Global Clock Controller (GCC)
 driver for SM7250
To: Bjorn Andersson <andersson@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, konradybcio@kernel.org, tglx@kernel.org, 
	ulfh@kernel.org, bmasney@redhat.com, radu@rendec.net, 
	abel.vesa@oss.qualcomm.com, lpieralisi@kernel.org, 
	taniya.das@oss.qualcomm.com, danila@mainlining.org, davidwronek@gmail.com, 
	mani@kernel.org, robimarko@gmail.com, linux@gurudas.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Sept 2026 at 04:56, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Mon, Aug 24, 2026 at 03:01:47PM +0000, Sreeshankar K wrote:
> > Add support for the global clock controller found on SM7250
> > based devices. This should allow most non-multimedia device
> > drivers to probe and control their clocks.
>
> "This should"?
>
> >
> > Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> [..]
> > diff --git a/drivers/clk/qcom/gcc-sm7250.c b/drivers/clk/qcom/gcc-sm725=
0.c
> [..]
> > +     .clk_regs_configure =3D gcc_sm7250_clk_regs_configure,
>
> /home/bjorn/sandbox/kernel/workspace/drivers/clk/qcom/gcc-sm7250.c:2228:2=
4: error: incompatible function pointer types initializing 'void (*)(struct=
 device *, struct regmap *)' with an expression of type 'void (struct regma=
p *)' [-Wincompatible-function-pointer-types]
>  2228 |         .clk_regs_configure =3D gcc_sm7250_clk_regs_configure,
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
>
> Thank you,
> Bjorn
>
> > +};

Thanks for catching this.
I will fix the error and send a v7.

Regards,
Sreeshankar K
