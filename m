Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795559486;
	b=srdUJvibRE20hFcvpMBXCle3o2WOwPrsShiPOAPVIlDJ2H4E2paa4N3Ft7+Kk7pOIsBV
	 B2KFx+/Qxx27OMP7SyaNQq5uOgBxw0aGynpnl/jziYsJORk34IOyTF6sQFL5Jwau4aYUS
	 mNpUqMDWFvalwx6pJwYKoUWcdFiKkKxGGR3qKb5v7ezMD6XV81ZqyRIuQgEfn9UFHKlm8
	 NJZHSA3l8tBO+bastCeK9BF7tbRncTcZmiRhjjJbzRbF8IP0E+nxpCu/OHHZj7SqZ5kyu
	 s3kNHgwsgc+UX1bqm5Yc0lYorxKS1STaNsPI7LjYEEHK9BsbYuOMNViVN1Xh+Y16gZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=INRxzK7vSn4HoWNw09mGrnkGOVMtgkPRDzZLhk0h1pY=;
	b=fc6w7ekQuK3MM4PrBddIducvyZR+u5Qj8aX5aNuy6e9iQhag639CbyCUhq9oWRGXEWQD
	 DzOk9+EFC1JP4/wewYOyYlRiGL4k797Mx9P3N+UCq2hY/9pedUyHUjMjVX0dDpjxrf5y5
	 +fQLx1ZuvcQ17+JcJRdILLBwSrCERzr0AmOjJaW1xx7rLcTuPVuqTU90PowAK42VLPLZt
	 OEJIIhyR7gw2oDlnFZ0HaddjqUXodP9TpOkz5nS2YSFnGk6Kkd06X/MmNOZHe7jtQ9hpc
	 d1vkVn/YCZVpTHU5uvPpbhtUA4808UXtn273NiDjaRXiuovHt3JD4J3UlLJmcZb6cwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pq6hYJqL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEC8606A69A
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 22:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EEC8606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pq6hYJqL
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b8a2518f7cso5949361a12.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 14:31:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795559484; cv=none;
        d=google.com; s=arc-20260327;
        b=NKi8ui0SqN/AbT3eYB+vgpPw5zTRyuf9/7jNUuVlITqOM8zQZjFrkyMwkH25i4KmIK
         LmQKK1/X3R1NQQthrEWh+eTSH3fC6pyGRPqwzko04i6qPIXNRGZ9/uwxz3NxJvjF3/mQ
         rUH0ClxwPBKqvdjGvKH1uDtUxoEBEwNyVTg8+3qMDMFeVWAFFxhMkpNRk4ic9VNp8bYW
         Wr/LLq0D0Id1OpROeDR7gZqPXV6alCCd1b6TVoJTnPPcYMlVtdlgzwKAACoxE2W4abr2
         bnEt3VnbPcaL519R9Bj9VTguhkiYV4YbfroiHyA0tqQIffLtry0XU0TUUf7izMmrB+kx
         66DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=INRxzK7vSn4HoWNw09mGrnkGOVMtgkPRDzZLhk0h1pY=;
        fh=YNDXwiZjTU79H7g1lzlVCQB+5qvlwsGJq+m2iZzFRt4=;
        b=E9tFHn5JtJi5QLHrVZDjZb7gZ1bmwj/CfPw6zVwglEgo9FXMIB9xj4QhqLmmBjru7F
         fCeZJKTl2T+kyCL3GkpMhvv8DfPTEDLjr3mJgKZnBrkMkwUUSqiWpTE15I5X1bZISOIU
         r2KIvi1F7GljMebW7AV4igl/qyDmgLfsv5LQeV0SsLPaWgH0eIIhxXP5+h+KtgNOf9Fx
         1nRXa011unOobsJZ6NAb5PLrHVp+JG7Wbj25k/M5ghoGjSaZwJzPkWOLe1OaJk8YXeor
         5lbEDql4ZfycvS2xdmbC5PAEELFcjiOhGWK5Rep+4YhxMywwxnQ70fro3B+e3Agn4zUw
         qKRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795559484; x=1796164284; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INRxzK7vSn4HoWNw09mGrnkGOVMtgkPRDzZLhk0h1pY=;
        b=Pq6hYJqLqfjmwjq6l8NZL/b72FkWDY7/prko4BQ8KEWZLjnZPHCUw44AYwkS+F8DRi
         EUeoUtNsUmpvMracnT4N+GgMdEmq/lLExWZTQz/1x2gGNuR3gColGwjZifwMrkotSzq1
         d6CELz6FR9caGvQ5SJQ8Y9tQVYlF1B8Q2XaCePiSHWZdneDCgaC0t5wk53jlieeZPq0K
         Xr/gKY4gRbr8NIvfHqVM+4o2vEDZGfOtkWKPxClj2k43yKXLUk1wVQj7s9WACrQQEpw0
         Q98XJp/kNzbRIEqZyr+UWynhvWGPSRNCMolaQERiuhRGVt3CSC7buBUx16Xoa3CNaJR4
         u73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795559484; x=1796164284;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=INRxzK7vSn4HoWNw09mGrnkGOVMtgkPRDzZLhk0h1pY=;
        b=w5YJbTIu0LJDOV23y912sLyJazzbKQJUsY9zuncNIYv5Fs+wQm8U5XIaX9SWcToM+S
         Zcr3Fvjv33eUkNWn92ktRSyHYzmCWQ5hgpKZ8RhGTUgkuhFDC1Uq9znt7he47AWQ2ybY
         JQtQmZ4lgfg6ietROsXckPJTAidzasquBBeZtJ8whaBCkcVd6HmZzvYDJ5TX8UNp32Fs
         0AeWP09+ERjGEuD6N24ckU7eBdzqsgrG78DmbSiMjotOMppP5eR7aJ+DJUc1VkAN3iQt
         NyPRBbQAE5Ts++YP/1MlCxTIr/++SnLIRF1LJz6Vu5Vh3tuMwCxF4VftpG0xfcsivgcm
         7gjg==
X-Forwarded-Encrypted: i=1; AL+hErFuwRbRcOKQ7zBFfuF9h5ar3pubWhw7d/CGX4UPk7Ktxqp4npLVK8pXEYLf4A4bdJxBZoW1ApgdeA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/aiaUEM8Yq1i+z72XavJVf8g2HuUPwTHxgqAuA2h5511TNL04x
	i58O1Ivpos0aAYytcSXzfg0muuu9nkU7jIeP9LVEVpHNTUoUB9ESlQ8dMHGypnInhiwghdKlhwQ
	xbWlqejcbaDIUilyjxxwI17JRgo71ax+2UpMSaRnoeA==
X-Gm-Gg: AZFdTZeawA99D7CHad4yzosk2IfAOtIyi67lZ3sL3xj8WJ9461bXqHG2Ns8RMIERlIy
	CPufMVztchaDGVFjlAbbUSfO7XhxKINy7WggwKL/zwKYYQpkgvicqTNl/Xg6QYVF647MtdEzCsG
	RIWvn7Q0AWFcXrOu0YpeJWSYHpGg8su2SqhbsT3vkVFPlz5Sx353Ci3Z6Z+LEh4m3p9CHGoSvgF
	YOlfBrNACneI3jhGoujAyTLsIAU3Bw/IQriEgWfHq0cv/y34QjiBFQVu3IwnFSrj77N0HNf+5Ym
	GAtmlZ3xQwJurAKn26Qa4WxL7TVkdAWvjc2+k7KlUKGGk8OvjQeVdNsxuzB3ut0fL15ncWTqQen
	ccFtQiR7yPawe8KgTP6SjFTHZTNHqYDa+bNDigX/Ds6WWOZD0hp4mjIwwNlLVuf5yLpeFAepyVj
	oSwvF6dmhmm00ahEBl
X-Received: by 2002:a05:6402:15d4:b0:6b7:709f:85f with SMTP id
 4fb4d7f45d1cf-6ba37ec031amr9043918a12.36.1795559484024; Tue, 24 Nov 2026
 14:31:24 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.3.I7bc547c83b7bf677a62670099f481a91ac737073@changeid>
 <CADrjBPqnRrFeYT9J6NGxy+Xzy1PTZEz+BMs1_u2md7Ra6xPPDQ@mail.gmail.com> <awXf86suGgKeazZx@google.com>
In-Reply-To: <awXf86suGgKeazZx@google.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 24 Nov 2026 22:31:11 +0000
X-Gm-Features: Aa3M54olM1DKVBX3EQP9Zt-gD9WnHLwb_Lxu-JjOzcrrRgxAqJXxzL4OnVB7R18
Message-ID: <CADrjBPqG_TLwgOTzQ-o5pM7k1DzkeVxNkV2xDHsU4OBAyYOofQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] soc: google: Add CPM over MailBox Array driver
To: Brian Norris <briannorris@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, 
	linux-arm-kernel@lists.infradead.org, 
	Mariano Marciello <mmarciello@google.com>, Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org, 
	=?UTF-8?Q?Jakub_G=C5=82owacki?= <jglow@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Brian,

On Tue, 24 Nov 2026 at 19:05, Brian Norris <briannorris@chromium.org> wrote:
>
> On Tue, Nov 24, 2026 at 12:28:24PM +0000, Peter Griffin wrote:
> > Hi Brian,
> >
> > Thanks for your series; it's great to see more Laguna support being posted.
> >
> > On Mon, 26 Oct 2026 at 21:45, Brian Norris <briannorris@chromium.org> wrote:
> > >
> > > The Central Power Manager (CPM) is a co-processor on the Google Tensor
> > > SoCs, as used on Pixel phones. CPM supports power-management and a
> > > number of other features.
> > >
> > > The Application Processor communicates with CPM over a pair of mailbox
> > > channels (the "MailBox Array" (MBA)). CPM provides clock, power-domain,
> > > reset, interrupt services, and more.
> >
> > [..]
> >
> > +++ b/drivers/soc/google/Kconfig
> > @@ -0,0 +1,13 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +config GOOGLE_CPM_MBA
> > +       tristate "Google Tensor CPM MailBox Array Interface"
> > +       depends on ARCH_GOOGLE || COMPILE_TEST
> > +       depends on MAILBOX
> >
> > Should we also have "depends on OF"?
>
> Why, precisely? It's not actually a compilation dependency (I tested),
> although it's needed at runtime. It doesn't seem like this is
> consistently done simply for runtime dependencies, and instead work has
> generally been done to ensure everything builds fine and fails closed
> without CONFIG_OF.
>
> Anyway, it's a bit academic, since ARCH_GOOGLE (ARM64) selects OF.

I was thinking more if COMPILE_TEST=y && CONFIG_OF=n &&
CONFIG_WERROR=y is set. I'm not sure if 0-day performs such a build. I
guess since no 0-day failure has been reported in this thread, perhaps
it isn't required.

Peter
