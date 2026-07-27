Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09263E9C18;
	Mon, 27 Jul 2026 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143342; cv=none; b=p7nLkH4xXPIXydnhTpJtIPuVzH8jkeMwhFVGXu1eBz6aUIYHJkGGBU4CpWrNbkg34wmWDKTbHmiWUsTzaVWWz0o7VAlEdCdCm+X93zBwPj9+ZC6risjmb2jGNFhdom3eFZWt7dnOlyuvq/WTdGHsBDTHebmm72Ti3duoB547TFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143342; c=relaxed/simple;
	bh=oGGXI+yf0LCIgjrQNUJ7sJDyYn7axLJcJpqdn7cXFQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McG3wHLvovC+Jxc2gKQvHnwcgiqpGkTtAEyRcYg3OntdGklCotj2G6C47wtf8967BtKzRxnkZWoj5R0/7LxKHFz14qXIP3kwOQKrCiHN7i9YxJPbCM9VQfzW0Nw+Saojv74XOpnX+QsG4KVditj8sOKbFsRFJPRhp/iKMGvjwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhH4OEjz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhH4OEjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914E21F000E9;
	Mon, 27 Jul 2026 09:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785143340;
	bh=+y6eIxEpfj3dtsfjW16U63V+ur01YoLmzilHlphGybc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YhH4OEjzlGqcAzM6TGmp2nNXnN21+VqL+Ix2bYkPBgeMeleIZWmM4GTUOF9aPBcKL
	 YawwRzthp2kKTB3GTtb2SRhm6bXtm5WWnLEOwUhP1m2K2Zhs4HKLbV2ZeTz+EjR35z
	 4hQ3wfQg3IlnE8wdBaADXi0d5MSzg4dvuREmtoZWMpqE7oWmlfW4e3XUObBBUHcxzy
	 jY4bzWxk7u3D8NVuZ3o0fwAOe8RZQuUzqS7HcitEEYV+GS1nYBtnHfIuNqOzM4WxjJ
	 K6e+gyw324kVySOOkNMa0c+Ha/tBl0BOs1XOW/TOwGiabQLSsI8KsIAJ9V+OdWLMAk
	 3btPXO3bpZUqQ==
Date: Mon, 27 Jul 2026 11:08:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vincent Cloutier <vincent.cloutier@icloud.com>
Cc: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vincent Cloutier <vincent@cloutier.co>
Subject: Re: [PATCH v4 11/11] dt-bindings: power: supply: max17042: Allow
 generic power-supply properties
Message-ID: <20260727-precise-therapeutic-bandicoot-b07fe6@quoll>
References: <20260727011319.621794-1-vincent.cloutier@icloud.com>
 <20260727011319.621794-12-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727011319.621794-12-vincent.cloutier@icloud.com>

On Sun, Jul 26, 2026 at 09:13:09PM -0400, Vincent Cloutier wrote:
> From: Vincent Cloutier <vincent@cloutier.co>
> 
> The MAX17042 family binding references the generic power-supply schema,
> but additionalProperties only recognizes properties declared directly by
> this schema.
> 
> Use unevaluatedProperties so generic properties such as monitored-battery
> are accepted while unknown properties remain rejected. Remove the local
> power-supplies declaration because it is already inherited from
> power-supply.yaml.
> 
> Assisted-by: OpenCode:gpt-5.6-sol
> Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
> ---
>  .../devicetree/bindings/power/supply/maxim,max17042.yaml      | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

