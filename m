Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126319;
	b=mOoniHGs3gItLqqGu7aibcXfspAO2cv6iiBvHQZ8yn8ok3f7VnDoawaSu65VujxKgx0T
	 nyGGgE03gshnPg05mTGY9LKa/STBAdgfE/ITDT9TbW9rrCn0IWz9fERfLZ22btW/jrmeV
	 GEIG4uHIyWis0/YbWsBV/fo76pUWToy29fAgUzaTCNsvihxd2kWqUq0fZ6tVKSfmGsm6M
	 CwuXM1vTQhHwBV8Ce/4J1xCapRD8w9nwwEket0drBbiWSPldh46WFG/aZE6TckdzDbU9T
	 PsfvMw2CbfUyNXCehIdVjcOSJFipj7P9yqZ7OnS4r3TqITs+aZv1eRoji1H6ogioQjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126319;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uBoSJTtzRxvJ8IoYQJOlz0olC7lznlyUmLgUztO17J8=;
	b=muLKby4HyCxCVPQBK28MBE9JoCtLGPu6ZP4oZHbAiyyryhwR2/sYQJJmfW6ujVexLSVQ
	 LUqhLBXO2FyCGi/ZHh/hNZJzjBIqQac9bEBCASNAZ4EzaKlokr2L9LjjKKd6QCFH3RDCk
	 eJmhKN+4ng2hbzqkrxl32y46No79suUH5A3skGr/i1hURS4PAN9q094pIC8HADqqHHfHb
	 LHrE8STXwmsXJpAsrOIGBLFp2Q3cdy4LvAIZ15Lr3Etc8OdRX/AuZEqLK4MnAn6k2/rgn
	 omRwdrtTQXp3EpDLliZCWaED3E2rw4+GvQVoCJVD3jH2csoBeEpxJnCZBqLGnVIlLtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGY0+Uik;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2563606A31D;
	Tue, 27 Oct 2026 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGY0+Uik
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B211F01828;
	Tue, 27 Oct 2026 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793126318;
	bh=uBoSJTtzRxvJ8IoYQJOlz0olC7lznlyUmLgUztO17J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UGY0+UikCFUt8hwv4spfhzh0v2PxZ/wCQMCGYBGA/w8anYhMOv6hnb70+68iAXwmP
	 6b5MDe1bXcUcknQR2H+m0mh47551tzLN7nE4P56zTBnCAKSNl67trGd2O6s5HnM7Lz
	 4DMh+75jYlYIFdY1JmsNl5CCTV/lYEkYiLYHB4Oc6kucCImixFlvvroxhcgR3vmiGf
	 30soTkn6sAwYzpgI6XSGx1ogANlx5Gzk80yAyUt2pqszY9A9kdD9nP/Jk5oBYfzN23
	 AGA8Vk63eqzB/j/Nh0itFC3W/clkteHa5/MqivKIyOYvKLrm011SLPB8UXsLTCfp91
	 +G3c5D5CGEzBw==
Date: Tue, 27 Oct 2026 19:38:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	konradybcio@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: interconnect: qcom: Add SM7250 RPMh
 NoC
Message-ID: <20261027-married-jasmine-hummingbird-dadc1d@quoll>
References: <20261027-icc-sm7250-v4-0-f9bdaa3c1c7b@brar.si>
 <010601a17d6212dc-ed028a84-ea72-48e7-a4d8-fea315dc42cc-000000@ap-northeast-1.amazonses.com>
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
In-Reply-To: <010601a17d6212dc-ed028a84-ea72-48e7-a4d8-fea315dc42cc-000000@ap-northeast-1.amazonses.com>

On Tue, Oct 27, 2026 at 12:42:21PM +0000, Ishu Brar wrote:
> Document the Network-On-Chip interconnect providers of the Qualcomm
> SM7250 SoC (Snapdragon 765/765G/768G), which are controlled through RPMh
> Bus Clock Managers, and add the header with the node and slave IDs.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  .../bindings/interconnect/qcom,sm7250-rpmh.yaml    | 105 +++++++++++++++
>  .../dt-bindings/interconnect/qcom,sm7250-rpmh.h    | 148 +++++++++++++++++++++
>  2 files changed, 253 insertions(+)
> 

Cover letter is missing, but you also never responded what is the actual
hardware here - why sometimes you have children, sometimes not. How is
it supposed to work?

Best regards,
Krzysztof

