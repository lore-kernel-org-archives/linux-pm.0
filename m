Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2647A0DE
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154108; cv=none; b=TDZvRV89DelUDKJ69UIgeDI/NMQ43UjmzeepnZJt8oT0ZmaDjBu3k1NPTdv9XvKSD0+vKJ5grcFfCRT8GlzqxZjg2xwm7vroTxumjsEIO2KAiYV5utKzHQ1i6zBluvqS5G7Bj3Y6hPAr/6RP68S9rmoazjMlgwoQOjsLkjDBjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154108; c=relaxed/simple;
	bh=KJMaIRd1Wz2StYLkzuTGe2FFJE4FwOZc/zYJMMrt/Cg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7ZrVj1pal+Y54MjRCbFNWA7cGViW7Tzq0KYcsrVkZw9FZDnaaWo/HQamCa/rAsZV4HHtUv7y2N88mH+cXFIFiND2ia46oDBM5ESd+jMywJgFGe338eRhMSSt8LpjLL581ASK82LA/IiD96wKww3ezDNlMXbWZFq99PWVWCjGlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khFz+gPo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khFz+gPo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF951F000C8
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 12:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792154107;
	bh=KJMaIRd1Wz2StYLkzuTGe2FFJE4FwOZc/zYJMMrt/Cg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=khFz+gPo7qCZeP2kVfoZGuMuZGpw6va2P1I/L3YDadrvQTzK64qbzTirgQ8v4FO8h
	 Rou4tXogblJ8kah1yu/duaC1ms5M48Ywla4inUFo8iYi52ehE5G0hiXaJc75Q/D430
	 77/8vR1XK4GSqt0PdlqJ3I8ExMLuYJ6rhoNWdAwRhRF7BUkbqL7rgxwe1KGaiomQYK
	 AFu8A6C9VTJCGJWgQJnLQDN265hu9sxxH6ARuuaMVp9JG3LONjhZL1c88nhOcD10Xo
	 MgzpTEp/UYYYzRjv54oyMGwFPw8T+74r0ivw9NYXS9S30/MU8kAcVC2zb3WlD0Ic85
	 b2A+V05R+kxmw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ab01c46697so13031321fa.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 05:35:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzV7VSFc8q99le13Vyts4YuR4KBmERfOB58DT0ysN8MBa2bk9XWGKbHFgDOVbPHWEQ5FkmRxcDnjA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIWzcL/iAjXIIAgszYc3Qz/7NLGdDLiCF1mIs3B6MBxQ15IdKac
	C6ks+naQUrMpj7mnjutvBi1Uu2TjZgq4aLCnEtWii9Od0wI6PCrRSU+ajERcv0Ph3fuaggY57rb
	HbluzuyQIRb2G2TRZmDL8j/jFA/f5Xc5MJ847aSbN3w==
X-Received: by 2002:a05:651c:19a7:b0:3a6:6f3d:c804 with SMTP id
 38308e7fff4ca-3a9c538bfacmr55474691fa.19.1792154105792; Fri, 16 Oct 2026
 05:35:05 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 08:35:03 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 08:35:03 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261014121910.1509541-2-linghui.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com> <20261014121910.1509541-2-linghui.wu@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 08:35:03 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mf5fw0+J8uyPgO6j_ooEnB06DoXVRDkpk+JiwcPw2uCFg@mail.gmail.com>
X-Gm-Features: AclHuK-OTs0buPx-1r5yVX8Ujv5PkAKBIfDAdTiHHnUDkJSI6OM5b9nTO6kfpkY
Message-ID: <CAMRc=Mf5fw0+J8uyPgO6j_ooEnB06DoXVRDkpk+JiwcPw2uCFg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: power: sequencing: qcom-wcn:
 document wakeup-source
To: Linghui Wu <linghui.wu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, 
	Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Oct 2026 14:19:08 +0200, Linghui Wu
<linghui.wu@oss.qualcomm.com> said:
> Some WCN3990-family designs connect SW_CTRL to an interrupt capable of
> waking the application processor.
>
> Document the dedicated "wakeup" interrupt and wakeup-source property for
> the WCN PMU node.
>
> Signed-off-by: Linghui Wu <linghui.wu@oss.qualcomm.com>
> ---

The commit subject should say: "dt-bindings: regulator: ...". There's no such
thing as power sequencing as far as DT bindings are concerned.

Bart
