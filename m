Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460416;
	b=jRz3t3sfp4Rsv/bzNHNm2kE6H8H/72CWma/a8pw4FknMfQmes2EnFNwNVe3RM9rYelll
	 n3Whd/tI1LvVtpwNT9LOErLXr4a/TilieneMTwSacHYP8jGaurfT7pWdtBjEry1YJr7xK
	 +9PJeRX/X6iY+zUMWgjSxYUhUHVuYmku2qQbffhgA1uJpOgriWbLsMJG8xX6l1vapdEEH
	 nikzurjP4cKaVmx2P4MFKlWXXLYtPvHEylW2+YD/SUK/7/R7AMk2sXPU0XmXjKQDt6mdi
	 ugwAd34eDVmIoGLSfE57sapAhTn5l2wb6yKx2eh+KmXounWB4+4Xtje0UB0fSPnWlYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460416;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cRUDGnLfO0bI/ZKYLMo/IPOSFBGiK0gdMvTEjCrwYl8=;
	b=xK7Sp05FT6QufObuEi6xWyqP2tVmVrDQEaDImXn/LYJQjQ3bfeH3XkgM/Hqzk68APGIr
	 PjUTQREVyEUIeQvJEx/QQ0uetc/RGoKqHK+lCAgk9In1XFbZ/DLm0J1jHWwbFtMcHQLBD
	 yFwkw6rNiODoMWtPRKPGmG3G4RpGQRUL3BSe1sCnClAnwy8UpxJixYgW4/dImwO6TqICI
	 mxf54djZ0U9k1ydFhuFcxuxoamORZ9Avt0PTZPbF7NuopxIO/oJsGKD3f+6Z5e2QP52Dj
	 2N4vOB6sFE5QUuNXh4A+QIDMr940ILr5IHHVbCT46+WICcrm66gLXIiNeS8TthIX9EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56A3606A321;
	Thu, 12 Nov 2026 05:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A56A3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ca2f8160de5711f19a56ed5b684f684d-20261112
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:5fdecb04-0666-42c4-9ebb-c02f989342c4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:68529bbf875d0f11b69a9fa443e77b28,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|52
	|99,EDM:-3|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ca2f8160de5711f19a56ed5b684f684d-20261112
X-User: luoxueqin@kylinos.cn
Received: from [10.42.13.56] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoxueqin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 766716511; Thu, 12 Nov 2026 13:13:26 +0800
Message-ID: <c6227bc2-beff-40f0-a76f-f2e296de5081@kylinos.cn>
Date: Thu, 12 Nov 2026 13:11:43 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] arch_topology: Add topology_update_cpu_capacity()
 for runtime updates
To: kernel test robot <lkp@intel.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, sudeep.holla@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 zhanjie9@hisilicon.com, christian.loehle@arm.com, zhenglifeng1@huawei.com,
 sumitg@nvidia.com, lenb@kernel.org, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, gregkh@linuxfoundation.org, dakr@kernel.org,
 johan@kernel.org, ionela.voinescu@arm.com, pierre.gondois@arm.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
 driver-core@lists.linux.dev
References: <20261111085022.1229866-4-luoxueqin@kylinos.cn>
 <202611120358.5eM3xOiA-lkp@intel.com>
Content-Language: en-US
From: luoxueqin <luoxueqin@kylinos.cn>
In-Reply-To: <202611120358.5eM3xOiA-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the report. Fixed: the mutex is now defined inside the
CONFIG_ACPI_CPPC_LIB block, next to its only user, so ACPI-less
configs no longer warn. It will be folded into the next revision of
the series.

在 2026/11/12 03:30, kernel test robot 写道:
> Hi Xueqin,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on driver-core/driver-core-testing]
> [also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v7.4-rc2]
> [cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge next-20261110]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Xueqin-Luo/cpufreq-cppc-Add-update_limits-support-for-Highest-Performance-changes/20261111-165020
> base:   driver-core/driver-core-testing
> patch link:    https://lore.kernel.org/r/20261111085022.1229866-4-luoxueqin%40kylinos.cn
> patch subject: [PATCH v6 3/3] arch_topology: Add topology_update_cpu_capacity() for runtime updates
> config: arm-defconfig (https://download.01.org/0day-ci/archive/20261112/202611120358.5eM3xOiA-lkp@intel.com/config)
> compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project e73e336290028f26553b46c9fba844c13da38c9c)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261112/202611120358.5eM3xOiA-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202611120358.5eM3xOiA-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/base/arch_topology.c:232:21: warning: unused variable 'raw_capacity_lock' [-Wunused-variable]
>       232 | static DEFINE_MUTEX(raw_capacity_lock);
>           |                     ^~~~~~~~~~~~~~~~~
>     1 warning generated.
> 
> 
> vim +/raw_capacity_lock +232 drivers/base/arch_topology.c
> 
>     230	
>     231	static u32 *raw_capacity;
>   > 232	static DEFINE_MUTEX(raw_capacity_lock);
>     233	
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

