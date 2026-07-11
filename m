Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401D370AC1;
	Sat, 11 Jul 2026 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755897; cv=none; b=sZcGBPu/xXgq21JWtfK5o15Wl8nXkF3euW2vZI/42qKCeLA2qXXqKTXqwLUGXiK9uBM3oLykA8S+MTzetavhUsDaDMAGJ1NvjiUVJksv1+UX6BePANigz3+Mpoj7wxcjJfmnG5t80AqF3YzTbJBQzvrUHyoHjtx4mQonGgSdSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755897; c=relaxed/simple;
	bh=d1wJBJqnREdRO7uXVxi9cJLsD9w8TM/w6IYXPOaXiVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3oC6MjNGGsFPrcvKUxaf1VItLDksF94O110/nTLh0Dzcl/q8Hk0owRmUt0BWEiZQHA8f793j9K3eJk8V1xZxVJ30UPiEHUtckbpUqOFDXbbzqhLf+XJMxESRPv9xXrrgf9hdS5aTSUh5REA9c9nORUteCk/MEneTSriikphNmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek28vN3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek28vN3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ED61F000E9;
	Sat, 11 Jul 2026 07:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783755896;
	bh=b0CpmOWLm2vb+ALVgOzFuf2ikhKbi8vr3l51aLzsp4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ek28vN3IHp2WFK7uen+eCu8vrfSzkYl6XFS2Rgqux3Rwn3djoDjd+uFzkKG6FPo+7
	 PxeDmXVumlVj7ghYyfjp4i5Kq+n+Qg/rcRq0pd3YQ1tXUl25x87uvRgfGnd5yJ5v9t
	 Vk0uGNFeFlRKtN8PaFNCykAhv1Hq3XL3AvGdeH3cdr/dyXnAqTVbA6ZViyStlTsCE6
	 0IsWM2TSev3ruqOuFIpihZTiBT7edbqkdhpPN6gPjsYAA2sStd5CfR2r2RjWa6PG/7
	 TK8T37e1P1aRUF/KQxyirmS0smYjrftZEBJG5/FB+U1uXMp6D5Hh+aQlrjXoeYeMI5
	 b+/eeiBJCKGcg==
Date: Sat, 11 Jul 2026 07:44:52 +0000
From: Yixun Lan <dlan@kernel.org>
To: Shuwei Wu <shuwei.wu@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
Message-ID: <20260711074452-GKB36656@kernel.org>
References: <20260626-shadow-deps-v4-0-bba9831f2f1d@mailbox.org>
 <20260626-shadow-deps-v4-2-bba9831f2f1d@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260626-shadow-deps-v4-2-bba9831f2f1d@mailbox.org>

Hi Shuwei,

On 16:10 Fri 26 Jun     , Shuwei Wu wrote:
> Add CPU clock properties and OPP tables for the two CPU clusters in the
> SpacemiT K1 SoC. The OPP entries use voltage ranges because the CPU
> supply is shared by both clusters.
> 
> Enable CPU DVFS on Banana Pi BPI-F3 by including the OPP tables and
> wiring the CPU nodes to the CPU regulator supply.
> 
> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>

Looks good, thanks for working on this

Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
