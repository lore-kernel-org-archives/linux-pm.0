Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B339A056;
	Thu,  5 Mar 2026 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724993; cv=pass; b=f87eLMJytXh7qVko3DIfekrKoU/p3Qln6iQaw7UmK/2A5sDII0PszbQdNXPMrGR28I8h3KvfF6t2u2kwgrv04XU4pJD/rDYSV1dYstSQ7cvBXgjgEnkUOoTXPzx9pnB3oKCd5AvXe9BpwciAi70UylesQvSLQVeipLJyiaOoZMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724993; c=relaxed/simple;
	bh=wmnmDfTn/TYB5r9+aoFlgGXAOsYfaNsnulGAJHZflIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0u2AzlF+MMdfh+Zo8alKw5cAQhA9Cn+cwRWtVExvrPfKoWLFbb9EpLep/uzUjHhSs+gN6wFfQ5NhTV76170dMc9IBSrgdux9vAKhOdpzMUelPvjd7ksDkCdsnCNYDZNRDN8kCDo7ZxscMP97VHk8jLPqtrZTGpetZJTDVg9YkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=JqG9rNmv; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="JqG9rNmv"
ARC-Seal: i=1; a=rsa-sha256; t=1772724952; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AUBV+8s6Fr6W2Qv8QMVoNGT2ebVnAQO7jNW0DVQI0T2a/VxA0BAt/OfsL9fu5oahN8anQHCL67IhWH7+d/V0JSb+UmYsxUTD7KrEPUsdcXiX47bHDrIO5P6HQRZ336C7DldHPPMOyhZdn3akF4kzGSZsENorEDpJWLfqx/CuBSM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772724952; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QetOvITxHtYsRZdgk4oF96+qwijXoc1Q8T2XTInT1bU=; 
	b=JRI+jqMJPI3KNTamlXKKMWt3vmxRLnPH3tAVBH+oRkCkNfoCZRz8gQMXMloPJ1KXSq+HwNJDtm+KPE0KehCEuOaEQQRPFhapx+YuaGuHCWAy9udNk0VVjCSWID27C0UWWPRKNX5858583XdbgdAVlnC5XDFBlLsswDNX3tRPslU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772724952;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=QetOvITxHtYsRZdgk4oF96+qwijXoc1Q8T2XTInT1bU=;
	b=JqG9rNmvuoHb1bv0RbxH79bpE2Si3hAPPbHP//SqKU4QMqkLc14oHuHEKfF3usha
	BPYfhbWCtPjrAtw7X/czJFdaemmoqoLrFg3CE1Mxq35dSniV2xqmf4xR5WFJf79MzVa
	a9f+LwpHEjG/nv5mhTF3uOZhkAQH1mAH4/7Nc5m4=
Received: by mx.zohomail.com with SMTPS id 1772724948845222.5524650203689;
	Thu, 5 Mar 2026 07:35:48 -0800 (PST)
Date: Thu, 5 Mar 2026 15:35:39 +0000
From: Yao Zi <me@ziyao.cc>
To: Shuwei Wu <shuweiwoo@163.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] thermal: spacemit: k1: Add thermal sensor support
Message-ID: <aamiy3IEqjTZQz2R@pie>
References: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com>
 <20260119-patchv2-k1-thermal-v3-2-3d82c9ebe8a4@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-patchv2-k1-thermal-v3-2-3d82c9ebe8a4@163.com>
X-ZohoMailClient: External

On Mon, Jan 19, 2026 at 10:41:22AM +0800, Shuwei Wu wrote:
> The thermal sensor on K1 supports monitoring five temperature zones.
> The driver registers these sensors with the thermal framework
> and supports standard operations:
> - Reading temperature (millidegree Celsius)
> - Setting high/low thresholds for interrupts
> 
> Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
> ---
> Changes in v3:
> - Align multi-line assignments as suggested by reviewer
> - Remove unnecessary variable definitions
> 
> Changes in v2:
> - Rename k1_thermal.c to k1_tsensor.c for better hardware alignment
> - Move driver to drivers/thermal/spacemit/
> - Add Kconfig/Makefile for spacemit and update top-level build files
> - Refactor names, style, code alignment, and comments
> - Simplify probe and error handling
> ---
>  drivers/thermal/Kconfig               |   2 +
>  drivers/thermal/Makefile              |   1 +
>  drivers/thermal/spacemit/Kconfig      |  19 +++
>  drivers/thermal/spacemit/Makefile     |   3 +
>  drivers/thermal/spacemit/k1_tsensor.c | 281 ++++++++++++++++++++++++++++++++++
>  5 files changed, 306 insertions(+)

Though I don't have the time to test it on my K1 board, the driver looks
good.

Reviewed-by: Yao Zi <me@ziyao.cc>

Thanks,
Yao Zi
