Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FECB3ACEE1;
	Wed, 19 Aug 2026 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121528; cv=none; b=AnppHedl5Schv+Hvt0UK+Ij6u0fx5hmBF5UDQgi7e3nlNHcGgn1TT2/5EF0/hqHNodvrGMLH+cxIH2m6T7pOOJHCVaz4lzJzoyf2dti6bb/75NWBnK4eNiW1oZfxsDw3lSZZzKG1bOZlLVc6/wO06tMrx3ZmxJMGlCxGpsWVGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121528; c=relaxed/simple;
	bh=q3M+NLGhCyrfwRoUllq7jvqoNYe3AiSe6gjhhb6Ku7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnDsNP/zB//i9UVGAvXY3hHYoLIMNn2VVjv6QT7U+pu66jv4pC/uKPgQtr7HphpKXo57SSAfbMrY9eHe500vA+WQaAFsEkE2gfVKXZYoyLHHUetVANncgguJEHEmHtyOptBp2AmkUSMc0tXXRBtbymkl+xCQo6SwJtrat0vezHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFaWnQ47; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFaWnQ47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE681F000E9;
	Wed, 19 Aug 2026 06:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787121526;
	bh=VsaOWXo617LVvuY+1agTB1JwIOC3wo5kH0giCyQPBVY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hFaWnQ47cGpWn6CG/+qsvTTg+bw+dZwzvpEoXIqi7VfHpFoEQBA4ixdtiwVcExjjU
	 1H7R74STt9C/6SLR8Vq0rnUovB39pKPCoyqt7eUE81I98NepEQuC04ESa5dB3oaYg0
	 1bEYZAVaf+3Ucqo+E8qkXVyirqGDYauLr8tsOYs+itA6s3EYLd0uRuevIj6XBGSHE+
	 28B00lyCCOJi9b3HkrQuX+sWJ/ACAf8pTJJoPbBHYk/GAK1qKkDNSXp89ZFgzRvB9X
	 LBz5XdDwZTqVQtN8nJxVppVaiDZesspfoiEK6An3HoZB38XcOgJ6kyo7Rl3kAgkHT0
	 cu5Q4znZWqCdg==
Message-ID: <7a580bae-13e7-46b7-af70-e4662973166b@kernel.org>
Date: Wed, 19 Aug 2026 09:38:43 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] interconnect changes for 7.3
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260810145047.422910-1-djakov@kernel.org>
From: Georgi Djakov <djakov@kernel.org>
Content-Language: en-US
In-Reply-To: <20260810145047.422910-1-djakov@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/26 5:50 PM, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v7.3-rc1
> merge window. As always, the short summary is in the signed tag.
> 
> All patches have been in linux-next for more than two weeks. There
> are no reported issues. Please pull into char-misc-next when
> possible.
> 

Hello Greg,

Just checking whether this is still in your mail queue. Please let me
know if anything is needed from my side.

Thanks,
Georgi


> The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:
> 
>    Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-7.3-rc1
> 
> for you to fetch changes up to 9621c81fd2eb7db4b647814b7b6e537744831e60:
> 
>    Merge branch 'icc-misc' into icc-next (2026-07-22 13:51:41 +0300)
> 
> ----------------------------------------------------------------
> This pull request contains the following interconnect updates for
> the 7.3-rc1 merge window:
> 
> - New driver for Maili SoC
> - Add support for QoS on the SC8280XP SoC
> - Add support for QoS on the x1e80100 SoC
> - Add EPSS L3 scaling support for Shikra SoC
> - Add COMPILE_TEST support for some platforms
> - Misc tiny improvements and fixes
> 
> Signed-off-by: Georgi Djakov <djakov@kernel.org>
> 
> ----------------------------------------------------------------
> Georgi Djakov (5):
>        Merge branch 'icc-sc8280xp' into icc-next
>        Merge branch 'icc-x1e80100' into icc-next
>        Merge branch 'icc-shikra' into icc-next
>        Merge branch 'icc-maili' into icc-next
>        Merge branch 'icc-misc' into icc-next
> 
> Kuan-Wei Chiu (1):
>        interconnect: Fix use after free in icc_get() and of_icc_get_by_index()
> 
> Li Jun (1):
>        interconnect: debugfs-client: add NULL check for platform_device_alloc
> 
> Raviteja Laggyshetty (6):
>        dt-bindings: interconnect: qcom,x1e80100-rpmh: add clocks property to enable QoS
>        interconnect: qcom: x1e80100: enable QoS configuration
>        dt-bindings: interconnect: qcom,osm-l3: Add EPSS L3 DT binding for Qualcomm Shikra SoC
>        interconnect: qcom: Add EPSS L3 scaling support for Shikra SoC
>        dt-bindings: interconnect: qcom: document the RPMh Network-On-Chip interconnect in Maili SoC
>        interconnect: qcom: add Maili interconnect provider driver
> 
> Rosen Penev (2):
>        interconnect: qcom: add COMPILE_TEST
>        interconnect: qcom: simplify allocation
> 
> Xilin Wu (2):
>        dt-bindings: interconnect: qcom,sc8280xp-rpmh: Add reg and clocks for QoS
>        interconnect: qcom: sc8280xp: Enable QoS configuration
> 
>   .../devicetree/bindings/interconnect/qcom,maili-rpmh.yaml      |  127 +
>   .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |    2 +
>   .../devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml   |   99 +-
>   .../devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml   |   72 +
>   drivers/interconnect/core.c                                    |    7 +-
>   drivers/interconnect/debugfs-client.c                          |    2 +
>   drivers/interconnect/qcom/Kconfig                              |   12 +-
>   drivers/interconnect/qcom/Makefile                             |    2 +
>   drivers/interconnect/qcom/icc-rpm.c                            |    7 +-
>   drivers/interconnect/qcom/icc-rpm.h                            |    8 +-
>   drivers/interconnect/qcom/maili.c                              | 2091 ++++++++
>   drivers/interconnect/qcom/osm-l3.c                             |   16 +-
>   drivers/interconnect/qcom/sc8280xp.c                           |  356 ++
>   drivers/interconnect/qcom/x1e80100.c                           |  485 ++
>   include/dt-bindings/interconnect/qcom,maili-rpmh.h             |  171 +
>   15 files changed, 3442 insertions(+), 15 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,maili-rpmh.yaml
>   create mode 100644 drivers/interconnect/qcom/maili.c
>   create mode 100644 include/dt-bindings/interconnect/qcom,maili-rpmh.h
> 

