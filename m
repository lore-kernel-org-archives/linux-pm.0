Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D0343BDB7
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976489; cv=none; b=kO9bpbIWUG26fU/w1wM1rdKuOIdYWdk6zrvhcs4GqhfmvU56/5FkdB6LvmVsJxtTeqzqm9KnPvE3XTrts9IuZ6cwBkpXoXosSAkKa4CcMfomXRnXkMPawPmv5afCYRn07Tt0Moy3rCpepiCt3amnPfA5/UH+qs38ZIR88hAJExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976489; c=relaxed/simple;
	bh=nRr2NwONb5MDiY74TwbEFnamWl7CEbEpARCJXKG89CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIuRPl6mDisgBetTL57ihQ5l7UCAt2u2UKVMl8ioUYdUEOoT+8P+uYxrlOvqNB2fytrQp8IbRkXXdrHMjQHN+EXA+9C8LCuTv4fgqbdbpefxe2+i1wLnb7/QbxCAn1zK+xhY3RoH/QRpUnwH2jtd0JAf1NTA9CZczRdOu6cYDb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e96a8ba8cso1714368241.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 00:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976487; x=1790581287;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FDUPsKvRHny4pMpTXrqtNbtll59mp87r5rbb0L/oblw=;
        b=KGT49oqr7cC3nSLIQ1ZmEIqppMetP44kQG9rMQzAU3Qo8PdTI1lhVmUVRmZKdnPbfg
         7q2Db2CwMlKbUVqjqPAvH25T+tDD9/W61oOSz/g/tRuHVG3BlY1g226QDxgAXfvqoUwA
         IDV37KKPq0Pu6BhdbDTIpBGZa4vNe+xP8qUNyjzuSi1HtpHDuAaxqYWLwMA2pAQlfjwd
         7+THbaFUiwjJC3Z7s7TBpVcXCbj3+7AVCt7gvlm2DheEz5nhDHNlFNeUrffjdSLyAJ1J
         cMZ1Ne8rqx0c45wTXShE5Qvc9b056a1525GiBw3eVqFuSlWoESMskg9mE2aL2mdXYD9D
         3zKw==
X-Forwarded-Encrypted: i=1; AKwUvBy4dsMbHEucdZViSgoSNT1p59DuAEFECJUi8K3aOWUuhvA6kBTmJ4211nszajrtu0l/l3FqmHPapw==@vger.kernel.org
X-Gm-Message-State: AFuF++mIWMmuk0ARAkKXrBOlm0TeOcfn0B0mrCLIEPIeQQRsASEEfhw+
	W/rL9dlACOsJSW9d3W3PWXv8tE0HBL7gnpyZwgQ81G+AGrweGoaOO2zwhctIJ1N1
X-Gm-Gg: AYBFou3Kz79lvXGJs1wzY8h9vOUTyfpnYtyLByXADhSEEkixf/XTSoCmIkUXpFLQ0TI
	243pzs90IbeQ5iiJeq/nSYnztgypuIm8yn7cA/swg8VqUKHixkI1oKPDgXa+FoLPcRp80fxcfHy
	/b5UmWd9j5J18eDLAhYn4U4akqcW/+v9+CatCDxVm8DxdX4PoNjn7QD3P4XyyZnEHIjg3mm+j08
	lbZw1nOwHuBsV9Q2cYDumY1xzcxzeTiYRi48RZQtTIrL1NyNwhSGBmmOUYZ4bmhmRr0U7nWVEO7
	eGdPnSOwSAB2vJHJ0kPcry0Cisp+kOX2Gz0Om5pJ5Ab3r2zo4UtG+b+Psv7Qr74TiV8fQfu86sA
	GFh/9AsfWPiRIsUPTbfN/nvK8VHFIciB0fU4drMIGdSK9sMwrvLpuWc+nsWi8+iqLzY4ZYN2P7K
	pwjEPTFWtt21S+58EDeRcG4KQV6xDWCE18OReB5WNAbXQLajIj6oOzgY1KMf3HoPLpqyO1OgY35
	hRX9ySh+jqIdZjL63EoXBN8I1EIngkQYn3New==
X-Received: by 2002:a05:6102:e0e:b0:7a6:ef60:dac with SMTP id ada2fe7eead31-7a6ef6011abmr2042869137.34.1789976486606;
        Mon, 21 Sep 2026 00:41:26 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a6acafe715sm7329452137.11.2026.09.21.00.41.23
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 00:41:24 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e96a8ba8cso1714335241.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 00:41:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxVwtR6r4bhJB9iMsxf6FZvpJZkIIzHtGovxyqdxk/jsAorvCpZ0/ntJUWvI4lfFQYmM9Qvj48wzQ==@vger.kernel.org
X-Received: by 2002:a05:6102:83d5:b0:7aa:17ba:3dfa with SMTP id
 ada2fe7eead31-7aa17ba42bbmr32910137.31.1789976483444; Mon, 21 Sep 2026
 00:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
In-Reply-To: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Sep 2026 09:41:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVC2vNp2nTHUi3saTZ8UD4ggeB_aBEvN9XP+EToOr7G2w@mail.gmail.com>
X-Gm-Features: AcwNN1UjZbDPnIaj-fYRvcBoX7YE3K7C7k2z9bWrLFQVkND6DSGXX-e-oumCCsA
Message-ID: <CAMuHMdVC2vNp2nTHUi3saTZ8UD4ggeB_aBEvN9XP+EToOr7G2w@mail.gmail.com>
Subject: Re: [PATCH DNI v2 00/11] media: rcar-fcp, vsp1: Enable on R-Car X5H
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

On Fri, 18 Sept 2026 at 19:07, Paul Elder
<paul.elder+renesas@ideasonboard.com> wrote:
> This series is based on Geert's
> "topic/rcar-x5h-ironhide-scmi-cpg-mdlc-remapping-v3" branch [0]. A
> branch including this series is available here [1].
>
> This series enables the FCPV{B,I,D} and the VSP{B,I,D} blocks on the Renesas
> R-Car X5H SoC.
>
> This has been tested on an Ironhide with the vsp-tests test suite [2].
> VSPI:
> 145 tests: 138 passed, 0 failed, 7 skipped
> VSPB:
> 115 tests: 104 passed, 0 failed, 11 skipped
> VSPD (a):
> 114 tests: 99 passed, 0 failed, 15 skipped
>
> VSPD (b) hangs on the tests, so that needs some investigation.
>
> The first couple patches add clocks that are used by the FCP and VSP,
> but as the upstream X5H CPG driver is barebones at the moment and we
> don't yet ensure that the parents are enabled, these are marked as DNI
> for the moment.

The DTS patches use DNI definitions of clocks, so they should be DNI, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
