Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806A390220
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501146; cv=pass; b=Xff+raROFe1Q1m77aJwzs2K9hXj3vkyx1/BwL/JptVgWQf2gx5ydJKIJpYEWX5Sz3AqEW91odnYMUmQmsTYXiT+xuF2aZaPAH1FsimNxcUNOO7UwrPwCSrDYdHz3px4i9JAM3wGp/11qZe2fvBFCcQe9261R68OIbAgXBzX/2wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501146; c=relaxed/simple;
	bh=9pmHTV4TADk0gWWUpG8M/E5ZGSDVjZD7cI5hHNpdlIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbhYPTY/eQhz8kDPKeIatzf/Zd3BUguGKr3onIkCSltjN+fSi0SASNCVEXdyGw+E8lFtTCESRnvvusSv/lzHNwG6WwSYy86xbfMtmZDq+hjQb/Zq+moMHNwNEV7xgJXAZiw4UvHYiahijBJz0Cdn68DgjpL+eS7VzzKxyy4RsRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvID6AOh; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvID6AOh"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66dd0531d01so6366895a12.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 11:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775501143; cv=none;
        d=google.com; s=arc-20240605;
        b=d0XJCWfmnHCbkkt9IPMef15Jr6jry1Cyr/Hxys1f5A4P8kMeCCP11VXwIL8YmgpaKJ
         2vH43tQx5He0X6+JDmfafkg7DFbUiCKt9zCtN3VkYEEwwP4pE+65BIeL4drkCcPw6w40
         Q8KGZm3JMEcy8IWxxqQHyI+GZmJSSa/6ilReGwZXVwQxpCWdK9yW/gC4Wo4cojdm2YXO
         0+w5lwHj9wuojJbckb+H12B2/hK7m5SOojAkQ752nwqfCdxXH7Dz9vBHkOg3NjmGJ8ld
         GWC6m59LKYJ6IKJHijNrXZ/7pTu8NnYQiK0KgZozQMK7sTgIG15OuLU2DD0GZ90M3txS
         lmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9pmHTV4TADk0gWWUpG8M/E5ZGSDVjZD7cI5hHNpdlIc=;
        fh=z48hCmtC/IRR9Qc4lBjRVuYtB7haPTVk2QIf6pa7Qos=;
        b=bpld3oPUFHS1PReCIuGh415WLl7+AgDI6RUu+yg2PbGA1fdljCNKC4rpNLOIvoJSjE
         yVKcREO9pE+eIOERCTFRXj5/5EL+qhma/D5lipSHfPOnd/9dYlbGkDMqdXJCyIiccgmL
         Wc3g86S+tPqccUg3qpAb6tsgI0yLMoNl2UH6HPCnEuDD3TWUA3idTcoQe5Ox9J3pacAl
         bqN5s9R/m/5gpT3Tuo0kTzD+XCYQDtbwJVOqo+/c06eFJwo7sXvTnjWExCCRD/ZObxAO
         6XIsFMpdXaX90sS5By7GgVVyl5PXRN0GQxetyn/gPdzPXdy/eKxf0/lopDZ36t24u1pJ
         Fdew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775501143; x=1776105943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9pmHTV4TADk0gWWUpG8M/E5ZGSDVjZD7cI5hHNpdlIc=;
        b=TvID6AOhWa+L4+gvoy9mzK4z699+6jD2IQeK5WXq21Tn0aQdJvHTE8YK6aHBKcHpG2
         O/5ibJDgLOwKzWl+Cw/1puXZGbHukwGVRlBqRRXSWYwf8kZatytM/zzBqLqeuFjQXQgi
         l33gUTl3xdFrJpXxR+xWsRDr2L1+TZoWqw2eguVIF/eaYsNHmPvej5pRRsYxZelc31sp
         JfMehFtinjigL+HBsCT45DvWnkDKer3TLdfNnBns76DfjL9Mrjn+BcRcWfbt1wZRT4o6
         jSHIsvx4HLp5VFxlhCfaxJTwLj0+f2//XoOV7lVkjo1fHaoS8aP9RRhyLLC4wzFiHYF7
         OGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775501143; x=1776105943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pmHTV4TADk0gWWUpG8M/E5ZGSDVjZD7cI5hHNpdlIc=;
        b=Knw1jc5zi4ddwsQq1rCXrJWhya6JzdmDHK95vbbQUv/ELFnY7bn/FxFEDOKi07mCVe
         qo6QIkdKgFhs5wjG61V4pNJZuEGs/whBkWpi5wO/RrrskEo8jtmx7UzFxelOhxHBJ0Oc
         T4WX5J63RTXHqsUlVjpQ3QNp8mptxeqN2HydNWgJ8llM9hxGUP834/sAhacgp2ppQ11N
         pnMJNmqAERXMOQ7KdGdBOKKy8s3fuaAx4NW71W6PCi0WcnHRPqj80XWue8mBnnzS8+bk
         77Uk89Q53MAwUHR4ggmRuc8MMXVAAIdwdAGoP6q7qrypPRU3ZKuLu6mAo11J/yncFaRp
         MxMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPEeY2vSqEwoFECKP2ubNKM6rX+GbP1jZeAvaCn/5Ej0XPAYAwLjrXuNJcfCummxpsSnmAp+SdWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYt+7qyIQHbO2ePcZCyvAg7IXCyKYrq3GRjIwN3d0yRt0GfEl
	rOJaz1eiN1B4SYUGklnwJydBsn0wHspld7Ppy7vpj9qbRIfcMP/kKQ4kvBIukUDDosbtStnsyqH
	Y+ym33jkH6Kgum0YHg77osZRuT7rtVbI=
X-Gm-Gg: AeBDiescDVk4CHOI/FysSQE+v9ouYaChlQ36P24ca/atQpdCMTxP3/5Jqdl5xZmz+XF
	ilXRgC9ID5eFftk/6iIgINbfCVDCcS1Eqret10nVe+FGGPDyx9EiBR/daV68xSmOD+lFJQcaTvm
	VB340j6CzGrW1mfX7yFuOz8GyfaTzRFCZkfrDglSQ/Hxpqzr4fWsvMUPQyYsfOn503Q+cFa8IxQ
	JPljSEDDdCj2wteaNv3hTa4TKbTH2kLhGkXkAAtXYeGs+/GNZAwmhN0wUyl/WHXf8WJ191XDEJl
	Nvth8Q==
X-Received: by 2002:a05:6402:a215:20b0:66e:4372:73e9 with SMTP id
 4fb4d7f45d1cf-66e4372747bmr4169926a12.1.1775501143298; Mon, 06 Apr 2026
 11:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com> <20260119-patchv2-k1-thermal-v3-2-3d82c9ebe8a4@163.com>
In-Reply-To: <20260119-patchv2-k1-thermal-v3-2-3d82c9ebe8a4@163.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 7 Apr 2026 00:15:26 +0530
X-Gm-Features: AQROBzAP5CclShOimKNLKPr2Da3Hb2vm1DFd1fAAdE9Rewzt50idvfVsjIHzHvI
Message-ID: <CANAwSgRUM0HJSKr2zLYkv=LnWv85gvbc0_WD9gXywQqHcU=EaA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] thermal: spacemit: k1: Add thermal sensor support
To: Shuwei Wu <shuweiwoo@163.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Shuwei,

On Mon, 19 Jan 2026 at 08:13, Shuwei Wu <shuweiwoo@163.com> wrote:
>
> The thermal sensor on K1 supports monitoring five temperature zones.
> The driver registers these sensors with the thermal framework
> and supports standard operations:
> - Reading temperature (millidegree Celsius)
> - Setting high/low thresholds for interrupts
>
> Signed-off-by: Shuwei Wu <shuweiwoo@163.com>

Reviewed-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
