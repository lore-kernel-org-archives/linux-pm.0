Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556A1331EB8;
	Fri,  3 Jul 2026 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071424; cv=none; b=QFWx0+Qr0yT8KNkBZgQM2TkUQv0ZxFCUE90IR+opClB/kcnqxRKMVr4mBgQX5wu4ikIr9wJ2HsQWlmbIerhGnxpeaPg3gfxiHuZ7XidgLI3ifpZob4O77rIqCld9mcckTpqSLShszNyu+qcu+Wd+ODAEcw/G9dsqkuYAJjbgKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071424; c=relaxed/simple;
	bh=jWFtjW2yC8Jc7r3ourxk24kcYv5zj8+DQev1sIaj8WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1z5Wqri773CAuU/5C5igmwSfCnximTdEpSZDcH7og4tGUGWamrEmH3RnU4DolX/uA/doinaJB91N1lgDzH1PqwiD1C1DfIWIXZ2gtj37tkfj7aiqyN3celtO/vvbSbt5ltG/m5tBNXr8eN/jznI7opHKWwvMTpPbR1DSDVIDwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJy48RWc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJy48RWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCF51F000E9;
	Fri,  3 Jul 2026 09:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783071418;
	bh=MKnHNclDiES+hsTrpnIseRxNU5ELzDEeEieHpnxW0XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GJy48RWc36yExNZ00hLkjjgPK01Zy6aSDNrR8Jr/xkccOyaEbrzI7ExqTAgOmthIp
	 TrFGcfipMG7LRKGz1VtAINAq0ZSo2yZhffKVTpGP06QihhTQGqcw+ClSlP/9Pi5XeI
	 E3pZHPnGUI3SBvcCBTrKUjG3C7UOE1cSqbn2Jdl8N6k8qH7dLfmFp0SEBG0/wCmErL
	 PwHwMm8Tmji18FCEoJPZTGmdkDj4U3CmX1rA91NOwSiLvFezIzyQVVwR2UmwTvNUIW
	 O3RjKBUWSog+23BRri2mYRRmrym7fUulVMje7nUwm0u6izwPbdPdxnjpv2QrrwTtTs
	 8kKgGUjev4XrA==
Date: Fri, 3 Jul 2026 11:36:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ilia Lin <ilia.lin@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: qcom-cpufreq-nvmem: document
 IPQ5210
Message-ID: <20260703-lively-intelligent-raptor-5edfbf@quoll>
References: <20260701-cpufreq-v1-0-98656ad20ff3@oss.qualcomm.com>
 <20260701-cpufreq-v1-1-98656ad20ff3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701-cpufreq-v1-1-98656ad20ff3@oss.qualcomm.com>

On Wed, Jul 01, 2026 at 02:16:24PM +0530, Varadarajan Narayanan wrote:
> Document IPQ5210 compatible for Qcom NVMEM CPUFreq driver.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

