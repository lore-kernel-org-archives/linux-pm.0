Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A562037DAC2;
	Sun, 31 May 2026 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780214411; cv=none; b=nvZnBV/ccCaJ8zsLotdAuB1JcR6yqEjVDkLA+z72z3Um1VrOCPyYYkgqYSMevqbK2j2xlpy8jbme2zjuwtxLOSjUPtvVJNy18XXsiq7avMEknjkN9AU/md7LZg5e88q5L1u/g5G8+ChuU1TBQVqENMh7garcY8Os3r7p6LWXvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780214411; c=relaxed/simple;
	bh=Szqy1th6BzYAnvuD26CP6FwBQA/ol1Nfkqz6XFfFTEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tSTd7oUtJUiZVnR+9Es5JAkOVzPP7zl3wnr1vcN6gZHYJQRCS5CEMOcpEjEUBdqXJe0HzZyrVqSyywGlYMDIy+MNMOK/F2DxlCxysR/6WtQj4RMWRjZcTQOYTgk3+DpwVwlRlrs+nWaqAMmV2VvYaWvHT3uwTD/ZPcINPXwHOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLU+aldR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLU+aldR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E0F1F00893;
	Sun, 31 May 2026 08:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780214405;
	bh=+otYGzi2Qx/cj2kcnFOi5nON3ElEbbiJVMo32AZgZq0=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=PLU+aldRr11gAYrsbnAC8mrSW2cWlun9aNZ3DZ8wAE54oWc+dV95qLKQz2+3zIbYF
	 eJSEc3KGgrm3hf/k3aAXc7cJwRbTnaAZS8020YtVFXPsd4z/bNeoB0yt4EJKuQfY7R
	 mkFnm+U0FNLnnjAm8OHGhuBN9ggkbJGgx5/r4I7yloaJvoGXp7XuavRz6Xh7fyz17d
	 QapmJeaF8TUVFpHSFkgIyE54ZiWYUz3gBJgrYV5baOhyaz9RoVa3QnLFlb1yys2JjF
	 xwRmhTnmJSBlxtTwsuhs9t5AjJ3Vq0C2bzUTd22EBTQ6AIb50Db1gR7kEQ7S644JIs
	 xmyETQdFgrQyQ==
Message-ID: <9b2d493a-d63c-460d-8c9e-3abc6174ecbb@kernel.org>
Date: Sun, 31 May 2026 10:00:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: qcom: add msm8660
 fabric IDs
To: Herman van Hazendonk <github.com@herrie.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Georgi Djakov <djakov@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <cover.1780148149.git.github.com@herrie.org>
 <cover.1780197411.git.github.com@herrie.org>
 <b8f81a5eaece97304ca78aaa54a118cfe496d064.1780197411.git.github.com@herrie.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <b8f81a5eaece97304ca78aaa54a118cfe496d064.1780197411.git.github.com@herrie.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/05/2026 06:09, Herman van Hazendonk wrote:
> Add the dt-binding interconnect master/slave ID header for the
> MSM8x60 family (MSM8260/MSM8660/APQ8060) fabric mesh. The chip's
> NoC fabric is split into multiple sub-fabrics that the qnoc-msm8660
> driver models:
> 
>   AFAB  - Applications fabric (Scorpion CPU + L2)
>   SFAB  - System fabric (DMA, SPS, security)
>   MMFAB - Multimedia fabric (MDP, GPU, camera, video, rotator)
>   DFAB  - Daytona fabric (SDC, ADM master/slave)
>   SFPB  - System Fast Peripheral Bridge (RPM, MPM, PMIC SSBI)
>   CFPB  - CPU Subsystem Fast Peripheral Bus (GSBI UART/QUP, USB FS,
>           TSIF, TSSC, PDM, PRNG)
> 
> IDs derived from the legacy webOS msm_bus_board_8660.c master/slave
> enums, normalised to the upstream interconnect-framework naming.
> 
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>

And why interconnects are part of thermal...

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830


Best regards,
Krzysztof
