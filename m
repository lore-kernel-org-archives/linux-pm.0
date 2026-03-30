Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6A33D4E9;
	Mon, 30 Mar 2026 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774854417; cv=none; b=Q0Rd4W/f/GaaTa+Wz0sV7EiAzfMaDAuan6Xxze1GltkgO7f8UJsq0QC/b4TxWCtLTg2PNKvJ7jWOJihh1dwDlslpDwOXNF0MjgfIUOxDslRHcYDuiGBukyemOsnT7xBhh5vYUfQS9WUY3Jo2mVSW1XuP9bYT7zPOhPQcVcfgDco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774854417; c=relaxed/simple;
	bh=tbeI2CcasPRtwv8iA2a3z67oAioDgSrzrqJj0Lvy6dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHxbL+deL3N2kg53L39jOM8fHMwNhsLU6xft2AdAc0n0PlvlKZDJsMGP7pddUi0uMQl5opT2sEcPq3iymoDDeHnmFo7kDhk6z9AvAxmmhuiH0w54fBjwOCE0itUmko6gSXNisCButeIfimG9c1Ga+gR2tm5lwxUxm84JRaIYJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7Lzvw0/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7Lzvw0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7970C4CEF7;
	Mon, 30 Mar 2026 07:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774854416;
	bh=tbeI2CcasPRtwv8iA2a3z67oAioDgSrzrqJj0Lvy6dU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7Lzvw0/CvCt6nx9RIVeH6gsDAymRXP2mPNrKQmC4XaEMZHKS1CxqQ1aY6C+GaPwt
	 x6TVDmN7iNo9NNcbkbxd1PZ3/OXJ+HFadScvbHKcFgymzgjwJYBIEPFCzFqTmJOvMj
	 V7Y2KTPqgX0lZ5lySPwHD8lxME2XTjRVUnxDcVLMjvPRFPuXUqhC1DFQiqN7h76o66
	 G7N3Okh7e8JXp0sRLGzJQWbvpZ9V7fb7mQUHTIr74c2wnEZV/M0TEfvqA5Ahv6IlMW
	 VA6pNV+DVFIz6REDPZ3AATIDn6Q574jKRLhVouSkbU7/HeR/mHqKMT7EdGnkErO9pY
	 mnOaCEAwpUDoA==
Date: Mon, 30 Mar 2026 09:06:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, vireshk@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH v3 2/2] ARM: dts: st: spear: remove undocumented
 thermal_flags property
Message-ID: <20260330-furry-apricot-toucan-bb8d8d@quoll>
References: <20260329123449.309814-1-krishnagopi487@gmail.com>
 <20260329123449.309814-3-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260329123449.309814-3-krishnagopi487@gmail.com>

On Sun, Mar 29, 2026 at 06:04:44PM +0530, Gopi Krishna Menon wrote:
> spear13xx.dtsi defines a thermal_flags property in spear thermal sensor
> node which is both unused in kernel and undocumented in spear thermal
> sensor's binding.
> 
> There were no dtbs_check warnings associated with this property as the
> underlying spear thermal binding was not converted to DTSchema.
> 
> Most likely st,thermal-flags is a misspelling of thermal_flags in
> spear13xx.dtsi. Since both st/spear1310.dtsi and st/spear1340.dtsi
> define st,thermal-flags property in spear thermal sensor node, we can
> safely remove this property from spear13xx.dtsi.
> 
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

