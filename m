Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495424;
	b=gb6PmrABx1Kc0IcrTLx+7OvxlCwLIcN+2rgftgF5hGgOZX3rSo6UXw5hdY9r58UOP0vB
	 Gqw6L5tWD+buFyhrEjDpij+0CK781e4ZhAZKbBe6SFhygtenOpYRMwco43r8+sS28v7S2
	 xzoBWqWdQjCbYmVkJ8Shbl75AMrOn/x3Alf+z/IinlFuKKJTbyYi9PFSe22lX8T1/N+4V
	 DrcDuduWMYXWT8kIj8AqG9LosPNkr0K9qr0GFKrEDhJ0NFtOkRZqMjtjEEOL+V3wLkAyq
	 oM2jeJ0rgzf/T7p6+55xW4K87H7zJvrrEBbtQ1/dCCsPDJ2Z/Q/UmYKbZ/D8vIhWJDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495424;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=+5BCTHh1J6xXvkZ55mDmFJRrwUlGVc7lU2YIf178GaQ=;
	b=sQCtKRJ71Nj5LzxzCpKYpk+RruBKv/s5BslXfHtxqk37Yd/jMBYPKFWBxFqO1d6Yu8JU
	 wa/uX0a2tUHzxDcmJjqCcMpbsFe6aQV3qaWygg60uiQTYzW/QC5ZAuFYHLEcDw8uV3Gnz
	 fgpmPqMKbslDOdK3qc1VE1vrBqOpe7jOWF09SI9zOM9kFuzjceJ5LvW1nPEVSE4j0Ml0w
	 p/NTGq/E+DfJK+5ehplPGT1gPiMCBtO92f9GyHqSOLGeRPzG1vOq7UnXlHbdcySWvAHVc
	 qLeGtmZgJgzXsR0+SDn+d++XeT1c+J8Z/vt/7qNI4VePTewjefMZSqQQxBqOjt76QdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E6606A31C
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F9E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5366463571cso51293121cf.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794495423; x=1795100223;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+5BCTHh1J6xXvkZ55mDmFJRrwUlGVc7lU2YIf178GaQ=;
        b=zw6h2WvEfvcrq/FqZgo7qbFRQdQx8vTQEPFTPWDbkkamzfo8jQ7iyKFzzrwGWHmaMS
         MPx3ZEMwLUydd0hqf0UkPElAV5vs0yUEC4BlMZrGR3fZsHbJicbyXJ6TqMHyek5sBkd+
         CNUkdzc0jTnRMGOBxMaq1f4Xx6wSp+/bLo5zGehrPkijtIUxoJe5LqO1Kx1ByEFhW1iq
         rQPEz7UkUftqqbLBk60QJS1OsWCv8GdEX1gqlbpV01WtNrY3KQxCfl7v/gCmgZE+ImJ7
         BG7DQxlgn3nXIKj6vLqtiU+nxPbS91lbdfw2hkU/5F0BiEX2iBMCzH0H0RHMT3LsZ7Nk
         ENPA==
X-Forwarded-Encrypted: i=1; AL+hErHfjEwFvsWADnD/+lisRQsLFs6gBWP9BbMYkVASM0HeIjYMfFdbC1tsjzRLyREQwwb+fr7MFfjdnQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+fa2pKY5OC/xvCzzlnvUWEaBGIE5q61VkAvLJXDr6XNTjkH0jP
	BD8JftXUuYP/Be6T0cfKYfpqwdbeO5NcytY+koRQMaT11XdWYoOMWBC06roPBw7qAJ0=
X-Gm-Gg: AYBFou31y8Lblov/LGTAYQ2td8NlEJ9hy/yAPOGWD25DJTWWEK1klZ9vDlKxS1XinrK
	reBZ56Nvmn59Ho5oDi9nImnZrGkker4tLpQSzy7qfj32zI7aXxLvhUel/yg+evVM8jYqnCW7xvR
	VJ5bDpCk3xVCNfv8NeID3RKldsNEhBmIykgmQb/c8ln0ZLStEuMjWP3UJFHsn4lAgi6Dg9Rbojw
	93bYs8WpbNiQ11qY2oNvk0wPg9jRk99V8hsv2xMFyXMalzpcrqH6WE6ZQ8er40NpqMFaMe8sxLN
	mpF43G0p09ZLyvd3uBlLHVE1tbYGT25HuF7bRCkZPMFE5UFL4pl1IFloGq7BXkjW3jp8fw0Bb7j
	QN+0oNiYy7QBnuFHcXkufqZoBL7S8o1+5U5ZQ57bF01cz4Ey2dmJTFIFV5Ky+Ig6OqtJtMI+QaK
	/MR09o30Yjs+GxHHdEeo/YlhWhGiNnUSDLm39XU54k15vTuUF6KLKaO0LcY5EkcAPbKm+kgmWHG
	FKiRUmUDZ0EnG52777jGUYJeKSSMfbT3d4c1sdKtrdBFcS1dFatL886Yu40oaix9Ae9fbp8qq+B
	Mwhzaefj7rTNNKAUB7/mKA1F98w2uJBeBmdK19RyNrd/ooPomgqdtOTt4fNUmomEVQE=
X-Received: by 2002:ac8:5a86:0:b0:536:6ffc:70e7 with SMTP id d75a77b69052e-556c0016874mr95970841cf.15.1794495422793;
        Thu, 12 Nov 2026 06:57:02 -0800 (PST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550c21e1fbsm75132251cf.27.2026.11.12.06.57.02
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:57:02 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91f0b9f0b1cso14446866d6.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:57:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFwuxJSq/DStHGDAiltvVcMRmL3i6Ck29Gfb4yk3N6hvvFLr1JN8ZX89adGfY+R7LV4Ptc2CURHFg==@vger.kernel.org
X-Received: by 2002:a05:6102:2925:b0:7d0:5688:f511 with SMTP id
 ada2fe7eead31-7d4fb2b4baemr1940643137.16.1794495026588; Thu, 12 Nov 2026
 06:50:26 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
 <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-4-1b2072e8c37e@ideasonboard.com>
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-4-1b2072e8c37e@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 15:50:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWw2O1k44Rn03VOFJ_0RJAFZro-bzmzP2gSD+Hc8UbPaA@mail.gmail.com>
X-Gm-Features: AclHuK8sy96nMijWIpulMeqo_3YMpISU_WECBzNl3ZKvutsCseDDYG3iuq5rfEs
Message-ID: <CAMuHMdWw2O1k44Rn03VOFJ_0RJAFZro-bzmzP2gSD+Hc8UbPaA@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] arm64: renesas: r8a78000: Add VSP[BI] nodes
To: Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

On Mon, 9 Nov 2026 at 14:35, Paul Elder
<paul.elder+renesas@ideasonboard.com> wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Add DT nodes for the VSPB and VSPI IP cores in the R-Car X5H SoC.
>
> Use the SGD1 clock as it is likely to be the clock used for data flow.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Tested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
> @@ -1646,6 +1646,105 @@ fcpvb4: fcp@c503c000 {
>                         resets = <&mdlc_vio 0x106>;
>                 };
>
> +               vspi0: vsp@c5080000 {

> +               vspb0: vsp@c50c0000 {

Do you want to sort the VSPs within the VSP group by unit address, or by
label? This matters especially when also considering the next patch...

For the contents of the nodes (except for the renesas,fcp properties,
as I couldn't find the VSP<->FCP links in the documentation):
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
