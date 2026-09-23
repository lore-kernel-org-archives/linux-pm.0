Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF863AFCE4;
	Wed, 23 Sep 2026 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152630; cv=none; b=F0DrTlhuMYopHFhb4moqqmjFHWA3s7AikZO0phvzYT5Pr07rEHFC4h5CkwcUKeUlmsXOJt7WEzk6eV+H4VsSUymcsra4Iv/A/RY6YyNK7Mh25NSVCMitqz+pnak9uiTlBAfqdYhhEuG0M3CDwoCPqy7MDvDEDEXbiRQsplQFdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152630; c=relaxed/simple;
	bh=wPJ65swN4gwLVJL1QU9v8xzT2amPCdMTcyY3rDc8NAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBbcAddyBk/U8NJdvUpG/FdifM+rMdUnwcHJjxSV3LhTQ5f7YFHDdgjWGXQHEXb//IYzhRisXHVtwL3VIXkryHlYNNUwWmmiFsAGnZklFUTC5vrG2VJjtLS22uTDFD2rbYJvzlr1UKdYDWk4qQ46gY7LU1z/IiKq8Zk1iL5TzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ldb0PsCx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ldb0PsCx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790152604;
	bh=wPJ65swN4gwLVJL1QU9v8xzT2amPCdMTcyY3rDc8NAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ldb0PsCxHEMyEuuJomgs/vGq7l+WLiYyWNd12ZsdkzWL5HEwGL2+r+pgmnQ85/Ejz
	 //6GU8psH/Hne/1xrg6nxkm+DLQFxMZnpgL4ewlD5ezlIvFL5cSgeFbWxK+rXjndE4
	 xLcyya2NFnaK1njW/OQU5EzDXKhxTKjqVrfiwvg7q0ZNwXU8/VPth13MUaqjXYumpS
	 pX7Pi2esPKOjAIQwHFC/9m66zaDJNuVGALZxUQxGPrHFAeLX30DYjSmRBhvi6/GQEV
	 4FpFbHOvLHp4MqJmLxImqFNnyYcMTF7/dVYdePojiHYrX44CjxlYffFoFNcDpK0Bpv
	 iLGqILHZbNdDA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A0E2717E0104;
	Wed, 23 Sep 2026 10:36:43 +0200 (CEST)
Message-ID: <e43f4637-5468-4d2c-91b3-dbbe377216c3@collabora.com>
Date: Wed, 23 Sep 2026 10:36:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: dt-platdev: block the driver from probing on
 MediaTek mt6572
To: rva333@protonmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260923-6572-cpufreq-v1-0-41f7af6d6d1a@protonmail.com>
 <20260923-6572-cpufreq-v1-3-41f7af6d6d1a@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260923-6572-cpufreq-v1-3-41f7af6d6d1a@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/26 09:23, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
> 
> MediaTek SoCs use mediatek-cpufreq driver instead of generic one. Add
> mt6572 to the blocklist.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

