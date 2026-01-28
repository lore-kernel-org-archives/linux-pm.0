Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D102BE632;
	Wed, 28 Jan 2026 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599057; cv=none; b=iD1KWz8oK650KP6bR2F1yhaJhBOvWSmp/FNpzaOoBB0S169P+OyTf9oFbq22hnofdYwvLSGI/75N94uHmtRF3l+9afQqRKFna13D40tE/mZYc1jnMIQEgURz+6B4AqQOErr8Tu5RjH5yqNQKE6/PaA0c5EXU6qwQ2KXGNhhMW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599057; c=relaxed/simple;
	bh=dM6M+55JmMOXseD3l/QxOK7cVqbiLuI6OIDSIdS6maw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3DYWXPjgerqDdhEzVBh9ayXD6D/1WYus53jphdQeUOgnja9u0EKUi5Fib0Vg5ubXmAM8KqkCoKMDFIgAKoJGoKxK5GONgPnRwDRmb5UvkkP+cRJVtgpjUVQ96rpsPq4Nj3iMgoeDLgzmektD29NXIUg2O5eEt7ha8DboiIdF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1EflS+i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1EflS+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C638AC4CEF1;
	Wed, 28 Jan 2026 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769599056;
	bh=dM6M+55JmMOXseD3l/QxOK7cVqbiLuI6OIDSIdS6maw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1EflS+iOumdsYkVKUPXHviV+ixtqjCl0cSjw6SFIbisLSyioilwJwAaJBF/6D0LB
	 bv9FtYWxIP9B1AJGlixp2jPcjvPss63YgWmw0Mz1ufpIPRvPVGVpk6Is5jflfGOgOl
	 zjh+htghW5OZq/3DhjsABbsYypuI6FZqBaY+TumQCLsND6Ifx9Lp1lynRX1L7UwXp3
	 TtaoqMCK9VO/b3Zf39o48UEHSOdMmCKL87s8njcYPJ/iUbT3r0TbfWAHfnFfq076qk
	 fEMD63pF25AOk07qB9xFpFbciMRCaa069MdpLeclnRwsl1c8+fuXUYxUdmBAe9h4h2
	 vtKwz76Zwo56A==
Date: Wed, 28 Jan 2026 12:17:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Eliza SoC
Message-ID: <20260128-handsome-elite-boa-1dc56f@quoll>
References: <20260127-eliza-interconnect-v2-0-b238a8e04976@oss.qualcomm.com>
 <20260127-eliza-interconnect-v2-1-b238a8e04976@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127-eliza-interconnect-v2-1-b238a8e04976@oss.qualcomm.com>

On Tue, Jan 27, 2026 at 05:26:17PM +0200, Abel Vesa wrote:
> From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> 
> Document the RPMh Network-On-Chip Interconnect of the Eliza platform.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,eliza-rpmh.yaml     | 141 +++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,eliza-rpmh.h | 136 ++++++++++++++++++++
>  2 files changed, 277 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

