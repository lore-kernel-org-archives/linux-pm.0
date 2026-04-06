Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ACE1A073F
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775449926; cv=none; b=BQMS36zrQjNQMlPwD4fiwilxp53YsgQQOjj8ZhQYbgk9rb3J0STlrIcnc9q8aKavIgwfQwyyb393Un+EmjAkpGG6enKaVtbLdV4hn09TD/dOxymZddWIzHCKUglPlR4T9BCuAie02SLp1azkNCvhlCmqCEQ6k8n0QfYiz2dCAes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775449926; c=relaxed/simple;
	bh=ijE5vpUK5+igSOqrz67VaC6/x4PJRM+GtLEgUGPjiJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dmrg8wYoEfRBVrMZQAMPnqEFMzmYQ3TVlsc/rrmNsEZq78bbWRGfz652eddBuhFEcWUTuf01qlM47FUfOH7ufllfOEHnjxOXErTwyBkS5Cl886E0fiiaIWZWbs7Mco5TqNol37R/M9BYgiWLiLq0DOZpgudVkgHyc5TBAXICCmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pqV1b5MM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqV1b5MM"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-356337f058aso1821972a91.2
        for <linux-pm@vger.kernel.org>; Sun, 05 Apr 2026 21:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775449924; x=1776054724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JLYhjqwYg6+Oumvs24wNUE9ZRMF9mduP8nacbJE4PGE=;
        b=pqV1b5MMj7JaQQ4mR4FG6rXpaC2FY0XJr4/D6/elHbWW9hh9gY1J/W9mskJaFmsWqB
         dtMQ3RE6RlpkKSLqST97uUWEsKpRFpKurPaj1TmIcv4ZfZ3irG9OTqlHkt9WS8JcUKPp
         CXBIpYi0VIQvdM6Z8v5Mvdqm7XEBfxHl9cs4AurFdcKCCy7TN0zD5jpUTsM6usPtzaLc
         pnFS9AWJpGls5AYbrPojC3ULIrUeJAbBCP+6c41tREdHFhsJ4FMVw2XLSp3I8XBGRjhU
         N1UU7DBZ6nQeXH9UTeRLwo81Pm0XvfYPbVYWRwHZoTyzhizwtus9qtQqlWwkl/Z29jnU
         aT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775449924; x=1776054724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLYhjqwYg6+Oumvs24wNUE9ZRMF9mduP8nacbJE4PGE=;
        b=sTersF0ThUZPXvjibGraqTgkhYhhFSY5hOnWUmSnuOct6AUixWLfv81S5BIKjt0MfL
         GiJip1z18Ml4H9WfArq2ltsqhoCIlcRyEIAdtpRlutUECSTV3IVIhOWa7myKEEeKA+mY
         h0LxeegFAzuOx6R7SZ6guSDtZ6hmmd0/J6aV1tYN9FFQ4FPX5NULraoFTYMgqNEArqzR
         I+51U4tSuH2PXEniL9YH+Vw9fqc1C0jo7bXy3smvmXsUtjVqw4CDFcq/R8+QRyTg1hpz
         7dapzL6OUBGKsgMjHjBis+47MgJcob/eqeSMvjHUraDEB1vpdDlipUyk26eBjCGNv3dM
         EIxw==
X-Forwarded-Encrypted: i=1; AJvYcCUxk8B7RIiGEYqtwUdQZHOxeEfxTvS3CcNyqjFHeo/oLvfc0BRbq6M8GT3J+NS8XBjf/+PGqYT5cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwADhQtDgeHBKJynqayDX+q/PgLObqZ+FXpEwA4Ndh3PQbiCF8
	AFb2Gg2+T5sQkbin7lVZw9uAMHF4QxeDDY0pl2CC9HLa0L5k6DqlKy+KQJhiFI4pHuM=
X-Gm-Gg: AeBDieu4LcgKzcF/ANdhG6g4FaEj09W0a2vLyHqkT4fmuerTlf+onLyjtDLI6iUhY6N
	/+5xeQRvxvlM3r3NoGyy4a9Tbqy1KEFe1xVBen+QtW4G1FSKNXKXdwhBfZxTcCREWcDWFpTiZl+
	K6PQyhfBsB71EMVdHG6n2QU++j4P9MUdfsSrey3BSWbldCeVJFx6irU3cpdbBsAQn7xnl1gaQHx
	geA0Hn6iMuhDrrJ8D9yakMEypb7WU5DwChD7rSFyjNDXFOeJduee9kvBqskWyku0mdXCdtH4J49
	gqOQUWrFCc+KTuvwgRlhSjgAr1/oUgKiEmZ2HrpPv11IKerr5kHIKSIe+sMJKZsNceYanT29aI8
	ujoOmpqfIZPSaD7NB/LUyQhYgIrMf4XUPThLiSzTz8tPungd95j5xxm3GcBHVd2Ii6qFpDvjtbx
	9AMgBYBn9S7yqpNykxcWnYBlaQ
X-Received: by 2002:a17:90b:314e:b0:35b:e551:90d2 with SMTP id 98e67ed59e1d1-35de69b28c7mr10531343a91.28.1775449924093;
        Sun, 05 Apr 2026 21:32:04 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd36a0595sm12824309a91.16.2026.04.05.21.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 21:32:03 -0700 (PDT)
Date: Mon, 6 Apr 2026 10:02:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: opp-v2: Fix example 3 CPU reg value
Message-ID: <o6y25iupbgyc3iyyxzqtvnce7ll6f567d3db2i2nf3y2uijhcu@2gy63kdu3ngs>
References: <20260403-dt-bindings-opp-v2-hex-cpu-reg-v1-1-38a4968ab515@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-dt-bindings-opp-v2-hex-cpu-reg-v1-1-38a4968ab515@iscas.ac.cn>

On 03-04-26, 18:34, Vivian Wang wrote:
> Example 3 is a dual-cluster example, meaning that the CPU nodes should
> have reg values 0x0, 0x1, 0x100, 0x101. The example incorrectly uses
> decimal 0, 1, 100, 101 instead, which seems unintended. Use the correct
> hexadecimal values.
> 
> Even though the value doesn't change for the first two CPUs, 0 and 1 in
> example 3 are changed to 0x0 and 0x1 respectively for consistency. Other
> examples all have reg less than 10, so they have not been changed.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
> Found while trying to figure out if cpu@* unit addresses are supposed to
> be decimal or hexadecimal. This is AFAICT the only place in-tree where
> an arm/arm64 DTS uses multi-digit decimal. See also:
> 
> - https://lore.kernel.org/devicetree-spec/00ddad5a-02f5-474e-af9c-11ce7716ddfc@iscas.ac.cn/
> - https://github.com/devicetree-org/devicetree-specification/issues/86
> ---
>  Documentation/devicetree/bindings/opp/opp-v2.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2.yaml b/Documentation/devicetree/bindings/opp/opp-v2.yaml
> index 6972d76233aa..10000a758572 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2.yaml
> @@ -172,7 +172,7 @@ examples:
>          cpu@0 {
>              compatible = "arm,cortex-a7";
>              device_type = "cpu";
> -            reg = <0>;
> +            reg = <0x0>;
>              next-level-cache = <&L2>;
>              clocks = <&clk_controller 0>;
>              clock-names = "cpu";
> @@ -183,7 +183,7 @@ examples:
>          cpu@1 {
>              compatible = "arm,cortex-a7";
>              device_type = "cpu";
> -            reg = <1>;
> +            reg = <0x1>;
>              next-level-cache = <&L2>;
>              clocks = <&clk_controller 0>;
>              clock-names = "cpu";
> @@ -194,7 +194,7 @@ examples:
>          cpu@100 {
>              compatible = "arm,cortex-a15";
>              device_type = "cpu";
> -            reg = <100>;
> +            reg = <0x100>;
>              next-level-cache = <&L2>;
>              clocks = <&clk_controller 1>;
>              clock-names = "cpu";
> @@ -205,7 +205,7 @@ examples:
>          cpu@101 {
>              compatible = "arm,cortex-a15";
>              device_type = "cpu";
> -            reg = <101>;
> +            reg = <0x101>;
>              next-level-cache = <&L2>;
>              clocks = <&clk_controller 1>;
>              clock-names = "cpu";

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
