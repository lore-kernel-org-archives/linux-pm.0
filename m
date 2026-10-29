Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289916;
	b=gAbRMkk515X3ef/SK681oW1exh4O4s2dDHx47YFaCYeorxKyIG9E1oNxavGQdbr4aQhF
	 W1G3AdRPITiUvLCEaoDms7Lb+jmQXKZ+IGr3kmzjy7aqHTK/7w0VX2pRMVdQLeIxXCEj5
	 h6hL5ST1kCPLv8Uv3P7xsxQaFlBUr85x9/Qo58pxjC2CiwyQgU6nSpdZO6i+NXLWR03dJ
	 qciOHZHdKdEPvfcuJyQT73TZFdkbQoXDsIcRcVcsAMRaKpb7a+7+ogvSjI1h4uy1oIW4+
	 Q7XuPYfDszHuS/KwSm61NMgX04RfW38YOD6siGBhdNhimQovoDLhCmNynm3lhFQoApg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289916;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=OsSQR7Yy26AK61HuKZwKG4x8VbuWmgNh+N/oo4fnMaI=;
	b=J1hON8wJgO254ynHjnjBVD/41shlfp0gCFkhVg1FlQZz2cLvcoEnd+OWUrfXxLdCz4Vn
	 6i7h+3LIv1xz7aJnbTuF1e3ZGwqMp4QLxUJcNpRgoswoNfNStZE8e8a/f20/7cFoTvMZe
	 wFZ/g32GkZ1+hqUrvJuaadN1ymCpALCEEggurmRlasszHtckmGyzfLsiRzKaL7tnO0zcV
	 1vFX7GwQs9rLY8cCHSAsgAYQrujBu3UQM3EUJsk/PIgr/WCtzPBiu7V12J7xEqKxrCE+v
	 Xx0/fCudP0v99/Q9zzFfOs0XrM3l/+VC7Jidt3kWX4n/IEgR0JV4/16PoHejd8R1CgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F4nLrxp+;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75700606A31A;
	Thu, 29 Oct 2026 16:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75700606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F4nLrxp+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OsSQR7Yy26AK61HuKZwKG4x8VbuWmgNh+N/oo4fnMaI=; b=F4nLrxp+9awbAQfHVvTPP7zTFg
	5TxyoVriD8g0ZBcddVu4juP5OJqRpSvQGg1hI9hFL4RHjMtvbS8Lh42B8ODCnBdXdHNCNrXgKmoCs
	/lmeIGzSQrpqfdvZXr2wbSm58orjNfY8ucQ+9/7MowI4P2SU9Y9+wFouy9DKw91xUe2h+ahnogkFB
	PI7Au+l7HeQkSiE/uPjFcPdmpqjXIINDWJz+tRJ+UPZMuBjxFyfH7a1/V7vDl9/JCa2A6C0OEOLAP
	aWYyqo26H9+0l9m21ZxQAFSKX3DDV3vjABZzRdGx9hTJW2a+1JCWpOcbxgEGttS+00IpOTUAIYI2+
	afaOLAqQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMScs-00000009jin-405r;
	Thu, 29 Oct 2026 16:05:14 +0000
Message-ID: <2c08142d-4ae7-43da-b425-55e97056c630@infradead.org>
Date: Thu, 29 Oct 2026 09:05:14 -0700
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
Subject: Re: [PATCH v2 1/7] docs: ABI: power: rt9471: Fix invalid inline
 emphasis
To: Waqar Hameed <waqar.hameed@axis.com>, Sebastian Reichel <sre@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1793225920.git.waqar.hameed@axis.com>
 <38e21b9fcf7cb784e950b51aac7488831e8f7eea.1793225920.git.waqar.hameed@axis.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <38e21b9fcf7cb784e950b51aac7488831e8f7eea.1793225920.git.waqar.hameed@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/26 3:39 PM, Waqar Hameed wrote:
> `docutils` warns:
> 
>   Documentation/ABI/testing/sysfs-class-power-rt9471:1: (WARNING/2) Inline emphasis start-string without end-string.
>   Documentation/ABI/testing/sysfs-class-power-rt9471:14: (WARNING/2) Inline emphasis start-string without end-string.
>   Documentation/ABI/testing/sysfs-class-power-rt9471:21: (WARNING/2) Inline emphasis start-string without end-string.
> 
> Fix this by escaping the `*`.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609110722.GAZVme6v-lkp@intel.com/
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/ABI/testing/sysfs-class-power-rt9471 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
> index 90cf94c1cbf6b..d4ea9c9a5a9b2 100644
> --- a/Documentation/ABI/testing/sysfs-class-power-rt9471
> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
> @@ -1,4 +1,4 @@
> -What:		/sys/class/power_supply/rt9471-*/sysoff_enable
> +What:		/sys/class/power_supply/rt9471-\*/sysoff_enable
>  Date:		Feb 2023
>  KernelVersion:	6.3
>  Contact:	ChiYuan Huang <cy_huang@richtek.com>
> @@ -11,14 +11,14 @@ Description:
>  		mode. 'Disable' also can help to leave it, but it's more like to abort
>  		the action before the device really enter shipping mode.
>  
> -		Note: use /sys/class/power_supply/rt9471-*/load_switch instead.
> +		Note: use /sys/class/power_supply/rt9471-\*/load_switch instead.
>  
>  		Access: Read, Write
>  		Valid values:
>  		- 1: enabled
>  		- 0: disabled
>  
> -What:		/sys/class/power_supply/rt9471-*/port_detect_enable
> +What:		/sys/class/power_supply/rt9471-\*/port_detect_enable
>  Date:		Feb 2023
>  KernelVersion:	6.3
>  Contact:	ChiYuan Huang <cy_huang@richtek.com>

-- 
~Randy
