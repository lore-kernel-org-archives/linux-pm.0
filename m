Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009042B728;
	Mon, 27 Jul 2026 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184973; cv=none; b=mD28x9sY57POnE9z7kZsfWl16PMM0fAVhIN0QhEF3y5iTL5BfSBr/eR4MD1Yq7HmbYD8tGl7eAF2Yt7IM1N11HzC37iFUg7mLIPvystNLECU/27jRr1FI7hUEDMNG6qYL9uTDNWp8cnWI5S7irDv7zkTG+dU1G6vbk4VWtvLaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184973; c=relaxed/simple;
	bh=CnZw60aN40UE7gn1aCrL/l/UUpPdhORKebRsWJFJq7I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k/J58dK4+ukVGv8tIMy7WaEHaG7etQFdtf5qNLtFOZVlziGUs+YLaLKr5R0WS0mYnCN1eDgTvDcdLs7HCGojERMeozcvy4hf4f2ig/lj3QkZk3CUhhVAJUK5il4UwPsUyOvxI79lW1Tc+1wPOOS93vbMi0h4OGwJjmLIJjHbVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BC61F000E9;
	Mon, 27 Jul 2026 20:42:51 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id AEFDC18090B; Mon, 27 Jul 2026 22:42:49 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Vincent Cloutier <vincent.cloutier@icloud.com>
Cc: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Cloutier <vincent@cloutier.co>
In-Reply-To: <20260727011319.621794-1-vincent.cloutier@icloud.com>
References: <20260727011319.621794-1-vincent.cloutier@icloud.com>
Subject: Re: [PATCH v4 00/11] power: supply: initialize MAX17055 from
 battery info
Message-Id: <178518496968.34440.14212828403765826609.b4-ty@collabora.com>
Date: Mon, 27 Jul 2026 22:42:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 26 Jul 2026 21:12:58 -0400, Vincent Cloutier wrote:
> From: Vincent Cloutier <vincent@cloutier.co>
> 
> Hi,
> 
> This is the remaining unmerged tail of the MAX17042/MAX17055 v1 series.
> Six v1 patches are upstream, and the v1 cleanup patch is covered by
> 699f0f71ac98. This revision retains the requested registration callback
> architecture and splits the MAX17055 driver work into smaller steps.
> 
> [...]

Applied, thanks!

[01/11] power: supply: Add registration init callback
        commit: c1eb5905fdce35a66173658a93819641e5220c18
[02/11] power: supply: max17042_battery: Separate MAX17055 initialization
        commit: f05e30fd2ffd962e6f30dc0abd528b4182ecdf4b
[03/11] power: supply: max17042_battery: Use bool for init_complete
        commit: e8e7cdd9ce46a763e5428e2673e90c6a5f91f6d8
[04/11] power: supply: max17042_battery: Convert initialization to delayed work
        commit: 01da1f4a6373f8d6a5a2d5d5adc256431087ccc4
[05/11] power: supply: max17042_battery: Propagate status register errors
        commit: 98d02b5128833c3d812e62a2616f33f1524c8394
[06/11] power: supply: max17042_battery: Retry failed MAX17055 initialization
        commit: fc9ff915b1fb6f6f826953d1bef3087d7a489d65
[07/11] power: supply: max17042_battery: Program MAX17055 EZ Config values
        commit: 6f384023851d67bd242bf40e5a91328eb92edb5d
[08/11] power: supply: max17042_battery: Follow MAX17055 POR sequence
        commit: 111a2d606a493c3b2f03864ea34a29df3a9e7c06
[09/11] power: supply: max17042_battery: Initialize MAX17055 from battery info
        commit: ed2b9b4b9694239f9a39f3e5087d879f5e37e315
[10/11] power: supply: max17042_battery: Honor MAX17055 charge voltage
        commit: 6a376b843d937d2330b0111404b62589236620c1
[11/11] dt-bindings: power: supply: max17042: Allow generic power-supply properties
        commit: c84ccde22d9d3070a9ee144e825270a7a784c570

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

