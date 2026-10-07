Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851E41A794;
	Wed,  7 Oct 2026 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407870; cv=none; b=tKW15Q1G1cuiRWN7YPBSGCNvAn2RqIjt/SXLoHTj4i9Q7IaSiH1E+aI1lXek22Th0+NA0TMAiBhHGbfcqCyq1ST1vz2fsHsh+Av0Xt6KRtACNY3pf2jLGHskB93XtvPkwzKnBOfhGvypj7q5Bs7l2PrFrgHFiOufTKPyZb2zE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407870; c=relaxed/simple;
	bh=55Ks3FygOg+DqqDVoz59doJead/xC4AoL3QtxHT/s50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmsa5lXPrAWd00a0TvKMsj/SJuA1ecHk601U6TFXU2myx3CwrkJQ2uVEKd+J2s6f3IuAhJVpcTFiLlD3PawW9IjJLcjgHqrrqITxawFOjbjKNB//YjgGmx4xd8W8JPnR2dxlGJfQlSSrahGqWoVvsAzjaU7JhO5+E0Z7SGJibcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMa8U76n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMa8U76n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128C01F000FF;
	Wed,  7 Oct 2026 21:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407869;
	bh=VFF3LPZl8ZhJEd5YpwT/YjFiCZO7rblB8TxKAWBvQ6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZMa8U76nE2tvAbtN7nHxioC57XLL5twQGg4tccenKDGDDn5R3Es3UZ0hyAMvIdL13
	 KJNLYufm9K9g96mSDU2pn0QSubXw3NvV4UgdHZBnjJQibEvrHCAyDekJmCoNKBj1T3
	 jfeQyqomiGBI9XTzyXESwdrYSuWqBgrxeqI01o2K500AizVBSOD/7Vpn4liO81/pNc
	 DyNiLFhNnR2iRkxIY5Sy6XP5J3r9ny/XLd4bnMPf/j2k/bsSwrL1SpeACwuSGeYkcW
	 UtD8CVZMj2fQ5IsQrH/nRidHTmwgfzNgLmgdWRv032HrfTCkQxpA7CB+UY6omt0cN4
	 bUDqc19pAMMUg==
Date: Wed, 7 Oct 2026 16:17:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: soc: rockchip: add boot ROM download
 boot mode
Message-ID: <179140786784.381047.12884810066150774616.robh@kernel.org>
References: <20261006-b4-rk3576-reboot-mode-v3-0-6edba064693b@flipper.net>
 <20261006-b4-rk3576-reboot-mode-v3-1-6edba064693b@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-b4-rk3576-reboot-mode-v3-1-6edba064693b@flipper.net>


On Tue, 06 Oct 2026 20:02:39 +0400, Alexey Charkov wrote:
> Rockchip boot ROMs enter USB download mode, commonly known as maskrom,
> when they find 0xef08a53c in the register they take the boot mode from.
> Add the magic under the name U-Boot already uses for it, so that boards
> able to request it can do so symbolically.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  include/dt-bindings/soc/rockchip,boot-mode.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

