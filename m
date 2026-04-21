Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87272631;
	Tue, 21 Apr 2026 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776759063; cv=none; b=l5TTtW/KykDkkiJOP9HCs+GQ/RI07nRdeZ3tXO2Q2dC+Xyc2LkA4DWtWEJRRhib5zC3csTmvAZnY3JU3nKCktgqGMnMUYKgZHyHO59Wa56LjmzI0A2Zz9NTDdNKUAPvefzCtQlTa61tTwY//1Eih+1dB2ob1PE/9xpeKDBbreFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776759063; c=relaxed/simple;
	bh=Tw5y/BjaWKbihGRIOsYkTlgniAaZpFkNRSj8PyADtm8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=D7JPp7774FhocOYZ4r41LhNKrJH8a20zHEikvEdQZABoRdDBmtZZpkrK6SdiVN3M6EIe14k0EhwKnP3T46xirHjA/OkNUYpEJhVyMnyhdyCmIezOuwzFIwDVkeDjJdb02FDiYG3eNoEdQjg/a0vEC+0j0TAQ0QpmFjKmEqehQ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dHhiLQWX; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dHhiLQWX"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g0FRJ4rD5z9tMq;
	Tue, 21 Apr 2026 10:10:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776759052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tw5y/BjaWKbihGRIOsYkTlgniAaZpFkNRSj8PyADtm8=;
	b=dHhiLQWXIWgWFHaJiWrcbUeW05na81V5ClSqTnpiBMdlHHS+ddX5yPOhQN4CUfDvOifOm5
	CsSq6HZ64idqIQgd0FbGmyBtHSW0CKc971hEjXK1xMb5zG3S9lqNZ6d1dap736e9vNVEaC
	fNwf7+pnHoB1wfV0E3XogxIw17WRWOrruixz+kyV4r7PdqziKdFnClKr0BNDgzKlGgtPZQ
	vVJ0Qw/c1uPhxyYTszZXExAb4cff0lWCwF5/bCI/APZk5t9X+ZrvAEvHzq2jzDXqZzMQYm
	6z8Pzd+N8x9ow2AEYLmdlqUFtbWSZX9vYDNtVXk40PeZ2dAq9m4Qh8gr9acWNQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 16:10:39 +0800
Message-Id: <DHYOIIFMGH7J.228ISQ7XYFGKE@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Yixun Lan" <dlan@kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
From: "Shuwei Wu" <shuwei.wu@mailbox.org>
To: "Aurelien Jarno" <aurelien@aurel32.net>, "Anand Moon"
 <linux.amoon@gmail.com>
References: <20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org>
 <20260410-shadow-deps-v2-2-4e16b8c0f60e@mailbox.org>
 <CANAwSgSNHO3MNewNzpYbhuj4K3NTdfzDC9KPoUHbFH97P4M_UQ@mail.gmail.com>
 <DHUCL24GMX7D.369IWK9DLPZPX@mailbox.org>
 <CANAwSgRt5-t_ah=phGc+CQYHG-CdWJuOX-2VTW6xE7n7EnVsFw@mail.gmail.com>
 <aeaXszeaE62rM6BJ@aurel32.net>
In-Reply-To: <aeaXszeaE62rM6BJ@aurel32.net>
X-MBO-RS-ID: 898c96528d6322090f5
X-MBO-RS-META: dyrjym6i7ydcwho6k8h6h6sh3yn8yuoe

Hi Aurelien,

Thanks for your addition.

On Tue Apr 21, 2026 at 5:16 AM CST, Aurelien Jarno wrote:
> Hi Anand,
>
> On 2026-04-16 17:07, Anand Moon wrote:
>> After reviewing the Banana Pi F3 schematics, I confirmed that Buck1 and =
Buck2
>> Both supply the CORE_0V9 with 0.9V=C2=B11% rail. To resolve the restrict=
ion errors,
>> I expanded the voltage range in the DTS to 500,000=E2=80=93950,000 =C2=
=B5V.
>>=20
>> Additionally, I updated the DTS to map the second CPU cluster (cores 4=
=E2=80=937)
>> to Buck2 to better align with the hardware's power distribution.
>
> Actually the output of Buck1 and Buck2 are connected together, so they=20
> should always be configured with the same output voltage. And both=20
> clusters should be mapped to both outputs.

You are right, I received the same response from the official developers.

Therefore, I'm wondering if an additional regulator-coupled-with: property
definition is also needed here?

>
> I also wonder why in the original patch the buck1 regulator is named=20
> buck1_3v45, from the schematics, it should rather be called buck1_0v9.

Yes, my definition here ignores the regulator's default voltage.
Thank you for pointing this out.

>
> Regards
> Aurelien

--=20
Best regards,
Shuwei Wu
