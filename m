Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA0199931;
	Sun,  3 May 2026 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777818860; cv=none; b=AoHn0dhJl7KNibkfjMgaGlHaUMSV/+XHA+kQtQwZuIOwQhXp9VXRIdGI23vq7M9smqyyz23C7x/mrc8WYKLkHOX9rXCa5T6IO1UjhrVkiYucuov2Org1UZgxvi8VZ7r84pbcZcdUDr6MZiVTqA84pvJYxWdkX19Xt60pqolqtVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777818860; c=relaxed/simple;
	bh=awYG5rAli0iE+undXWmtK7DDpPXD6LWFavJo/w2Kfjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOteza9xEURREry+cxRrOXJsDBLgM1TCewNBUarsp3PE8DcnNo8Tr3sC9jKtkmd+RW/tpYXBeX67dkN/nC/1fykkON4gUvil16VaP4kIOkQWQ8+szVeNT1wfFF56d8OVStdqdhmF392BFnm+HBXrF4+0/uPPGFuvTHDa8GJ9K8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9+FaPT6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9+FaPT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FACDC2BCB4;
	Sun,  3 May 2026 14:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777818859;
	bh=awYG5rAli0iE+undXWmtK7DDpPXD6LWFavJo/w2Kfjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9+FaPT6AEVcEV1CwFSlootW6t5/mkvt/ODW6BNF1+qEQqDYDaHuXdBN0/H6oagnT
	 si3YKkYxpjeuD+PKQ9rW2MDv3H4RIK7xRLbdWuR/i8O/3j2xZCiUPcLh483DAzrAsG
	 FFb2/8y09sy7iuLvwngKP1RuIxV3avahHzNV4KnFEdPsbSKwqqXoWspghInCFY+rLI
	 xSRBHVwoySu4vD5fdlMS6aTOGWGOsZOaJYhyPGvIxxSx2Xv5ciiZ6qqu7a0yenVKX3
	 YKpWk6ZngD5HjA+xKiFF+PvOCAU9N/Ch+NXTHA5b2yGqn05thNvdQ0wtcRsl0SveeK
	 VgXOk/EUsJOJg==
Date: Sun, 3 May 2026 16:34:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com
Subject: Re: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document the Shikra
 RPM Power Domains
Message-ID: <20260503-eccentric-calm-saluki-ddc9ac@quoll>
References: <20260429-add_rpmpd_shikra-v1-0-fdba28564380@oss.qualcomm.com>
 <20260429-add_rpmpd_shikra-v1-1-fdba28564380@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429-add_rpmpd_shikra-v1-1-fdba28564380@oss.qualcomm.com>

On Wed, Apr 29, 2026 at 07:39:56PM +0530, Rakesh Kota wrote:
> Document the RPM Power Domains on the Shikra Platform.
> 
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

