Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4C3793D9;
	Mon,  9 Feb 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659828; cv=none; b=vAcR/feBNh7xBpFZS2tTjhcWElKTqssrigUJj/Fign5cD+SmNwlrPCac3HrQkyz3+FP6xVqB4OeeVCeqJ5AtFsEWoHQLNRVZpZBLgm8X0053fDMzMLNfpn08591pxfl2mNy/hBJG6CmCzrgjtjcj+1DJO/Bn20ahc1qndNU2ooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659828; c=relaxed/simple;
	bh=856Kwd/pThJAAJaQCb3VCvhPWwgKfNaoq1rbMEQh96Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCej+ohdux6VZPfRb+GamM7XcQfgoc2yE/4rfBfRS2f9BmiW6/7JCdFiLTfJ8faWpj6OBYnuQCka+skvQkUbDo15h56YXYQvGiF8IL/xQr1eQfwJ1uXvthl8JHQjBLKeIxXSX9I5t4nvkQHt52jbedBp2eBqW1haJ3/ForCw/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVfpnW++; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVfpnW++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B1AC116C6;
	Mon,  9 Feb 2026 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770659828;
	bh=856Kwd/pThJAAJaQCb3VCvhPWwgKfNaoq1rbMEQh96Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVfpnW++UfnqkCLXvrxoEODMMCE1rIQOm4Oso2M0V+9pyxzqj1tzwfnHQ3JwWSv5i
	 Mil182Oi5/i6zr+b/0hGMcBMB6MFKrS7rNvAPfshTpDXnv/bk6EcEdTOp8QbmmrZDa
	 AWCGOvipYJogChJUiQTZ7gnBZIKiV0uMZPWmRlwAPxQDxcOYr5m6fMUez0D2c+y/X0
	 ko3WAwp6WwPSUvhJTAV9D76TWRjzV61IF5NPiYJoPQLpeg+xVeQ4cUqxweLdTp4z22
	 A5Rlb+FcxYjuBcZoSmun1HJBt+JYOrJWY8qoVH6p5sG6hCl0xPUTbuX85J4oTdd7dL
	 3rlVqeG2APxIw==
Date: Mon, 9 Feb 2026 11:57:07 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: power: supply: cpcap-battery:
 document monitored-battery property
Message-ID: <177065982675.1491615.16948217039462649956.robh@kernel.org>
References: <20260130134021.353688-1-clamor95@gmail.com>
 <20260130134021.353688-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130134021.353688-2-clamor95@gmail.com>


On Fri, 30 Jan 2026 15:40:20 +0200, Svyatoslav Ryhel wrote:
> Document monitored-battery used to describe static battery cell properties.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/power/supply/cpcap-battery.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

