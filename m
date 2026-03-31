Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B343A9631;
	Tue, 31 Mar 2026 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941750; cv=none; b=Nnl3jgF26UZDmycdfpkAfMYXei2OpogcVZTl7040ckaZzatRW04TpNZcQ+cpZW23refgXZ4TkMrzM9O07tTODszRXp272TUpLW810iAVniBGlCJTYPLMOeoAUUlSeZaWWmiSKTv3OFqT7NeZx7CNvA05vm6qg0OATb3/BfWcvu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941750; c=relaxed/simple;
	bh=3epPlehlc3uNOp7La9rWzBwZDIqolRKO1QRk7N2tNG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p92G53kVGaUaHjuXNF8zb0Voay61JPNCEZe9hIvCsBz/j+CFG35LcZuDtMs8BqvKRcmlvLWF4VBTvZbtJb2J9aQTYiXFPtbinxroKLqsT0velloiQdTCz2zZaSkj6ZlW6kFmAkSdC5l4PM5Je1Dr1oOjm7NKviQwxC+My2uXKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFmCheWU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFmCheWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827CFC19423;
	Tue, 31 Mar 2026 07:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774941750;
	bh=3epPlehlc3uNOp7La9rWzBwZDIqolRKO1QRk7N2tNG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hFmCheWUiKtaDslZfGELlxYhixl1aPAcQomQTdP7jweoel1WYk/Ue2O4gnEroa7TV
	 SM9ZFmv1h85Fkb3YYJ8YnMbbYA+8WoEIHogH4HlAuGBWeHZgHWjmMFcNoITFPaykNc
	 bHFRIUUwkuiZ8Sr8dBndwxkb2kJfyOR4CF2QJ5k1nWHOgeIfAEGJ7JHXQDxS8eFEWn
	 Mfe6cJj6g0kYWIJV0ibgu0aY7VgkSmB714MkMjFs5fVszOEVvtEwCexj1yYxKqnoxU
	 x+PaURyRuJg1wbqg2nR/MvpDMXx2HMuxRnGqu6DoOqCmZLcvYt5AxFtyfWKRGMjFZ+
	 ZuX1FnvuXVatQ==
Date: Tue, 31 Mar 2026 09:22:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khushal Chitturi <khushalchitturi@gmail.com>
Cc: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ulli.kroll@googlemail.com, linusw@kernel.org, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ARM: dts: gemini: Rename power controller node to
 poweroff
Message-ID: <20260331-majestic-tuscan-woodlouse-7c0ed1@quoll>
References: <20260330110135.10316-1-khushalchitturi@gmail.com>
 <20260330110135.10316-3-khushalchitturi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330110135.10316-3-khushalchitturi@gmail.com>

On Mon, Mar 30, 2026 at 04:31:35PM +0530, Khushal Chitturi wrote:
> Update the node name for the Cortina Gemini power controller from
> power-controller to poweroff since node "power controller" is
> reserved for power domain controller.
> 
> Signed-off-by: Khushal Chitturi <khushalchitturi@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

