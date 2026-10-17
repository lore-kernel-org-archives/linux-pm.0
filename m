Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7D3DC4B7;
	Sat, 17 Oct 2026 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274198; cv=none; b=cydBsulabD8H2/8xsZhjdH2B9pCL5Ktt/yTvNAfO6bzNAbTfs1VaM4J/LoJspUrchLZhxEG99RujT4wPNgKDfs88tfBdp1Mr5MQJwCChJLyk0XcH3/nYqX91TFM2pc0MF3NtknOgQPWBuDzvJSwW8ead1oPR9atVH9mjkGPmLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274198; c=relaxed/simple;
	bh=Xab/cqguZ38FQvlQ4TOnw9tMKWMPcCGmWaZfH+E+42M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kUmWdWXubp5I2Onse82Lc81dGX234+9KyurPMAaEHBcdN/zImxPe0P3YhcaOvxw8QHSZASHhwbTxc+wrqnl49b81akaMVMj2b7v3A+tWPiMoPyq8gx5izjd2hYyYLVKiXQFYukwzAQhf2deTrarx90rmvqMSkqnaLwf8WN5+ErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3F71F000C6;
	Sat, 17 Oct 2026 21:56:36 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 814AA1824B8; Sat, 17 Oct 2026 23:56:33 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Tim Douglas <me@timdoug.com>
Cc: hansg@kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261013022153.6707-1-me@timdoug.com>
References: <20261013022153.6707-1-me@timdoug.com>
Subject: Re: [PATCH] power: supply: generic-adc-battery: fix status with no
 supplier
Message-Id: <179227419352.76434.16664229487347110235.b4-ty@b4>
Date: Sat, 17 Oct 2026 23:56:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 12 Oct 2026 22:21:53 -0400, Tim Douglas wrote:
> power_supply_am_i_supplied() returns -ENODEV when no registered power
> supply supplies the battery. generic-adc-battery's gab_work() tests this
> return value as a boolean, so -ENODEV takes the supplied branch and
> reports CHARGING, or NOT_CHARGING if the charge-finished GPIO is asserted,
> instead of DISCHARGING.
> 
> This was noticed while bringing up an out-of-tree Linux port to the
> WikiReader: the driver reported CHARGING on a device powered by two AAA
> batteries with no charging hardware.
> 
> [...]

Applied, thanks!

[1/1] power: supply: generic-adc-battery: fix status with no supplier
      commit: 8ae5a3f40045ff486826ed6b6a83e39a0f380073

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

