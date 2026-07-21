Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EB23976A7;
	Tue, 21 Jul 2026 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625591; cv=none; b=reJ8V/1hVw4m2LcaV+XMXaS6eTkUGWbFQcVl/MJu8sH5d+bx7rsrdNY+1VvttN2JGySSgCD3Q+pVqaTR7F9i1ShmUBspSfA3K227yV8D/moJsfyfvJvrugVPUTwJpTcsFHdroWgAjmm+VQcABwYqrEs8ma4sFtuZ74iB7r/T4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625591; c=relaxed/simple;
	bh=VNm4zMuC/cY2KdIr3jVDAGU5TNHGIenW9B8Its2FuNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcbCzOmxzbD0m29TO8ug4dKTntU5TxeoI1E7mBzEoGfj60vnh/P3pO28clm19p2sfI1Mg8UbkMdyoC4X3Y5UmLAoX3yKAPje7tLw4RqtIBFM5TWWctv7oRK6tjq9KbQENXlHXNR03xOtm/A5+X7q72p0OPmSln7mHRCE7TqNAiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HBIolR8J; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HBIolR8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784625588;
	bh=VNm4zMuC/cY2KdIr3jVDAGU5TNHGIenW9B8Its2FuNw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HBIolR8JvWb6/Pg9E/k0p6NmwVt4W57w+dwxP8WhbTecU2uYVcgMLkwJhmveXmed2
	 VKJPxf/hzgVpc6ifJwzWFzvlego4Nk2vYCLKizimaQqrDRInyvVftbLBEdv8D6rgaH
	 VeYTT253ziuTzQid8JlO/8zcgmVA496jna947vjcsBmjAPuO2ji8326cnbvuHpqR0B
	 UNf2Y/PW2Qy7no4m7tnImWnNsOfEWYAaiIgqpdwvi/1ytCp5l0Du6IZ7s0rn0jv/ym
	 +xn5Q+d62IVtKv7xGGLzo8UiiUw1o/EVvrVIt7MGDh1LG+sZfEbf1md8C9keGhYb8v
	 uvYruRQkAUTTA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C11A117E0564;
	Tue, 21 Jul 2026 11:19:47 +0200 (CEST)
Message-ID: <cc9ffb02-4175-48c2-89d6-b538bf75a350@collabora.com>
Date: Tue, 21 Jul 2026 11:19:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] pmdomain: mediatek: Add support for secure modem
 power domain control
To: nikolai.burov@jolla.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Ulf Hansson <ulfh@kernel.org>
Cc: Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
 Nikolai Burov <nikolai.burov+review@abscue.de>
References: <20260720-mt6858-pmdomain-v3-0-8966d8de93c8@jolla.com>
 <20260720-mt6858-pmdomain-v3-2-8966d8de93c8@jolla.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260720-mt6858-pmdomain-v3-2-8966d8de93c8@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/26 22:46, Nikolai Burov via B4 Relay wrote:
> From: Nikolai Burov <nikolai.burov@jolla.com>
> 
> On recent MediaTek SoCs such as MT6858, the kernel is required to use
> a secure monitor call (SMC) to enable or disable the modem power domain.
> The power domain control register can be read, but firmware prevents it
> from being modified directly. Some other parts of the power sequence,
> such as setting the ext_buck_iso register, still need to be performed on
> the kernel side.
> 
> In preparation for modem support, add a flag to enable this new power
> sequence for SoCs that need it. Power domains using this flag are not
> expected to configure any bus protection registers, since these are
> handled internally by the SMC call.
> 
> Signed-off-by: Nikolai Burov <nikolai.burov@jolla.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
