Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519E48BD26;
	Tue,  6 Oct 2026 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302067; cv=none; b=i1xiKgrGs5p5A1Ejft4oa3LsL+6xqlmWPx50rNjwc7/eJIUVtJkB26T+i7Rpe+8cnLKsrrq35ZYg1AWM34iJyA36HIxNjoJzRBHh/7yPgwblYg950jaGwylfZCPlfWs2bJmf7OtyXt+vr2O1YEsqiHwNLNG1jXAejkJnc3dwJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302067; c=relaxed/simple;
	bh=gpbU9KT+IdZlGPX4RCLuK3AQW9b99N3rxx+gJf4h5ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XahFGdkBnEfGI63MuspQSY606G9cU8I0nFD4KoGAEJ20cDZ/xtQpdFw0GNle6PZUX2w0CkYRKnIeDgmSoC05olHY7jeua82xdIDtgQPfqIaYcjpSpoUUXOvamuax9078DKUKxParGIENG5H86W0FdHqOIV9CMhd8ERtk4NFxksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7smEW0F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7smEW0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11231F0089B;
	Tue,  6 Oct 2026 15:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302066;
	bh=7MsXsLm8OFANJgdwJHK+NmEW42JdGgPpe+gMX0f0fKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q7smEW0FedT+RH5T4aeZFrsCzyOBDV03gBwkAOSNVoFs2oPGObMLwlo/QrnLFtB4D
	 HD9IzQSYpKOD7hdlXbONHiRdlXB+iFZ304GvyVZXMeoVhz3lFwMybNZijNXkwdk0eu
	 tdxi4ux2UtZyIUjsfi52Jmv47XxriOgU68ZmThaFfYEQGNX0nnf9UkBWWPwgmvwJ3t
	 K/IcP+5F1CnE/EB/J3cYVShIuUbXuf4OCBy21t4b4D8TLA6cry5lnteW4sDEM1Dsg/
	 MIKzSIDDu8DZXUKnVe4pkMwEO0laIeeWbRxPvBH2CljKn/JOSv2BvhOfuaArVZnBro
	 5f/9UrITmfZ/Q==
Date: Tue, 6 Oct 2026 10:54:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanislav Zaikin <zstaseg@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: soc: qcom: qcom,pmic-glink: Document
 Xiaomi taoyao compatible
Message-ID: <179130206491.2403428.17338630173408456137.robh@kernel.org>
References: <20261005164303.1208127-1-zstaseg@gmail.com>
 <20261005164303.1208127-2-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005164303.1208127-2-zstaseg@gmail.com>


On Mon, 05 Oct 2026 18:43:01 +0200, Stanislav Zaikin wrote:
> The taoyao is the device compatible with the QCM6490 platform (apart
> from battmgr). The device also requires both UCSI_NO_PARTNER_PDOS &
> UCSI_DELAY_DEVICE_PDOS quirks.
> 
> Document the PMIC GLINK firmware interface on the taoyao by using the
> QCM6490 bindings as fallback.
> 
> Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

