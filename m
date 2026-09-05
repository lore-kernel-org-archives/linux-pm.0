Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA5E555;
	Sat,  5 Sep 2026 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788576194; cv=none; b=nFZdrgH+qZKqqGo0mmF1ee3jN0MzzaCVQTdWLIkaz3uz4YiObrQD7ddENMY9vLvmSrVFXMiW84TCpoDAYBtCif5KxAn6w0eHsHAzIPLZhd5FTu0a725+vSOTdZ8yLP/Oulk4/jJ3dsFSRfltnyMlzLZanBIr4zcEb1vT+eNrQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788576194; c=relaxed/simple;
	bh=NL8wV8udqlC0jqepGrOVGRPBMbJC+8YDHNSdM38TSag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNWnR19a71uVlBjIlGLRtrwVgJpscAdAd4PQf9jAguzZfskPGeEqITn9b6U8L8DerwWkHEYJKs7Cclt22r2E837XsdyRCUutt2wFSpFs/k0id8i1mySEXiIWAcS4Poe5DwBjdcpxgIARVpVaMhoLeuJeQTQxNmOxAklz2it/oVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BKm5LAr8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BKm5LAr8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=uMhkbPNUPP0/5xSmauZOIhML0VJtIhTIbKixDca73dM=; b=BKm5LAr80SqIJKWhCgnKyS9q0Q
	iW+jnoG1mNz6HNDv7+OHwKG+/VNU49s+8NcgEwQ0DuRZoqLokxC6IqmK+PDc68xAuMxUPk5NXYX0G
	/0pccZp4eAGEl8BQVoYvv5023ZWsxSoeab/sdsl+DWR9yhQ9iEWMb1A+mTGnibpM5jLS5z+869sJd
	Z5OyOyZeLb/gNMoWO/FoEMULdFAlAtpUcP12aKYsznf9IcPa2+pyxKtM60oNdrq/G8hZws838lzHJ
	Q3xjGU7V/mUObOQFBk3q6PJf3w7f7IwbWX6HoZfpPL3DsApvmWRMdbaxk14awIQITXrb14PtxQsVy
	bp5vpUPQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2gN4-00000003buX-2FGw;
	Sat, 05 Sep 2026 02:43:10 +0000
Message-ID: <5b107a2b-743d-43af-9fbe-32e2d0cc4301@infradead.org>
Date: Fri, 4 Sep 2026 19:43:09 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp
 documentation
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260905010706.57380-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905010706.57380-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/4/26 6:07 PM, Karl Mehltretter wrote:
> The amd_dynamic_epp command-line parameter was removed. Dynamic EPP
> is now selected through the per-policy energy_performance_preference
> attribute, which is already documented.
> 
> Fixes: 32692fcf61ed ("cpufreq/amd-pstate: Remove "amd_dynamic_epp" cmdline and "dynamic_epp" sysfs")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 -------
>  Documentation/admin-guide/pm/amd-pstate.rst     | 6 ------
>  2 files changed, 13 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4a12805a50ba5..1fa37bce5bb3a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -499,13 +499,6 @@ Kernel parameters
>  			disable
>  			  Disable amd-pstate preferred core.
>  
> -	amd_dynamic_epp=
> -			[X86]
> -			disable
> -			  Disable amd-pstate dynamic EPP.
> -			enable
> -			  Enable amd-pstate dynamic EPP.
> -
>  	amijoy.map=	[HW,JOY] Amiga joystick support
>  			Map of devices attached to JOY0DAT and JOY1DAT
>  			Format: <a>,<b>
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 6fd72ba52df20..4c5d3d8acf645 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -481,12 +481,6 @@ For systems that support ``amd-pstate`` preferred core, the core rankings will
>  always be advertised by the platform. But OS can choose to ignore that via the
>  kernel parameter ``amd_prefcore=disable``.
>  
> -``amd_dynamic_epp``
> -
> -When AMD pstate is in auto mode, dynamic EPP will control whether the kernel
> -autonomously changes the EPP mode. The default is disabled. It can be enabled
> -with the kernel parameter ``amd_dynamic_epp=enable``.
> -
>  User Space Interface in ``sysfs`` - General
>  ===========================================
>  

-- 
~Randy
