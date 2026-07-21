Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DE4266B5;
	Tue, 21 Jul 2026 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629144; cv=none; b=qLjnWCxELEnVID4waL6iKdKqhdfb8Tq+aVU0KfmvRy+Bnv7aTAkj8Z1yKqQofOKLTSUwNyApD2dnKkM/XuPlAK193EqW6/1Qex1fMtAzuY/oTTM4DGU30QDosyryxyoYOH5wT+riaWsc/vlopFrChsolMFrm6QsinzuFsEvL1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629144; c=relaxed/simple;
	bh=82RrQO8mhJAusNBh5vtNQdTZBmcOgIfMlHJN9+p6N+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuGY4pxQie4aAp2/c8jy9Xzmi9fLf0BT4B+kgh6Q3/AyIISW0xw7tta0WMw1upsvgfhqF+DebhlNE8e8LOogm8Zn+QCdvxM3TgjJUJy1U0e6zek56gShRyzPvCBlbx2aI3ZmFppaf+wQVYO8dPn9BkWcfynlUJaN6aeEYlJjcXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG2F4tqo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG2F4tqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951151F000E9;
	Tue, 21 Jul 2026 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629139;
	bh=5m8Yk+GO/D3rTwvE3QFXHXJHBNuaLeAiSj80fAkXgvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oG2F4tqoDyX7ok6FWtzrgP6ofTXz9Qq4FdgEpCMLvMYvFlQpFSLTmAVv1Y+II2+ic
	 B9QRbyqD1EwqqWBUagX6BNyfOd7TFCAXypFB3mTE6Nub6FvemU5IIFJhjPEbx1S6x1
	 tsiTXB1TMUN3aEY4G2T7v+xQMX4ppiFjkuitoPi3wDGFsPk8dgDcaOJIAX84i2oOzL
	 AZy31e2iYtX3HhiGtAbU/ddXcHB67gI2QrMradYtD4SPuEOLFrx+ujBvCr5/VtnxVO
	 rG3D8j2H5GQFc9RRsQkZZWqyT4M+h7hr6bsfKusaSmvDkeYvZUwJwzcTfm2mPQoCls
	 VYUiSLspNwS9A==
Date: Tue, 21 Jul 2026 12:18:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom-bwmon: Add Milos
 cpu-bwmon compatible
Message-ID: <20260721-icy-jaguar-of-virtuosity-1dd295@quoll>
References: <20260717-milos-cpu-bwmon-v1-0-dfe0bac9898c@fairphone.com>
 <20260717-milos-cpu-bwmon-v1-1-dfe0bac9898c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717-milos-cpu-bwmon-v1-1-dfe0bac9898c@fairphone.com>

On Fri, Jul 17, 2026 at 01:45:02PM +0200, Luca Weiss wrote:
> Add the compatible string for the CPU-to-DDR bandwidth monitor on the
> Milos SoC, which is BWMONv5.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

