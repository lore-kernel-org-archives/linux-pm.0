Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822171;
	b=pv/B9NKp3+OuUc4qhOOUSbn3qygpLQVElLjQI0AOMEoXXjJ+AvnWuduIJ9/IL67LeFxV
	 q0VejX8JAykkpW/fSqBrUA/u/ep9ixAJ96skal/SQd7mFAF2pCbllxgtvFr3mZIrD3Dga
	 6RHCcDlLLUK4Bc83lnFImziaByPfeW8ASiK9+Sj/AedHOG7joUI9VGT8GkTSodurKwaEK
	 MgPpAQYZIQI29aUQqINJ3EhQpp/vkt0xph82U8DXYtLX3kdCgcsD/Y4edNtUj5MJsrkHO
	 +uo2/Wotext5mNy5YDLQdbRynDgSx2sB4LYB26z5FLmUD+KzACz76eFu2lddgeKrXoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822171;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HoHG7Q+v2F3yQx0ptCSEeaODxcO2rVUZD9LjR6JGOYE=;
	b=NhdkRSwaXFCQyyKcZrxg4hHuWmURazeR2br4+iE5OavY4l9rbGiJmvOhkoFTIdnZgJvI
	 nuU/4t/scBCK4J37gBn3aZoayvCt5U8vqZpAjy/7PnReCh/69gS1jCgOnEfv7sxgNzboA
	 FDurtKreanHDXBCbYdRVVfekxUW0W/eVnyycD4PN+QGnSGgSw6S5DkEv4vCnX1jcvHwqR
	 laURzEsuZ1lbfirerb4HmPtzfPE0N6v2UGJGXGLoQxoEhcFLWw9wtP1ubPokwyjKJVlIj
	 Fl8bbVeg8bSCoQELDWyAmZGxdVrIEyrufzuzVVFYMed1l2mLFJtAwOlnt1CtG2RTQpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wps4oTA9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FCC60E4833;
	Wed,  4 Nov 2026 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wps4oTA9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DE61F00919;
	Wed,  4 Nov 2026 19:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822171;
	bh=HoHG7Q+v2F3yQx0ptCSEeaODxcO2rVUZD9LjR6JGOYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wps4oTA9ABsC72klO6frRDwdsYP7sS3fInX8HQ/nQQRLCkOO43eeYJkwzgne6GNa8
	 3RJtphV4QcmGWw5rqEAqQDWjf4KsnrKNCUHbfECY+XZZdrt9Q3IqEooND/6KeNmtoQ
	 V3Lf1qWhN9/IgWGkPo1L26IMtwrBI2g2LY6/lOET1wU0ca6v8qQorukIkzPSppVouh
	 i2/eOegGj9fep0kZErEICBk2P5oR9lf6mpGUV8W2gJrnSzaG+dDmqSU6MIGQxVWNU8
	 5zSJs51FbW1/PbmCXcrE53LG6Vrfuxsah91rggaWzJY5n2niNUtrjPMW1AYT55//cE
	 tEyzIMd7vyYXQ==
Date: Wed, 4 Nov 2026 13:56:09 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Marko <robimarko@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-pm@vger.kernel.org, Jerome Brunet <jbrunet+clk@baylibre.com>,
	Brian Masney <bmasney+clk@redhat.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Guru Das Srinagesh <linux@gurudas.dev>,
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Lukasz Luba <lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v13 4/8] dt-bindings: thermal: lmh: Document SM7250 LMh
Message-ID: <179382216871.3640746.15933620023263948476.robh@kernel.org>
References: <20261104-master-v13-0-355b65c6f764@gmail.com>
 <20261104-master-v13-4-355b65c6f764@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-master-v13-4-355b65c6f764@gmail.com>


On Wed, 04 Nov 2026 16:46:36 +0000, Sreeshankar K wrote:
> Document the LMh compatible for Qualcomm SM7250 SoC.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

