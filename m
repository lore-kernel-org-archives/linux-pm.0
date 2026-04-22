Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE43137750
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840669; cv=none; b=JPP33kaZkq+WF5Q5EUVz1RnChwg8Jiu0Ao3tf8UZadCsiEKJ/PbkZuMGe7t/BIJlpMj1axbQ208I6TyCaNGMVJ0QyK0WZ2FOZmw08HUqijg8Ye/d0xIWuon3z61rz5JI2Mi+2nda8g8RBnFFIHgm+FT58XRb7YFrUwZJpSq3lHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840669; c=relaxed/simple;
	bh=wpkRjIorbMJMpqwzpLdjkd4Y24lBbCPn4ze08bDnJqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQAmQtEuaj3Xi9lOFoPwDo92e8N8Zasqn1SWa5jZNs8rej1CTGFlVMk9abKQttdFU+4DnZWJNesXGIqTZ2oiMzEabfoPWOB2kVhgWHNy1QG93ijCS4AsZgN8J+4Pq/8rJdbZfmnjMXfwYkSykDjtK9t3kJYAUBK85LHTaeh0zYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56d9f191ae6so3289702e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 23:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776840664; x=1777445464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQBlVUrhFqLpmXIMAS6FxW1MbLcWzT++sufCtB36Fh4=;
        b=Lbb8bzG7jPFDLnq3nWTjdlsF6iiF0sMd27HPYWntW+dMBd1M+5jmaUi8HvIYjB3+O8
         H0E6eLeapDDl9MJ9+fZwntIBp4QkrZU979WlJMzRs0IBV02t0CC5iA/1UqBdnoydNl8r
         7x79TqBd4Qsj2JYc7Hsd2KbwPmNTW9s4MHgAZ4vDtWKAj2TN+SO0wni8FSr8YHZ9W413
         KviwfIWCv36vR+JkQZLpPah0t5MnCTIe3CMxlXhpZEyAo2s61SHprN93i7sySAhroBmK
         r1EiCqXitNNhltBu/XvAPuCEWc+S4g5MMJeziXiz4ZDaaEZmJzrx8ySD2DfIi+4qWodB
         YDxg==
X-Forwarded-Encrypted: i=1; AFNElJ8VUjTzchZ3sEQ5/a6TDjHSdkZ8ljKrBaZrRMEb4Em3VmvTzS0QPmSUWTnzC6jaY6BdkuIGdUO25g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAL3ny+PaD6dvr9nY05CYnHfovYnWrAEIOR7osKihtM40acY7c
	IsTQqNhUfp5H67Hj/pt1U0K+/l4cW9Dyx0e48Tt5rzVqMxz737uvRRi3BWBMp4UBkFo=
X-Gm-Gg: AeBDievbDDIcIn5DjoEjPTv+LIbuPinDrnf0aMmIVpM8W9tcla3oIlDSU5QRdlc1e70
	pBERnDDogqLE66+NWnDB4WTLGJul483Pdd9UHRTIXkNM3mjrEou45xBYgyclQd8Adgfy5r45TvY
	m69tIRwzsnKec6ejLp3F9sLBdmUSmoe3TX+7vnU1QfrYPDul8R5b0+7jnTm9DICP8Ac37sLhFOc
	FnOsLq/vewnjSalkppE0UfnCxwT6ercc3CefgSPxPEW2WaMxfq73RScp0JlJfABSJHp1pjcXxA6
	FA/9Fp+vPnNny+RD2L2Fby0G/Gl0AdJlX7qV2N1/1k2QKpvB/J407k34Wj8uWwWi+GJXxi0+Vp8
	hkQ4gsfpCvoSQPKLvpyVYSIuMinSKAw6rEgNkjZRemGRyERXXdBXZpTe4B+SePrjFhKbYqOJjko
	pXNswrKdTyoJEq3A6l8xu9bEBJm/UU2lyhEZMa76uCvx93zhYP5HcntLL+q/LocdPkc+5mwSMVG
	NrKj4z3BQ==
X-Received: by 2002:a05:6122:90e:b0:56f:6b46:28be with SMTP id 71dfb90a1353d-56fa5931dc6mr10235573e0c.8.1776840664521;
        Tue, 21 Apr 2026 23:51:04 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa92078adsm8892139e0c.7.2026.04.21.23.51.02
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 23:51:02 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-60fa13bde2dso3315363137.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 23:51:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Bbv7I4hb2WTbZKN8VXPDz/6Vyd662MU8X1PzfrOYdcbvdLmbf83uHA9bC+5Vr9vKyHX57s+GiAQ==@vger.kernel.org
X-Received: by 2002:a05:6102:3a0d:b0:60f:f543:232a with SMTP id
 ada2fe7eead31-616f4b50368mr11299488137.2.1776840661908; Tue, 21 Apr 2026
 23:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776793163.git.geert+renesas@glider.be> <72e2a0e7a5abda02fe36b3f5851842f7a77b2593.1776793163.git.geert+renesas@glider.be>
In-Reply-To: <72e2a0e7a5abda02fe36b3f5851842f7a77b2593.1776793163.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Apr 2026 08:50:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXxEsYuOay0+Tf=4ByTAMp0=iXwcS4YSy7UY9_CE0hb5A@mail.gmail.com>
X-Gm-Features: AQROBzBFb_WdSQXK0LqlocZWzf5masVqawoXkZ-ffV8evv9b39yVA9knMtYt5TM
Message-ID: <CAMuHMdXxEsYuOay0+Tf=4ByTAMp0=iXwcS4YSy7UY9_CE0hb5A@mail.gmail.com>
Subject: Re: [PATCH/RFC 05/14] firmware: arm_scmi: Add scmi_get_base_info()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Saravana Kannan <saravanak@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Ulf Hansson <ulfh@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Apr 2026 at 20:12, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Currently non-SCMI drivers cannot find out what the specific versions of
> each SCMI provider implementation on the running system are.
>
> However, different versions may use different ABIs (e.g. different clock
> IDs), or behave different, requiring remapping or workarounds in other
> drivers.
>
> Add a public function to obtain base protocol information for the
> selected SCMI provider.  This will be used by the R-Car X5H Clock Pulse
> Generator and Module Controller drivers.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -3504,6 +3504,37 @@ int scmi_inflight_count(const struct scmi_handle *handle)
>         }
>  }
>
> +/**
> + * scmi_get_base_info() - Get SCMI base protocol information
> + *
> + * @of_node: pointer to a device node for an SCMI provider
> + * @version: pointer to write base protocol information
> + *
> + * Check if an SCMI device has been instantiated for the passed device node
> + * pointer, and, if found, return its base info.
> +

Missing asterisk, reported by the kernel test robot.

> + * Return: 0 on Success or -ENOENT.
> + */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
