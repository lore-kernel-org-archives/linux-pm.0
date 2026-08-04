Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0C42AFA5
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829797; cv=pass; b=dtX6e0qNcIWw9rychXwN1H/EE/uAAOiizWxpDL2XfuRQIPyEMIf6JQ7VQnU2B+XeMla51YDFGftnsBu2+3Z518utDsMgYyQR7cZAWYse/73UZg2OGb3X7iwH3C0vSpmOLYvHWAA5DAO7E1T7lcdKrfuGKzbBDderus23m/DX1nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829797; c=relaxed/simple;
	bh=OmWlM/JGJt4Vhs83DOiTTiO0UFaa1QDbwgGwrj5GUKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLNFUUVcDWG8NMF19maLfe5CgSuJI/54QMGGa9CXmfmR7gz9mCdYfe14R2fuo02Ee70OC0Hkvv6DOt/TiCiggKuvZLNJQEh+VSpepgG9/tRVcRqYRCQhWDGI8At5fAuDagRIUl/bEcMmdluWROB/5R20/fqaNkXs8sK471GKv8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwLAupQr; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwLAupQr"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1712a04ddaso684911166b.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 00:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785829794; cv=none;
        d=google.com; s=arc-20260327;
        b=f/kFtKvcokHzS4UdRNB3Ub82sSQLb9B2+1b8VQVs7JoJAl1J5zV63hEhpNLdRgIhTA
         x5Z2lE9ugkgZN6bzf6JqQfDQuK5zPSxJ1MUJTanthbUI6w+NfmRQO6dOohUqNGo/gCgw
         huDg3gv0B+h8vKNSP17H9UCAnsBTVcI5MNkwUIvbRE9CZRyN0iNTGssZ2wMOei3XREay
         g4DoPnGwwZvKrEq0ZufwlpzU94AhgVUwYKFBzQHtZi5bhq7PjiqBrcOAoz5kGzKVmEik
         qMp2yvPK4hlFULMhEmicAZsEFkyFQ7gnDExTe7OVfxIOhnTUz1FmxoyojtdvkLcDW8vy
         Gkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tIHHVDdHYzYzDyqpm0ApPfqei6BlC/PdRs4c7TbsR9E=;
        fh=kNfTU6muu/DVIZ9JtYTVl7N79krcMlEipseBxeDkIM8=;
        b=dGq6ZJ4BCnjdMl2wMpcU3PgXrjxWqU1fg+mvf0O9qukF28cUOGLpC8idmJyT4vk+1W
         P9/xwsNHEV6V/kG0GbMCdoMZ1V+/k5F0mSaRj7C0dUEIb4/Dc4koTGUIEUvskeCV25IF
         p8PoPD7T9nKk2cT1FYvfEgTECPvO8CfVITBsdkrWgEl6vd5VKl8lk8PxB8FA8C3Vt4LS
         JF9eBa+WFBMqcUTvkCi4gmmHJW9K1lGAbO/lyas1QiYMQ4kRG7T0uGYJKmr+MoA3iV5E
         zYqaPJzsjkJzRJ4RPd/1z/Pnr3J32VLOvnsjc7A/TQJfKn1BmF+nREsQTCUeXBCrC4Ja
         kcTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785829794; x=1786434594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tIHHVDdHYzYzDyqpm0ApPfqei6BlC/PdRs4c7TbsR9E=;
        b=MwLAupQriseS1XOL3IA0aaUvCW567en3TxkDW0y3zmZOgTMwMVUT8aEKbeagJyMhDA
         QbVZswQVN4acBX0uUHGkMXbyEaz19SBCK3HzDszbmxLakDi7jLU7Fo0u55pZFXR0+WJ8
         Xa7kBh5XSqFG64eP3y8Y2wLu/4QEGImzV2m2ODaNoq5dhWQrmC0smD4MSrMyM4h4oYUS
         cJ7ksMoszTcP2Hf5lYw5xYMwx0HhcNBmBkF0rOvkR+rN3DTe8Ven0bv4wVS7iSR7/viS
         4y1Kl1mwuS66GyPhaxaRDduhxcA23yAtB9hMpXb1azeyN6Za7r4zmvSJfMfn/iruTwnk
         dfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785829794; x=1786434594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tIHHVDdHYzYzDyqpm0ApPfqei6BlC/PdRs4c7TbsR9E=;
        b=pJopGWMafKHDmRr907wju5KgTFSEZaL6Orj8KyWxbA3HFO/RO9OzZDd8XqKVjJ6kPF
         5eH9s/KO6uHtSLZTxc35aXOjWHPfEDg+GwUaK5pdgoyna7OY6zIKSprmjy5vCekK4q9h
         /PHmTQDJ3fYNcqpKmhecU+viB+/2VKoXYvp78i9CHT+HbnlEqDtIcGFD5wVRYiyr4M+6
         g1lZmPnGLES/e74mychYEiBkqrYE+hDYAB+3DD9xf/cFmZ+ZqWR3xigPg0/Dd4CyiqHi
         huPrKaIY+rFEZIhH+LjraEfTYpKKc28fiXFc1d9ydWLaGGaZrAIENdDmwBX3yoadX7r6
         fYMw==
X-Forwarded-Encrypted: i=1; AHgh+RrQxSZMPaoOvv4v5HFw6fhIktxcWPM5/9owAA6ycThhBeKmX4UOUMGAwlrOr00Nfuh64nkr0THuSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/kYkg58v0yHH9QHpF9mkfeQ2yNQmgyp8SreUUK1bvyJmfOqqi
	habtDyJj2b9fbKkd1mXHPNIdXGiqwOEYBRm8Vty86z3YgDHPGmWbaNojqiHXWkWDwG6sJVSk9k5
	rpOLk6NUytyRH7zZSSClMaRC8PsJht+c=
X-Gm-Gg: AR+sD12CxvDJpC5nBpCes0XDDWsV9LyAqGgT40ymhXpoEIFmrRlB6ttz0aW/cjVAJdE
	P0wsw7rCnG1TGcc8/rRsQJsgbu7BhSf1q5CfNDk/BEYU1Lftz62fDwb1unGtdKTNGs4Rx5HHPcr
	eZEyNwldKyAPJssBh2PbM2cEH9rjgVkSD7DdCx3/MUrznmcrHw7Lne9IxSy/Au+pJJ98ygGZfll
	7iMhSQUKHJxFuaqSQB5hcKBaS2YtPMGrJfDC+hltOYsV7xrGJJuxLWXrnqmNxYdAxRFZ8Tly1RR
	JBOZXP55dyZ51WmwVV/8Oh0ADwbKRTvqcFz8Vc0teBaY644=
X-Received: by 2002:a17:907:3c83:b0:c1c:257e:4888 with SMTP id
 a640c23a62f3a-c1fe80d7742mr1126518766b.27.1785829793494; Tue, 04 Aug 2026
 00:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785480242.git.zhoubinbin@loongson.cn> <0fbb8d766b6ed33bf4ae9b066eac174f55ae5b56.1785480242.git.zhoubinbin@loongson.cn>
 <20260804-intelligent-kickass-squid-e4c4c0@quoll>
In-Reply-To: <20260804-intelligent-kickass-squid-e4c4c0@quoll>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 4 Aug 2026 15:49:40 +0800
X-Gm-Features: AUfX_mx5oxerXvL0N18GQL0cgfDF9LTPcv7Pk-z3jk4krWgDnaxFa1jCKZmpg4c
Message-ID: <CAMpQs4J+RSF+rk1RJW-4+mbaeWpAzMKeiZo1R=B-wfXnAM5ScA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: mfd: syscon: Allow syscon compatible
 for Loongson-2K0300 chip id
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, zhanghongchen <zhanghongchen@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, mfd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof:

On Tue, Aug 4, 2026 at 2:57=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Fri, Jul 31, 2026 at 05:42:19PM +0800, Binbin Zhou wrote:
> > The Loongson-2K0300 SoC exposes its chip ID registers through a syscon
> > interface. Add the specific compatible `loongson,ls2k0300-chipid-syscon=
`
> > to the allowed list of syscon bindings so that it can be referenced fro=
m
> > the thermal node via a phandle.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Docume=
ntation/devicetree/bindings/mfd/syscon.yaml
> > index e22867088063..18eb9defec8c 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > @@ -76,6 +76,7 @@ select:
>
> There is no such select in the code.

Yes, I see, I will rebase on the linux-mfd/for-mfd-next branch.
>
> Best regards,
> Krzysztof
>

--=20
Thanks.
Binbin
