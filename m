Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26E2F7F09;
	Sat, 17 Oct 2026 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792256499; cv=none; b=QMJStu4q4kDs6UTPH3/VfB3jbTLgRFoGjqS9Wcl0GvN4/vPtlDbVLTsw0KNCYnhAMrT95zYAaiBbm0utQQLuPuEeFZRPnjI0i/gw84KpQWvTdvwUocYDlU+xM7+moFCongzqKOf67/Kn6OjYbHT7dFV+sCZoiXxyHyFLh+7lj50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792256499; c=relaxed/simple;
	bh=2M8Z37PGiNANIsasjU4e1kZ9u/GJ4FFqIX0MuMfc0Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMFfaxpdoKqKEIkC41dktmQFNrePEvC9pRoNKSqWCibmwsORsW9rAQB4iRpe9aYLeo3HK/QSwPQJ11zqZKRh0dSgID8wyKopoJurgvB76dS7vTKeV90jW7JKi7DNDqxSfELwD88uNrRfKyIxu38KV5LG+Vez2Qeh5OS5Tce338s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uti611E7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uti611E7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78BD1F000C5;
	Sat, 17 Oct 2026 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792256497;
	bh=0mpsN5T94ZvmjEYWIHni//CidEPD9YSQXWSdV5pQRYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uti611E7TG6YYKLZ/XHgnHirC/P5Zy7US6Znl4ZwphdER3a+IB1wLyH1jH6tWjlBZ
	 GgKInUd11xxI0xOAvO/Tf5jRz7f1lshi7/GWX5IQJNVWs8xiT5pqDz4VkrMaiHOY3g
	 AtigQtR42lSI0Mopj7mjIIC2GEeVWBnc5h8m3dKfAT/6mn6b0M/QNECAw4E4D2iSWY
	 4SRvuG2drUjDRWGYva9x9hZm7dsVspGRdSJSpF5gSOPpfIMvyBEklWqC8l5LkA+kC2
	 RpZ+McMs6h7baRJwsWudSICtk4mzc3S1B/GHUj2gmpjtYrwrowba47VSfVY1BWS7TT
	 zfGvwObZxDaoA==
Date: Sat, 17 Oct 2026 19:01:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Demeter Barna <me@fromdisposition.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 SM8350 CPU and LLCC BWMON
Message-ID: <20261017-fast-sloppy-angelfish-cdd8da@quoll>
References: <20261016-sm8350-bwmon-v1-0-562fe403bf6b@fromdisposition.org>
 <20261016-sm8350-bwmon-v1-1-562fe403bf6b@fromdisposition.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016-sm8350-bwmon-v1-1-562fe403bf6b@fromdisposition.org>

On Fri, Oct 16, 2026 at 06:13:51AM +0000, Demeter Barna wrote:
> Document the SM8350 CPU BWMON, compatible with the SDM845 one (v4),
> and the LLCC BWMON, compatible with the SC7280 one (v5).
> 
> Assisted-by: LLM
> Signed-off-by: Demeter Barna <me@fromdisposition.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

