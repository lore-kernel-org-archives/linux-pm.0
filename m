Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAB224AF9;
	Fri, 28 Aug 2026 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911064; cv=none; b=kb098lnkeG1Mg+7TuGEm+2AKgU/x3HgvrQqmRfhhAPKVLOU+TVnYSFBItv5SzJDiUz5W0ttEO1KTHru4mjK4hAcMhCsWcDrHBR8V9UsSafrUQIReISZ7FIlzA9bDXk4d5x6AyQVjXe9Si1Xok8GOYwSI45u86nVKVHVRODZzLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911064; c=relaxed/simple;
	bh=oNzxvlH7c4jYGmEyokEMNlaBVhuyDpvW1iqNT0gKyUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGKLkmvZ84X3HejitS928SLF+Kb3UEqKM3zOemSPNlYZlqyxyxaxoM7+9OaCHAj3/xW5CkFJex4aHtWlrjjuzkAm4OnxoiMlOj+QM8tYNJ1OUrGzfoMVxOqwUJGTA8sxPIwep+lTYoQ7H29mswYW44IJJDaCkE3TneLX8g5jEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6oJhmZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6oJhmZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E521F000E9;
	Fri, 28 Aug 2026 09:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787911063;
	bh=k8q0ZJMXl2CPq+ISd4HqAN+y3C7EZopmMtQXla+Hc/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T6oJhmZSr/LZf2pPlsDc/3SPRXoS/GA2JVe0Ph6BCIf3m0VpQ1sgRZd6IVQkczCrA
	 aMeW3aJMzQQajRAHl+CT7nohlnEfUYfInUGg1TkSlL3GSdF/EP0WXXFp0aENkdzej7
	 HerRivJmn6SAgVh90sTXVa2yURIy0VeCJEBHJ/KT2VvwbOfIMaRJIq00Rp/ziHC8me
	 n2A8PXVAumlGJDarsQ6TGQ82V5NBPZT+Zx+UDp6XOe5GKhcSIo9Qrn2NQAoNaZCZ5L
	 Q0Jz1fylUWF4Oq+n7ZSxFvANsmeMIKK2JFgiInq+Goxs1GHUejbEoIXXj7kP5ZNaAv
	 uAf8qFpbpiF8w==
Date: Fri, 28 Aug 2026 11:57:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org, 
	bmasney@redhat.com, radu@rendec.net, abel.vesa@oss.qualcomm.com, 
	lpieralisi@kernel.org, taniya.das@oss.qualcomm.com, danila@mainlining.org, 
	davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com, linux@gurudas.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 07/13] dt-bindings: power: qcom,rpmhpd: Document RPMh
 power domain for SM7250
Message-ID: <20260828-tentacled-broad-skunk-ccb8fc@quoll>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
 <20260824150156.1310-8-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824150156.1310-8-sreeshankar0910@gmail.com>

On Mon, Aug 24, 2026 at 03:01:50PM +0000, Sreeshankar K wrote:
> Document the RPMh power domain for SM7250 SoC.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

