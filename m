Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06723E25B;
	Thu, 13 Aug 2026 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604688; cv=none; b=Cf7qUi2vn5F1zZ5OC1uQxnGT1aUMe077rYh0WJ4XUX8XCwUhXAMIkA0na1IJyda/xLNWvxjSXRxveUlSMHIEVVissSpysBwR1mpanNNxN25sUnDKPeD1mBVOwsqjLjaCba4X214CHRhuVQTYgP+g1m+p2jxAOm2vOmPblquUjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604688; c=relaxed/simple;
	bh=Xwg6ij+JkN5Y9SjjYbTcaEwZL7mVJIq7yRMTLCz4L8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD7hdh/LYA5z2D+3hbZuiRE9dMuPo1o3xiE6XnKBZaQJ2hp6eF8fdRU0xMc1b9UnQgQZtb+jdQjZefBsCkKV8vgI5mzX20+bqeRl854J/dZRLm4liHUbETa6dONwTMPpf3o4zojQUEKxsRYvNg+c9R7XG2uu5mUaTOG5xxR54+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5i0th3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5i0th3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A561F000E9;
	Thu, 13 Aug 2026 07:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786604686;
	bh=UgWct9UeMHk4UFxQ8VlRHLlm0oUzUbQW0gcOeCF6jPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D5i0th3pYQMKiwMgNEoa1BpFL/0SSTZCFcvB9XduSctmIHD/XE/DkxQV4Hb7t7a3O
	 jcxUPx+tHbFnXa51HVopZLAEfDmBsjpBtNo3qvptbCeOEEgvKGX2MwwGT9+/1Rwo1r
	 Q+J+xq4+PAlB/1EFWPzaSKkl4bQoY0zvPu9cHv8wDrkV0FU/JNZpAUWOkf3jjPHX+x
	 sv5BgEshyQkr4CuXPXvHydzBfpfl0ZvKdkoLFhbTS8o4N2AZyciqNqqPqU7GsZ5jAG
	 UpJf5rlnBsuOyUvognZ0TKCPqnHlFtH7r9mXCA/fhoukVVrA2FcnkbYsxZXIXRrltP
	 bRrcKN9+xOjKg==
Date: Thu, 13 Aug 2026 09:04:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org, 
	zhangqing@rock-chips.com, royalnet026@gmail.com, alchark@flipper.net, 
	chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, dri-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/10] dt-bindings: npu: rockchip: add
 rockchip,rk3576-rknn-core
Message-ID: <20260813-apricot-bat-of-vigor-65ba20@quoll>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-3-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812094106.1391698-3-gahing@gahingwoo.com>

On Wed, Aug 12, 2026 at 09:40:57PM +1200, Jiaxing Hu wrote:
> The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
> already describes, but it wires them up differently: two extra CBUF
> clocks, two power domains per core, and a single reset instead of two.
> It also has no NPU SRAM supply.
> 
> Widen the property ranges to cover both, then pin each SoC back to its
> own shape in allOf so nothing loosens for RK3588, and keep sram-supply
> required for rockchip,rk3588-rknn-core only.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  .../npu/rockchip,rk3588-rknn-core.yaml        | 47 +++++++++++++++++--
>  1 file changed, 44 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

