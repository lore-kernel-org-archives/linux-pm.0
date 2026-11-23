Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421851;
	b=S9Mld9/v6oI1cVs3mfOqlydZNRyOHon3FQICoD4v1w5SrG+7Y9oG4GBU8NW7khZtUZol
	 8WZ9inwNktlYyRMvd6ncPoqfBoJtj4RabModa5P2yYp5t7Y1XcSo/1dLtcw+8aJzMSdtI
	 OoNAEKMPsPJ32LeqbT1Ambx2zSUegpwWew1+yxv85mLwGbplgXtg8MP/AsAd9/5dFVKoS
	 4E7DQ8XBhaJQbX6yGya1Osq729IHkm5SrXA6Mtq3nIYpOo1l7ZcyyjbXoEfwfQlnNuMTb
	 mO+VRJ8NBSTiHYKDXe9b7idxz5Ojd7hEU5fhUtwAIShYOWB3TFDUx+Y0wQmWPtOioHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421851;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tO23FcCzTOpKP4xWAwgKyNJopuKYhTpyfii6Z8+glJg=;
	b=boImAfwo4n8f2SpzndwSToRZW7gvoYURa4v5n+TP7DxaAL07jsrQXQGr7nYuV+DB/F6C
	 OBghKDvYImiuclkIn9W0PLutFWs4xBseeeVbJOSTnwek7rmO5Zo+YTCIXROY/QXGYbZdS
	 VOi/Qc7d988EhNCMz4fATySapw0cj+kay1wyle//YciQIKUTr8JD7v5nX2YmSQsGUjab5
	 bHGILWFK7BbRgwDdxnKK/OYR5NXb9SIOCRrBfEFec3zIdMLi2Fp9eu7HqtDhg4FyX8Oic
	 5AIQFdXVUk+nDAp04uiXcM1q2UwjCBDivJ8ymaKJgQLJWQblfzwfJdoECr0epB93pdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDbDgfvy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9973606A31E;
	Mon, 23 Nov 2026 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDbDgfvy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9557F1F000EE;
	Mon, 23 Nov 2026 08:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421850;
	bh=tO23FcCzTOpKP4xWAwgKyNJopuKYhTpyfii6Z8+glJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gDbDgfvyeD19SgLvnoS03oNdxcPLr5A4IQRAI0hNKw3kFGMFSDiMuOvSYxKfbyFEv
	 uSbYTngqBbKQ86vB+p9zE+lDPwDfNBYaptI38mdBOSGPXaWq6MFN/LZJbnQt+kw/G9
	 BO2wtcbXFE43+vBVAMG8/HmSOmfhXRESbjHiMMG5Qrq00izVwTBrUynGv80twh04R7
	 rbgCc2Q51FDXvLy+aqGjtK1uzQjzbbpJAhsBEGaADcmP5YRIVYJPp08F8+avWU5aPl
	 +rfFn3Mz77ovtlW21jW39omzM6pt8IGOd0Yx/dMvauswdgx45KW1pWu2UKAMDhhjSc
	 wOq1bd1mRFPfw==
Date: Mon, 23 Nov 2026 09:17:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shaunak Datar <shaunakkdatar@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: marvell,dove-thermal: Convert to
 DT Schema
Message-ID: <20261123-sceptical-gleaming-pony-fe0d9a@quoll>
References: <20261112141005.229687-1-shaunakkdatar@gmail.com>
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
In-Reply-To: <20261112141005.229687-1-shaunakkdatar@gmail.com>

On Thu, Nov 12, 2026 at 07:40:05PM +0530, Shaunak Datar wrote:
> Convert the Dove Thermal binding from legacy text format to YAML schema
> to enable validation with dtbs_check.
> 
> Signed-off-by: Shaunak Datar <shaunakkdatar@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

