Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFDB21E097;
	Sat, 30 May 2026 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780140053; cv=none; b=e6V9SMlVkGJYXhp1SDcIf01BSZzLgsIjzJCBfzINkImqVEU51xtyUxmNoqrTudWbHM3QHD19E/4IzbPMG8zXLDQCIigcge3rLpUK8eWncpISPgeGEyK0SF0pGXh/Wb6Qzi3gAxHwhIgvGXv6HDIz+qRoPAgq0bYxE/BiS8nClmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780140053; c=relaxed/simple;
	bh=/ip6uu8vKEzuXpsXDUzidbvCtPaYK9msE81f8/4VI+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft4LTAQUjVNjFyxwcNkQdrq0F8StQk0eDNiD/4r97fyzAX2V8ucd7swkX1/eye/98SH4nCg4+CxnyKLvYRzgDRa2+oWZ4ImAwfitI4KGYDqx68sahe67r3T/vEi5nrGR82gZKBDcktBNNU2mW0wVpOHgt85ofNt1L/z+iJBavzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOv4raiQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOv4raiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F621F00893;
	Sat, 30 May 2026 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780140051;
	bh=RtRjGq113wj9Sided+a7Ey6Ng/8p+TU1Ti0XEno9AAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OOv4raiQ2tPgqHDRjgVtvaN9Neuz8v9xPjax13fZTuFlHRkEiSH6xEoFqY5g7envL
	 DMkw/4D7bzso5n2lsovD7ZCW6xMzZESGXT9sd9MHV75poEcX4PsEzuN7QRKCijBKRv
	 NSggQGPat8mFAhVYx8PHSOrs7B5dKh4TTyAzSCUHTH3xpGrfa5HcC9GRxMIqYGxm+P
	 6CxJs7vHv6G7u92nArQ1XP0OCth8zGOLfNIJtlzCKnIExV9tYv0ajD2GANaalNjaur
	 Xbpo5BladnQDr1GFOhrT3+fR4Zw03sHcuRQuTGPdCC+79m20NuK0E4QYhijvyLkPzA
	 wvswDUL8cHtXQ==
Date: Sat, 30 May 2026 13:20:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Add Maili
 cpu-bwmon compatible
Message-ID: <20260530-finicky-celadon-crab-2cb4b4@quoll>
References: <20260525-bwmon-v1-1-b8f6e189c3e3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260525-bwmon-v1-1-b8f6e189c3e3@oss.qualcomm.com>

On Mon, May 25, 2026 at 02:19:53PM +0800, Yijie Yang wrote:
> Add the Qualcomm Maili SoC compatible string for the CPU bandwidth
> monitor (BWMONv4). This falls back to the sdm845-bwmon compatible,
> consistent with the existing pattern used by other recent SoCs such as
> sm8750 and kaanapali.
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>

All previous comments (from multiple patches) apply.

Best regards,
Krzysztof

