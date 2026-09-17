Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1DE3CDBD3;
	Thu, 17 Sep 2026 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671849; cv=none; b=sptVEhH8OcU8FOUIaMFec1obKY2dlQAw7r+KZ2PZPcrSpjVpBZWD6dBLfryt4zFjiZ1VznwLZCYWO6YaMA8/JnLvb83MBp5LK7wVGky2bqEQ6JnxTkj11osgG02DgAYHdxBSh8awopvikH+X6WBpubL74zI3nPQ3cV0H1CFIB94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671849; c=relaxed/simple;
	bh=tCosBkLYGEEsi74OqSOrc66diUULUxKBq3+Wh50tyjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB2CvTaSAO/x5LrFDjnH1sopLgKM3GmFLreCIBTw2jViAsSBGXFODUq8LCyy+2CjiSxt/UoSOd3us1s3VU7j5U7570YepuTATK9Yr6kVQFnZP2IpRVov72gjtM6u138eXkeOQGt9CQ885Rz++u1uMrU4DlNtbbyo1AZNwKQi8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k48NjLkH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k48NjLkH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E801F000FF;
	Thu, 17 Sep 2026 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789671847;
	bh=gzQp6LW1nXvwBEwBhGNPe+tNOASC0dgPxppHtMaIJkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k48NjLkHVhtOalPBGpW0mEiCAI8LrDMLOLiZZXWRnf6WbeYW47QCVsuZaVq3BD6PS
	 XUj//7Wh+NEwRa44zMB7p+gOfG4tMr0K9Fi+m735eHJ7v8M139VmX1Ri7YIcA5LtVY
	 ZryHyhQrvuiNZ9NBiopiVKxfWj4eRtwA6+AkAWaHss8V28snEBfZgiA9uQUpOQzN6+
	 s+JLhtI68GSF75d1C8CD9Hr3S8EOcR+AZuNZPLVqFyJDUEdOmja5kkOxJb6PrtMtNZ
	 oWIryW6xoOLDS0OV5YGZqloxJtvl0jkE/QfLDaQQM5e6sEcdSvaYVuoEHIJWaEiQwD
	 oecVv3ZxWaUbA==
Date: Thu, 17 Sep 2026 14:04:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Suman Anna <s-anna@ti.com>,
	Samuel Holland <samuel@sholland.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-tegra@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
	linux-sunxi@lists.linux.dev,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mailbox: Delete old 'mailbox.txt'
 bindings file
Message-ID: <178967102478.3104808.16225171904149470188.robh@kernel.org>
References: <20260814124603.v2.1.I8b3ff71c528133e7d6f81fe926fa39e6451d63fd@changeid>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814124603.v2.1.I8b3ff71c528133e7d6f81fe926fa39e6451d63fd@changeid>


On Fri, 14 Aug 2026 12:46:12 -0700, Douglas Anderson wrote:
> As per mailing-list discussions [1] [2] [3], we want to delete the
> following old file from the device-tree bindings that live in the
> Linux kernel git tree:
> * Documentation/devicetree/bindings/mailbox/mailbox.txt
> 
> The old .txt file did have some descriptive text about what some of
> the properties meant. Those have been added to the dt-schema
> repository in a pull request [4].
> 
> Also remove dangling references to `mailbox.txt` across all remaining
> device-tree binding documentation files.
> 
> Link: https://lore.kernel.org/r/20260722140214.GA548057-robh@kernel.org [1]
> Link: https://lore.kernel.org/r/dc7a2041-50a4-482e-9930-566bb3fd1e72@kernel.org [2]
> Link: https://lore.kernel.org/r/CAL_JsqKVjQ2m-dzMUENQry-f_YE9QrYSOKoH9CPj1gjj8XkPRA@mail.gmail.com [3]
> Link: https://github.com/devicetree-org/dt-schema/pull/202 [4]
> Cc: Sudeep Holla <sudeep.holla@kernel.org>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Lee Jones <lee@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> - v1: https://lore.kernel.org/r/20260804133801.1.I8b3ff71c528133e7d6f81fe926fa39e6451d63fd@changeid
> 
> Changes in v2:
> - Remove dangling mailbox.txt references as per Sashiko.
> 
>  .../firmware/nvidia,tegra186-bpmp.yaml        |  6 +-
>  .../mailbox/allwinner,sun6i-a31-msgbox.yaml   |  3 -
>  .../bindings/mailbox/altera-mailbox.txt       | 12 ++--
>  .../mailbox/hisilicon,hi3660-mailbox.txt      |  2 +-
>  .../mailbox/hisilicon,hi6220-mailbox.txt      |  2 +-
>  .../devicetree/bindings/mailbox/mailbox.txt   | 60 -------------------
>  .../bindings/mailbox/ti,omap-mailbox.yaml     |  3 +-
>  .../power/reset/xlnx,zynqmp-power.yaml        |  9 +--
>  .../bindings/soc/qcom/qcom,aoss-qmp.yaml      |  2 +-
>  9 files changed, 15 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/mailbox.txt
> 

Applied, thanks!

