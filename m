Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480326;
	b=ClZsIVadZ7RS+mbH3i4s3UjcWjiB8pc2nE7o1Dns9VYvn0k3DoRMrNpm795XkvI/+x7X
	 JxDSnEvBvSFLtFSXUH9W0AePaVClL8sUo4ItFib1+TDpHWNajAnqBYPumrLcuj39CcXE5
	 JAA7qQC1CNn5V+CQsjo004ZyAXvUoHrIPF0DBAk/EYHu3hiJzydvzzklHVvQQZYNROEuD
	 BoJD0/zOm016UM1IxTXB675/Hsn++Y73Bt5HsLXjEc12Heg0IJq2N3VT/Li7zAC/wZ+7E
	 X7X8BMCXle/Di9fn2hj8oeTuihhTmeSTMSPrXDCSh/EsDsyWsrHBV8+J/vQY263h+mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480326;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CEwheioTzFoNUDiKNzsWnhVx3Vvy+hQ1m+11Eoheonk=;
	b=dIiXEdAIs/bKgBv1Z5J2+1NIIJqa9q+cRG419/UkymzNAssMHzl+znvyQUuJ0BW0+CKI
	 6gV42Ru3qjlg7xDo5bXxFzyNDVu6RrlIzpDRIfIjQcxfxcSc83wcBgcQRoTQGg6fdr4Mx
	 cdf6QGEfKOD2Q/EA0cG4YQvHqSPu5Y9hYFvoMiWNvllKlUB+aYS4W2MXi1OsA0xjlo//s
	 NzvEH+8vWI6rm9Zok6Qn8fcG+th8vcQsX4Gj2jqjkGC6XrKP9xAijEL9a6rHS0NvDZRzn
	 nv5aE6FIEMf2zqnJYiUYtRBYjWIf5ewggjENF6dln7DqZExydlyqezQMdJJ4W5QS7xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EBKd6/Ch";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97D6606A322;
	Tue, 20 Oct 2026 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EBKd6/Ch
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB02D1F000CA;
	Tue, 20 Oct 2026 07:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480326;
	bh=CEwheioTzFoNUDiKNzsWnhVx3Vvy+hQ1m+11Eoheonk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EBKd6/ChBtRWXyqgqnh9n2bQpreC/zw9JIQfaaHErUKTAcrh/gDBfKR8Tzhvt5YKA
	 YjSqwY9jJwasimQ3X5m8jPm74JhtaQRZKI+qCjIjQ2Vu8CqbNhVt+8DSTOJmKQgrDA
	 hzOZ1XMDcpt8qiFO5+RR/zwF7bQyEJRMXLTOLpxBWgmLVdCmcCZrd6vFj3B6dhVzPs
	 baKyjEoqDNpk0aegz9J/74gY2YJoKLbAzEzsaZzL7jZ66tATmp+rS4mnTrL/OxtP++
	 mB2uzXB5uKEzy0Adn06Hmh+/u3wt21jgSqB1eG7HH0eOrlVQhm6KfZFFxa6bgp2yhI
	 i6yeYsJgl9Fng==
Date: Tue, 20 Oct 2026 09:12:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jonathan Marek <jonathan@marek.ca>, 
	Bryan O'Donoghue <bod@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: qcom,camcc-sm8250: add
 interconnect provider
Message-ID: <20261020-bloodhound-of-remarkable-debate-11afe3@quoll>
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-2-atanas.filipov@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016170701.1504338-2-atanas.filipov@oss.qualcomm.com>

On Fri, Oct 16, 2026 at 08:06:59PM +0300, Atanas Filipov wrote:
> CAM_CC_CAMNOC_AXI_CLK is shared by several camera blocks. Setting its

Clock is not an interconnect, although AXI suggests this could be
something with bus, but it seems you solve driver problem with
interconnect description.

If you only need to solve "last writer" problem, why not fixing the
clock framework to accept the votes? Otherwise this should have
description why it is an interconnect.

Best regards,
Krzysztof

