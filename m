Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865235BDA4;
	Tue,  7 Jul 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407661; cv=none; b=I5Xrmy+QYvYf/K568GWIG13c6uqi+xYh9Vq30p6gr29v74P+O3ApDoeBhwf5HI89DA4leQDDJvvib80tbQgqXLvoKQY/sCqCEHG7qs0CRpWftZxkRrdw7+TJr+3dDgVtqS0AxW0inUlXYSLHX/qemgAJiErJCGRhuhRlZ3fBL+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407661; c=relaxed/simple;
	bh=Blav199sDEk4d5DvpTgfO++yFwfTVJVasL/vbvdLOMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5vmwPsTSY5yzDeEHGf04fZxU3O1OmrE4z1zFU77gU+1e3JiMnVpq+Mg4qFkJ5nrYWtKk0IlN0AjYyOhochTkubxwRsumYhor1B+7+Ml1c3kNQyyhkVfry3uBA7lH2VNmWM5EgAlafjkInttIzSOer3QHO5rGlW2HX6brX6/Rx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1jDtMbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1jDtMbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32B41F000E9;
	Tue,  7 Jul 2026 07:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783407660;
	bh=AeZ3IfCxrr03mDjgfxdv1YqUGpcTKuc9ZnPETaDPODA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h1jDtMbpjuG/eB4VhdMbFu061/vP67HTqr4fR+w2xT93flQpC7hPVwopST/uQjx7T
	 9C5mKexeuFltFWs1UA2HZWdLAbb3IFizDAWQzBkXVnVjEAnZJDC5p3GMgTE1emH+Py
	 GO/26H3OQUHwft+Hoy4jFaKwxD4y9krxmmU5z274QaWwjkIbmTlEIwmol1sUrsw+Bq
	 ninAKCEqJaU1VMZd3836SfrAC0volPjdi1S8qipO/IUGsiu4i26UnCcBve8qt5loX5
	 dsLdtUxdLusG4cvN6KexRb8asB22OwRLz8F3EvrokWKtVgRJ0HVTrBseRkE47Xe5dN
	 jdeVBCHl3JcUQ==
Date: Tue, 7 Jul 2026 09:00:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Stephen Boyd <sboyd@kernel.org>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Ajit Pandey <ajit.pandey@oss.qualcomm.com>, 
	Imran Shaik <imran.shaik@oss.qualcomm.com>, Taniya Das <taniya.das@oss.qualcomm.com>, 
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: Add Qualcomm MBG thermal
 monitor support
Message-ID: <20260707-portable-aquatic-chimpanzee-2f3c48@quoll>
References: <20260706-spmi-mbg-driver-v2-0-f883ff1d8719@oss.qualcomm.com>
 <20260706-spmi-mbg-driver-v2-1-f883ff1d8719@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706-spmi-mbg-driver-v2-1-f883ff1d8719@oss.qualcomm.com>

On Mon, Jul 06, 2026 at 01:44:35PM +0530, Sachin Gupta wrote:
> From: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> 
> Add bindings for the Qualcomm MBG (Master Bandgap) temperature alarm
> peripheral found on the PM8775 PMIC. Unlike the existing SPMI temp alarm
> peripheral, the MBG peripheral supports both hot and cold threshold
> monitoring across two programmable levels (LVL1 and LVL2), with interrupt
> status reported via a fault status register over SPMI.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> Co-developed-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
> Signed-off-by: Sachin Gupta <sachin.gupta@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  4 ++
>  .../bindings/thermal/qcom,pm8775-mbg-tm.yaml       | 72 ++++++++++++++++++++++
>  2 files changed, 76 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

