Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2E435511
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385200; cv=none; b=ixPALfsgB+QD1DIs+Ksxjl47wqj9ENBoWPaAt5MOqmeFDkQWBpDHILLjhtDHvXEQ8Z7Nk3/SVBLVUOItYU6Ah08GM9QU4FcKJXePyviH/s2VD7Jq6Xv4A+zBanzaeu56NQZPJLMmICPH9na5eTslmo7uLv+w+p8z0pRCEBi+OwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385200; c=relaxed/simple;
	bh=hgcymRn06CEzZYivG2OYevh3C3pdHTxTa6lD6AY+ufg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iN1wmZHrR4T4Es6kDPohKmEYotDtAWCI3WgHA/Aq6yMbZvXqBIZBjcpkZoWAQEYIWhfjj8PwMAaGUtcZhB6bJbJ9FNLMmKQ9gr/VO45dCclY0D5aDwY3OpjLdJ+T8isZ/wqTbgsWdBnC2Usk5wAzZhydOntoHkqcsObaq/fpDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh5VROtZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh5VROtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C401F00A3F
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 18:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786385199;
	bh=hgcymRn06CEzZYivG2OYevh3C3pdHTxTa6lD6AY+ufg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kh5VROtZSFG4V4setKEx58r+aXrbRhkM81FNJEhyhDuJ/kqBlm2afkySKxEryEAjI
	 kjgF9+Rzmf5899CrwmI6A6BinooXbmJ8xOLd9j5nNWR8EJGqVS7CIYJ65g3JccUAhK
	 YSmjSLQ6tdF2Y+sk8wXbvIY3/urHkouBnvsSMyt8ImL79tDL9CVLuRuUTvRzGEJe4b
	 GVn6NHwdDrRcbH48z1LRvff7doLUQD+emJgzW7U8p93t1gHIChWUJWPOGYztkhp7Qq
	 zPpEsDdJX8prSupqD4Jhu/aXxeLWDPU8oTBtvhBCbxYXte6I3F09YVBQlzRk6BCsFo
	 sHjiQQvHJfAkQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so2735976e87.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 11:06:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq7dJdO+kkbEf8AN6lgZJZObK+Kxrraz/QYWDRc5i/MlCQIVWDduK/yABMvBri8J+yGVY0FyM6sjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6slMseCU7l+7cE5i6vXZUP55uX4yXCtBD4S5e2Fe0dKZB38c
	o33ozrqQYSzUs0+YeWAfzSjk1TNFqi9xHTJ4r7RGt3scbcTkNsJpX6mqB4K8dMfWO37U1oJlZ4R
	6GWKu1valKriOwMrfpvqyLPz7/8IHoCU=
X-Received: by 2002:a05:6512:baa:b0:5b2:f437:2a88 with SMTP id
 2adb3069b0e04-5b2f4cc7be5mr5978880e87.36.1786385197772; Mon, 10 Aug 2026
 11:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
In-Reply-To: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 10 Aug 2026 20:06:24 +0200
X-Gmail-Original-Message-ID: <CAD++jL=kW+K6noeaO9=zktgveVbYmbZsWUWo3r-V0S7V90FDLw@mail.gmail.com>
X-Gm-Features: AUfX_mymdEhf6vtyoDczgdrTd_h0sSGCYBoPOdLs8lQcTMbtLbfi04PfIu1dDG4
Message-ID: <CAD++jL=kW+K6noeaO9=zktgveVbYmbZsWUWo3r-V0S7V90FDLw@mail.gmail.com>
Subject: Re: [PATCH 00/15] Add initial support for Qualcomm Kuno SoC
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 9:27=E2=80=AFAM Hardeep Sharma
<hardeep.sharma@oss.qualcomm.com> wrote:

> This series adds initial support for the Qualcomm Kuno SoC and the Kuno
> IDP reference board.
>
> Kuno is a 32-bit ARM (Cortex-A7) Qualcomm platform. This series brings up
> the essential SoC infrastructure required to boot to a serial console:

Is there some special reason why you are not posting this patch series
to the most relevant mailing list i.e. linux-arm-kernel?

Yours,
Linus Walleij
