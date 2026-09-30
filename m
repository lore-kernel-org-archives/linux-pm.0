Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66923C1405;
	Wed, 30 Sep 2026 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768840; cv=none; b=KjvucYhTxX3mlp4m5/DSLPIDFu1Dvgo1AU+YukrJgSr87jWIrnEJT5eEMpibDmr8np+MvDnVcX/YrqZ9dp0xPCNuJD9eXlirFfWba+TE+3JlkT0gnIhdJIEw0DtUbfq0IeO7IrTXMQSoHIXpu9TzHRrXZDGwMm5D+6gLoW1QCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768840; c=relaxed/simple;
	bh=FssAwRoqSqR1k/RHM03ng/v5J6nM5wfY1iPLRHThTOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDRma+P4HK89py2XdQDpjV+LizlahH+MywH0miN0tFCyoiAOceQENB/sPYHy3WrLN7Wd/7oAtaM5LzxLMSuV6QxtSoZGjQy/ZjfmawtfUTRD7BfKH6/2029ucMb7xC/WpJSNOUyptwWK6aS1+9RkNDj/tjz5bFu3fmVc8+YgNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q07wbSjE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q07wbSjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0201F00898;
	Wed, 30 Sep 2026 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790768837;
	bh=f+H8Kg68nVhx6dtUfaMKJGO0vp0CyK/Fr5IyBgo7Aro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q07wbSjEcLzVhHACNVpAkohD2c9bZOiBMrtMMpiQbRbxQW7DSWJhgnfKsT/M8aNtw
	 2ESLDoVIu1vC4boi7Yv32mgcN5LT4aqPCL3gsTvUUD0NE2nlsbV7Z371LVVjHlB2Jy
	 x87MQ8x67YHtq5Up1116zQMZnnewgS69K616Al7HWUq2gOVfSbRjobOA7E9ox2LPY/
	 uB0tDdUhLvPdPkISFfuOUwaMhcsZvMG2SOViNIJr9HmmUAgIhtyndIr/lxRlF8nP0O
	 xLbZwPl9X7PT00v1E5UutbwrQBWHKYhhCzKjFZhJ5oy1duXeMkq9FBi8NrXctBNZLs
	 ANXmrv/Mxu26A==
Date: Wed, 30 Sep 2026 13:47:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: power: reset: syscon-reboot-mode:
 allow supplies
Message-ID: <20260930-fascinating-cheetah-of-speed-7cccd0@quoll>
References: <20260929-b4-rk3576-reboot-mode-v2-0-5a34ca72065a@flipper.net>
 <20260929-b4-rk3576-reboot-mode-v2-2-5a34ca72065a@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929-b4-rk3576-reboot-mode-v2-2-5a34ca72065a@flipper.net>

On Tue, Sep 29, 2026 at 02:28:19PM +0400, Alexey Charkov wrote:
> Whatever program that acts on a reboot mode runs before a full OS, so it
> may lack the capability to enable the regulators it depends on, and a
> reset that preserves the mode register generally leaves the regulators as
> the previously running system left them.
> 
> Allow a reboot mode node to name such supplies, so that they can be
> turned on while the mode is being requested.
> 
> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

Again fake tag.

> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml       | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> index 79ffc78b23ea..5ed70c87269e 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> @@ -36,6 +36,14 @@ patternProperties:
>    "^mode-.*$":
>      maxItems: 1
>  
> +  "^[a-z0-9]+(-[a-z0-9]+)*-supply$":
> +    description:
> +      Supply that has to be powered for whatever program acts on the mode.
> +      That could be a boot ROM with no access to regulators, and a warm reset
> +      leaves them as the previously running system left them and not necessarily
> +      what their expected out-of-reboot state is. Any supply described here is
> +      enabled when a mode is requested, and stays enabled.

This looks like workaround for missing supply handling in actual
consumers. Fix your devices instead.

Best regards,
Krzysztof

