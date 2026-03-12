Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00B3FF1;
	Thu, 12 Mar 2026 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354625; cv=none; b=AzHFQS1glF89ezQxoijTl3wbVL0Nvcnwv943vk5Ri8+lRJCOoKzxo/EAQBy/X+TudHeajz1V8GQpM764ChAGJ0QAX9F7CVbAyUkPVgvo+nU4PRFG5AKTbhDtoM/4hJEBgMXUsi2uYgh9BokYMi4c9Ak9prl9SdnOArQbP/lFank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354625; c=relaxed/simple;
	bh=6ZHdZttg3yFGHnlVR0p3S2W1DQFtCrDp5oaGzwVZe+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRhNFtlS/cuEC5h7SDc5awUocQ3BczsVL7YGx7uQhz/KDCjYdjYjgL15DcK/Gi1XggEDmmfbwUPjQuMloxR6pJ8oCypsHfnDixERo8xJOtsbFVJ4lz3IUutZ05Db+c8JdOKYoNBWCY4D5SfaDe5frbrD+eMCaqt5OnfvOm61zj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w0oXn-000000002Mx-17fh;
	Thu, 12 Mar 2026 22:30:15 +0000
Date: Thu, 12 Mar 2026 22:30:12 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Laura Nao <laura.nao@collabora.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] thermal/drivers/mediatek/lvts: add missing fields for
 mt7987
Message-ID: <abM-dM7Fx_-9yqgS@makrotopia.org>
References: <20260312202433.39092-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312202433.39092-1-linux@fw-web.de>

On Thu, Mar 12, 2026 at 09:24:32PM +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Commit a4c40559499f ("thermal/drivers/mediatek/lvts: Add platform ops to
> support alternative conversion logic") added new ops field which causes
> crash on mt7987.
> 
> [    1.518540] Internal error: Oops: 0000000096000005 [#1]  SMP
> ...
> [    1.564481] pc : lvts_get_temp+0x84/0xc4
> [    1.564492] lr : lvts_get_temp+0x60/0xc4
> ...
> [    1.620900] Call trace:
> [    1.631753]  lvts_get_temp+0x84/0xc4 (P)
> [    1.645471]  __thermal_zone_get_temp+0x24/0x11c
> [    1.656502]  __thermal_zone_device_update+0x9c/0x52c
> 
> Add the new ops member added in 7.0-rc1 for mt7987 too.
> 
> Commit 6931d597c5ef ("thermal/drivers/mediatek/lvts: Make number of
> calibration offsets configurable") introduced field num_cal_offsets
> in lvts_data. Add this for mt7987 too.
> 
> Fixes: 78c24e67d6f8 ("thermal/drivers/mediatek/lvts_thermal: Add mt7987 support")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

