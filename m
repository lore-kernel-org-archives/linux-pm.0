Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373B53A39C;
	Tue, 22 Sep 2026 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077503; cv=none; b=ejTIj9ADG+78etAy9KAO6qHdVCmvtPopMtBe87y7ShRS88YP9c7cG+mwbbUl+QXn+INWzZ55DhpEfkfDj77Avv6ebTPmmwDmogsq0uyWqdJAThPqmXsX5EZrFWs0G2E5QeVzOGa7+GJRmh2X+TN97zlwIQ52nj6SHOWtm5eCv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077503; c=relaxed/simple;
	bh=jKFRXUzZ/gZUTvNeWyPS2Cro/WCl4lSg1W4J+SAdU+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkTbJEiJSAuOz0lp/mXhVIDlghXgsUWbbapia+eM+6doMvB6NUyP1ByF5X1JCkz+D0JyM8/CP1im+zndxeSsOAlxTKThfkhEKim8gL4hyZnzGjaHgPfcuinlBLBFZrQ14aRAE/n/r/3G29CnRpC9xd99jzQRrhNETRueOEe6jnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VsjR1yAm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VsjR1yAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790077500;
	bh=jKFRXUzZ/gZUTvNeWyPS2Cro/WCl4lSg1W4J+SAdU+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VsjR1yAmeWj6hHQcapdsAtBNEZdkX47MMhiLc69fpXQ8lM7Gqu6uJx1GOaUSBjc6l
	 SoxYgm7UYA4OF5+/O3/Iwsk0RbZZZkOjOfb1zltAX1ZMyvAXlsW4gT25y0LJBqPYqz
	 mjZ+gKNnCZVIlEg4pKAtLEPCt5BgCrr3CF7Thrbtf1O8blWg3twzyXZfAmDnWpJiG7
	 Dr4rHCgso0zdP1ew/cm1OZIdKs2cleRJWJcfXPlyl4UETEd70JJPL8wICW5JviODv3
	 UN5t2LvKf61kUXDfcf8fkXl8lhp0b8Wk5svSGfdgB9Oc7ETcJHC9TDQ5kxuD1lja2B
	 KcnsLoAx0JzbQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 84BFB17E03B6;
	Tue, 22 Sep 2026 13:44:59 +0200 (CEST)
Message-ID: <68960e8d-36fb-4a35-a469-c18e3ade8fe3@collabora.com>
Date: Tue, 22 Sep 2026 13:44:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: Add MT6397 sound DAI cells
To: "Rob Herring (Arm)" <robh@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260921232649.3132592-1-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260921232649.3132592-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 01:26, Rob Herring (Arm) wrote:
> Document the one sound DAI cell provided by MT6397 PMIC nodes.
> 
> Assisted-by: LLM
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

