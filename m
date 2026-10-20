Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480655;
	b=JKKBTbNeaNG7x7riAEoRTErF0ZrXCdg4GzvYpOBVFTZzsnAFXoewdXXV7A97qYJZJnyt
	 Z9AxLtstKXBEWZYhVQsWnlDdMJ6JP/AileGKwQ4lRwn6MsRyS2dvLgTLJ8BXwBj6NSeAW
	 VzZuOjkaT4Nk7qtr7ZLetPbQyY7odPg79wi5yPRpuO3L/aiEYMl9xqiPFyK9rmq/5xHUy
	 Z0bRBm3OmKzBay3Cf8ziZOrqiqgfGt06oeExAEnZo5l5bueqUoe5napLCL8pPQy49Mxlk
	 3Vn3ajFqUNc8r9I2K8BPdtixdvb8F2RzTUPm+wMqgdl7zmleCDqimr0D+g27mCV5EXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480655;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=PPF5Lg+md+ScchRlISc/5Y7zr+t9DzuuY8wGaLIwWl4=;
	b=DH62Z/Hpk1qIK5+cIlrJQgMa+JGGVplXU3CzUSEIH+MNVCaRz896e7qSZb1OV2mJ6c0p
	 s32yflyXKcJJqHex6WS6OAlecrpXzr57KBETAZFPQFT1zO0OViOWaGQ3zCHuhc8wDvqML
	 Eo76x1pQerW1xckCuDGMzZE5vQA2WHZsKuTz0/k8XpS7rWgsq2X5niL3UfQBnxQmUC/n4
	 mxgoNKLa/l8fxIoelC1HGM+QO0HXDBF3vsKp1Uy5B3cnkO5sJ9B+ktXNiXD90VIpy24BT
	 ReTh99TUTDicvX35NTb11I3LdS/3nXOalGz4cNBKjY+1He/UaKrqiVTpCNf9pIFI9Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE7606A31C
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42DE7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53653e30353so22605951cf.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 00:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792480654; x=1793085454;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PPF5Lg+md+ScchRlISc/5Y7zr+t9DzuuY8wGaLIwWl4=;
        b=V1VeYHyNC/6o4BDdNakTzL59OOlNT9CKK+MQco8Um/XvdA6vN4kDY8CIVTgYLXnXth
         APeM3Kahc9obH0UNvgkGblB9lA6SnaLML4OJXQvUiGBu4w7weKHdRIZ6SoSD6Pw8T20y
         AtF9u4zqdMS10e9MdeGTOcSVY1cAjmAqrbDJK5Q1KMDjuO7upb/1zW0OfBhgHAJ5Oi0p
         zU35WC04TUP2CEkR2h7ozyQhUKumLW8tIPEbA0mHu92AS3CMb9Qm9y3BsG4HSlLx5Anw
         7KxpB2ZoBAuJPncrlw8SIx8J/yDJgw849Tfa0VmjJ3a3mfyIiHEU+b7ppEgCzb2NWpGV
         G6Hg==
X-Forwarded-Encrypted: i=1; AKwUvBx0ACRgc0RUrdvBeTh+TyyfuDJvYINON/dyir/+t1kHoutZ+Aoy23fH51b9BX+zYK/tjPgPmLOhyQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYL+XjkV4FPo7NTrjXcU/trwBhljQsm7CRxjs0G2L+hZ6lDS3Nnd
	6LITk94aj1lFV0KAl+ykK1KCIee1XpzE6aOahaNk3MjnWSY8btvIVA/xYr4sNI22Bos=
X-Gm-Gg: AYBFou0empkYK6EF04b8zAZDPbomVK7jQvFNX7ZplevJc8kBkanTUechfXWIh3NZ37b
	iIHk4morr6jTLz5J5+QVEvoJl3CGqex+Xd0evowFO8AIoTLMCnGSnFhZBCtE2AIOuhr9pHxVNhz
	xXwAwv3Fpb8M5LVbU2MxGe1nv0KhbKGPesY5RXq7yITkUvKVgvunIwf+xhFV4iLW5esIUrfwxls
	J417b+HFQtyL1XmeNxt+Tjg6ZxrSYOiQhB2je5RUwWYHu25+KVp0G8OcPs2nkO7/kCVSb60J/Aj
	oqf3/U46+0jywa6kgX/uEVsjyc1cvXjc0BnVMGY/4x9g1oG4Pwz8z41TAQc+CE9X4fOHFnBY4IC
	6vUBWX0gDRIH/GahVUoDj81CKk4slhCITU0+7tumCpb3EbFBSsa39l+MXxBJZ3tjaeXQO67pJX/
	HMZavspJo14ozfubhwa2z8I6ylGB941HXY8IQylGETxiXsjzJwSY8V+76MCtf4bp/hrXaH/mfYx
	EDc37vFQRdcU2lVgDDNRY8z96VN/SKRrIlxW+lr
X-Received: by 2002:ac8:5d0e:0:b0:530:8853:1be5 with SMTP id d75a77b69052e-53645c32ef4mr165231001cf.10.1792480654211;
        Tue, 20 Oct 2026 00:17:34 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5363c24f7b1sm101730271cf.24.2026.10.20.00.17.33
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 00:17:33 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5365f9a04c5so26883981cf.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 00:17:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy6/051GGD/8hAF4jOOAXo7Co92ssfMUJko6grWZir/I3YwCzLHHqOdCzaLGkUWnXyhgcJSjoAHkw==@vger.kernel.org
X-Received: by 2002:a05:6102:3753:b0:7cc:1ace:fd0b with SMTP id
 ada2fe7eead31-7cc368f6decmr2272570137.8.1792480154006; Tue, 20 Oct 2026
 00:09:14 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792163045.git.geert+renesas@glider.be> <4524363679c1f2163aca3b3dda2bfbde170d095a.1792163045.git.geert+renesas@glider.be>
 <20261019160545.GC3705@killaraus.ideasonboard.com> <CAMuHMdUTz3BR48_Y8_UR9PEjLuavHtN-4uaEKURtqRXFBO0uUA@mail.gmail.com>
In-Reply-To: <CAMuHMdUTz3BR48_Y8_UR9PEjLuavHtN-4uaEKURtqRXFBO0uUA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Oct 2026 09:09:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWqgRL+rzQ7xEzn88Guy+KLUHmHyMwAdhfHhC8Xopc7uQ@mail.gmail.com>
X-Gm-Features: AclHuK-xW82aBw8g83Y0vnua8_TBb23MC_WawHBUIyGh3Twhft0MuZERm0ITiqw
Message-ID: <CAMuHMdWqgRL+rzQ7xEzn88Guy+KLUHmHyMwAdhfHhC8Xopc7uQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] pmdomain: Make genpd_get_from_provider() return -EPROBE_DEFER
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman <khilman@baylibre.com>, 
	Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,

On Mon, 19 Oct 2026 at 18:32, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 19 Oct 2026 at 18:05, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Fri, Oct 16, 2026 at 05:55:44PM +0200, Geert Uytterhoeven wrote:
> > > Unlike provider-based look-up functions in other subsystems[1],
> > > genpd_get_from_provider() returns -ENOENT instead of -EPROBE_DEFER when
> > > the provider is not found, thus not supporting probe deferral.
> > > Currently this is worked around in of_genpd_add_subdomain() by remapping
> > > -ENOENT[2].
> >
> > But not in the other functions calling genpd_get_from_provider() and
> > propagating the error up. Have you validated that no existing call
> > stacks will break ?

Sorry for failing to provide the answer I intended to provide:
IMO all of the callsites should be fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
