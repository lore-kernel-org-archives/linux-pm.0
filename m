Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ACB3A9635
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952116; cv=pass; b=fSjmQa6PBfqVo5RqO8A3DGyaI0jvbI4SUcpXCN63GEcafPSJjixHUAvoFENXhZjL/pX86AGGdbJerBoARlIG+PQc3haCmp3S8Wr75MyFEoh2d3Qt4z2ExjKOweOPewVV35D0tUHrTRW9By/Iw6Jf793T17hMjStEpfE+FMAWFBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952116; c=relaxed/simple;
	bh=+BfKSKWqlI1AALMWRDnBgfbKxVWZIsKfVTDoY9LW9As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQ1kYfqXQHEm+0Hx8xgojK55Vr2dEaShWtdL6U4fJtAR3tOuA8gOCUElWGVUa5gujC+FtfZ8sMMuH0r7yCHumJV7MnNaVzc85mWjOocekfDQgzuzCHdIFo6WyJHJ/+km4jZJ984VIrayutbVUVpkaOyQI+H+1J32oGxK06Chypo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e5BZFsRn; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e5BZFsRn"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a2a70bb66aso5467998e87.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 03:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774952113; cv=none;
        d=google.com; s=arc-20240605;
        b=cY+boXWksbLSXstpTOxzAmcv+6mj29uV276TXgvPsHqeCqmgZFbbZQrsZLYTH40hCQ
         2eJ7LDEUpj88Ag6gEcTDYp+esRdrfILIREH4XLT/Of3NhIfbhaizzlhY+loMdPUYzbQO
         pvP24fO3E9U3k61TPO/BER8LOMT5kqcUJAJ9t18+f8re1nP8jP6sKT1CmNDjzRz0YC/T
         vLpmmedVtHv8VDgbIdTlM0OKzzRHiu5xm3NdRp3SE1a7LZ0SkTfhiAZ6WdtvuluvLIxP
         Jm/9BjqgLs1jA3tXQLZuwqHSuZsQ6FdDdz70rokuG2aD7apKbo2DcPTm/RVAG7VFlE42
         PLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IwM4Dg0oPoF1Vd4vmJzcbvBl/vV3R15yI0dEAidybMw=;
        fh=Z/a4Cwox1j/Jtzqo0FmHt4u/8G57PbNWB8yChLZGJBk=;
        b=BvELNCgNYwvM/8eazdCbzOBodQ2mHDPv2P2Po7tTGL8w1J1JqPq7m0uK6wV84fXSj6
         IUyguN7MY8m3gLyM4Fuy91U5yCVFbxDMz6KT7x5Wt7pKjMyFjxrMeqJ4NSAIOUzjIRtt
         d1G/A3wJ93lYckbYvk+wtRnM4vYJVgsTljkVCjL2c6wcZiKAmBqFIIdYY4PxodfEa0/N
         EO5HlWRZGk/r5pOxZQr4QQtsERMNUTXI6gYUmQMe9Jg1Ifm7x0IDo4v36r3GW1Pw/t//
         PjL7efmG3P+3OV8xCn4h8MIAukwql1dReL5krKfXVaKONyQE2pd/EIWgX11KHlbu2miY
         mk9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774952113; x=1775556913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwM4Dg0oPoF1Vd4vmJzcbvBl/vV3R15yI0dEAidybMw=;
        b=e5BZFsRn/cfpSycQzHhx6SgKcDUhEghskKFh5tjggHr+u1Q5FSqdzgqusYEcSCjvQ4
         exY5t/ZwDAOFgB1YJN5OD0uSazh0rbi1aaNP/EzL2I5FVQPPaHYlBt+YICa2lHtBJrzo
         sufMri1ejYJf8oRnZWnESOlRSYZcHIZ8UGZrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774952113; x=1775556913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IwM4Dg0oPoF1Vd4vmJzcbvBl/vV3R15yI0dEAidybMw=;
        b=U35Zgj+FnQx9biXjKRhN3T3WriIR4QC8UcaN6wtWcByCdvbeDXNMOLjkhQ/PT5m9xv
         9+JJ+EGxrjoCDnsiDpeE67IxBGsD0ISCKjaDnO7zTZyWdOEoksinZmwjJAHbqSo4WJTF
         Aziy9mkSBdRYGkddmdkflJQ8RtRRpj8fyEilgU1r/nvkDbD96hGJzIOG4DB7iUFP2N3F
         iSPpuRZupaxhPPMi/9MVkyjHL/JF5O09uBg02KDOBYmcaDoR8HRPHbHwAENpv6PxWfQY
         jSVavQuNezqmE8tR3VR1RFzSUgXrFRhUBUp58c1tx71BA6bF4n6/rsc+j47HtMwVhijb
         TjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1sG2jkx4ksB3JjJBY7H+JAFjaQ1nBnEYW2bRn2COqfQ/KbsXUglZHYQshKKZTm/IXMI9mF7JwHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HnJLyfC276RlCvFJ+J0mK8+uxFasaUYK/aRs7PEtbjw6YPpI
	Yvb898g0epT93KYoSjB8q8JRGKLCqmDhBEKLyQAyTG7lhcGGqYV9OwZ+WR2TP6bJOumsOL2MVYt
	H5C1/SUWxG31JeaQXsbottBkWaB5I+t8hKzxD1zoY
X-Gm-Gg: ATEYQzyyUe/Mk/JzRMq6wJvknwNFZLNLrEA4uCKRH/W556/Eau4K0Ha8hiILRSX9EVl
	mSfDjDF+sNxuQGJcxmqLsUYmvBV3Qr1DkEckjUFak5T53YdeqiosiQA22xz4r+MiSgE6rAh25Xg
	l+omkFXwekVtocxUdZC9dXHbA1lMkyGX0I9GfrEJkl0tbpooYXc16cZm3HNtYjGurz9SENZxWH5
	0pYJL2+o8VKYN8pnW22wJent2Wuyhg/rYGsgVc/0gZUaaeCbJZcyz52CDaldjoo3tK0iwWxLCO4
	apKV0Xol1sQOsOwMDLqpIA6PNiuFMtEXnsHLuw==
X-Received: by 2002:a05:6512:10d1:b0:5a2:a5f6:dfce with SMTP id
 2adb3069b0e04-5a2ab7ea285mr5687077e87.11.1774952111900; Tue, 31 Mar 2026
 03:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330083429.359819-1-l.scorcia@gmail.com> <20260330083429.359819-2-l.scorcia@gmail.com>
 <20260331-flawless-bronze-lorikeet-59a6ff@quoll> <CAORyz2+1bc9Z-opoNqyUU_WFzyXZKGQmR_Ur=4UonOC=AWtQ8w@mail.gmail.com>
In-Reply-To: <CAORyz2+1bc9Z-opoNqyUU_WFzyXZKGQmR_Ur=4UonOC=AWtQ8w@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 31 Mar 2026 18:15:00 +0800
X-Gm-Features: AQROBzCSfOwC7PpxPWsVcV8RwypXUnG7y9-g_GLDlmzGCrhYIDEBqda8qgwR7SE
Message-ID: <CAGXv+5F2nMwftF4JvXLuJr8Oz9VSoB1f1qq9mPcMYegmJ6BP_g@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-mediatek@lists.infradead.org, 
	Fabien Parent <parent.f@gmail.com>, Val Packett <val@packett.cool>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Julien Massot <julien.massot@collabora.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 4:36=E2=80=AFPM Luca Leonardo Scorcia
<l.scorcia@gmail.com> wrote:
>
> > > -    required:
> > > -      - compatible
> >
> > Not really, this affects existing ABI and might make the child schema
> > being applied. Basically regulators node can be anything now.
> >
> > This is definitely not a binding we want. The syntax for parent schema
> > when listing only compatibles is requiring this compatible. You cannot
> > have here whatever empty node.
>
> Hi, it felt quite strange to me too, but that's what I thought you
> meant with your previous suggestion [1].
> To keep the required attribute I would be happy to reintroduce the
> compatible here, in the regulator schema and the pmic dtsi.
>
> Before I do that and resubmit, could you please help me understand
> what you meant before?

I think the point is that compatibles for regulator sub-nodes on MFDs
is no longer accepted.

Instead if you want to have a separate binding for the regulator part,
you would need to reference the binding directly.

Say the binding is at bindings/regulator/mt6392.yaml, in this patch
you would have something after the "additionalProperties: false" like:

allOf:
  - if:
      properties:
        "compatible":
          contains:
            const: mediatek,mt6392
    then:
      properties:
        regulators:
          $ref: /schemas/regulator/mt6392.yaml
    else:
      properties:
        regulators:
          required:
            - compatible

And drop the "required: - compatible" part from the common regulator
node bits of the binding.


ChenYu

> Thank you!
>
> [1] https://lists.infradead.org/pipermail/linux-mediatek/2026-March/10506=
0.html
> --
> Luca Leonardo Scorcia
> l.scorcia@gmail.com
>
