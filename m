Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065B1A683D;
	Sat, 11 Apr 2026 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871437; cv=none; b=PdXkxoMbWD0Jvu1aJY1c7yb5eRndUGJaiMzZRynuPqkYPwZaXSFYeS+cuh7AmBVvPcR4q3J9O1vdqZnk1+hfQ3o6k4mD5ca2sHtby2wYFxE5MNhnDEjStfYewfd0+JzG7R1hHZkolxk8+iiYnTBx57MsI83n0i68HbTLt0J6oDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871437; c=relaxed/simple;
	bh=trZBp4xgmrirhAC9tpRHMpVWRzg2rIoavzjXL+J+LzM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DxfPZP4cu3akGjFZ1S28m1+LQeuuDXlZU/BBa2gSJBPBcii2jxjCv0BBUkhoofl/rCDHdP9Xa/qKQsrqUujL+IyQLI0yUTus16QNfZ76666UJlGe88c2q83GcJUYGP+iI8/HgxLe0R9CtpJjsHddhtWuBoriXPFFunk4nWkqydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wzuT0rIL; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wzuT0rIL"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fsx9Z37lgz9spW;
	Sat, 11 Apr 2026 03:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775871427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trZBp4xgmrirhAC9tpRHMpVWRzg2rIoavzjXL+J+LzM=;
	b=wzuT0rIL2uFwHD8yWOGa3pC74i7i+kbNV5s14sZ2INtzm+6KEwycNK1rGJcU+b03v899bl
	ssgLjmEbg5PQkUnSQfPFHlzYEZIv8la+9nxriaqZdd3utxAp1MiCH4A7zu9bJX5iG4qwEh
	txKwV9cSlndoqF+4A/KxCdtKpxDXzueGgCD1l7/wKHOS/9O6Lt7zdXhtS1sWbIBy75IoOT
	UkH/YyWnUY/ocbMjOiDvdRwg6q7psNI+NwBNcNIj7vkeddpOFDRrcTCQ18mKR6GGftap0y
	GhEVJkEEhzAhFEc6LMZoDbh86UFrcKq3enpc/5563AGebXc6XwCZumSYhuts+Q==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Apr 2026 09:36:47 +0800
Message-Id: <DHPXVI2SL3PG.3KBRF3ZWZ2WN0@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Daniel Lezcano"
 <daniel.lezcano@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz
 Luba" <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Yixun Lan" <dlan@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>, "Vincent Legoll"
 <legoll@online.fr>, "Gong Shuai" <gsh517025@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: Add SpacemiT K1 thermal
 sensor
From: "Shuwei Wu" <shuwei.wu@mailbox.org>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
References: <20260410-k1-thermal-v1-0-12c87dd063c3@mailbox.org>
 <20260410-k1-thermal-v1-1-12c87dd063c3@mailbox.org>
 <20260410-inescapable-glossy-cobra-da4bf4@quoll>
In-Reply-To: <20260410-inescapable-glossy-cobra-da4bf4@quoll>
X-MBO-RS-META: fc4nazxd5bgp5f7c39jn4cxumdou699c
X-MBO-RS-ID: a3eee99e18c1cea89b0

On Fri Apr 10, 2026 at 3:22 PM CST, Krzysztof Kozlowski wrote:
> On Fri, Apr 10, 2026 at 11:31:36AM +0800, Shuwei Wu wrote:
>> Document the SpacemiT K1 Thermal Sensor, which supports
>> monitoring temperatures for five zones: soc, package, gpu, cluster0,
>> and cluster1.
>>=20
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
>> Tested-by: Vincent Legoll <legoll@online.fr> # OrangePi-RV2
>> Tested-by: Gong Shuai <gsh517025@gmail.com>
>
> No, not possible. Otherwise explain me how your device tested a YAML
> file.
>
> Drop all of such tags.
Sorry for the noise. I will drop it.
Thanks for pointing out.
>
> Best regards,
> Krzysztof

--=20
Best regards,
Shuwei Wu
