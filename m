Received: from mail-m12742.qiye.163.com (mail-m12742.qiye.163.com [115.236.127.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A5E38A70B;
	Tue, 29 Sep 2026 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648119; cv=none; b=ZlO+ZR+Z+SVSJ4p9VLabjqt2GQdUpBDeFmYC465gihX8gGvIobPy736KdaFppysSkGchmyKqaB5+AirrzYKb3ZDUO8J6jWgZSQcWtQgZu5s/VROUhPaa+12XD3Eerp8/XRzrU2pEesM6/WVH1sFtDVQIULk7z9anL2s29qQVtic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648119; c=relaxed/simple;
	bh=wT4XVcDrgnnNlXQ7vezcIqVPkYH/2ETC1MibPOXdmRU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m8rnocCwyuEyWTVopLl/G+d5nHSiVKg3wzVuN58/qI52doqgfohYGlsrb2TqwENszJ7kg86cxU3z0iJF3tUVv4Hcxmbkd+jYruQ0L9jF1ASBjgaevSMZHhywIJTU9wR1tL6xnNttcmD9sW0pVBrXkkjZNDMg8Cgs2nsT5v3eDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=eWazI0Pn; arc=none smtp.client-ip=115.236.127.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="eWazI0Pn"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f6b915ad;
	Tue, 29 Sep 2026 09:39:42 +0800 (GMT+08:00)
Message-ID: <9d48120b-8206-4c74-8e98-3a1aea2d08bf@rock-chips.com>
Date: Tue, 29 Sep 2026 09:39:41 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/5] power: reset: syscon-reboot-mode: Add support for
 Rockchip RK3576 reboot modes
To: Alexey Charkov <alchark@flipper.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sre@kernel.org>
References: <20260928-b4-rk3576-reboot-mode-v1-0-65486b03bd41@flipper.net>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260928-b4-rk3576-reboot-mode-v1-0-65486b03bd41@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ead1536503a4kunm68e8d0327ea435
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGh5LVh4fSkpDGh9KT00ZGlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=eWazI0Pnn7knjwGZECTX+ulASdL6vLBpupw8PlWpjyQgib35ZuGJmKiYgU1Vw8dmz1m3gQLEYhQJSXd8dY1GLLmWZlYU2Te4TnKAIwEvzJed/bZRiXJLR93PwydEDwbOO11FFLvJ8AmiXtluSCCjjqcwl1ebHyCNXuTNAFemS08=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=eawiXWtUZj4uCM8OnFXHNWvbRpsp4qvBIm2uw04gQNk=;
	h=date:mime-version:subject:message-id:from;

Hi Alexey

在 2026/09/29 星期二 1:18, Alexey Charkov 写道:
> Rockchip RK3576 supports reboots with a specified boot device priority
> mode, allowing one to override the board-defined strapping config and the
> OTP programmed priority setting.
> 
> Supporting it requires several changes though:
> - The boot mode request needs to be forwarded via TF-A to the boot ROM
>    (upstream since TF-A commit 2a97ba20e901 ("feat(rk3576): forward any
>    boot ROM boot mode request on reset"))
> - Some power supplies need to be kept active across the reboot to prevent
>    early boot code from running into a synchronous abort
> - The magic values for each of the supported boot modes need to be defined
>    for the OS to use
> 
> This series enables the above with the RK3576 EVB1 board as the example
> user. Other boards will likely need a close to identical change to make
> use of this functionality, but need testing.
> 

Nice work, I did a quick test on my RK3576 EVB1 board, this
series works for me.

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Alexey Charkov (5):
>        dt-bindings: soc: rockchip: add boot ROM download boot mode
>        dt-bindings: power: reset: syscon-reboot-mode: allow supplies
>        power: reset: syscon-reboot-mode: enable supplies for the next stage
>        arm64: dts: rockchip: add reboot-mode node to RK3576
>        arm64: dts: rockchip: name the reboot mode supplies on RK3576 EVB1
> 
>   .../bindings/power/reset/syscon-reboot-mode.yaml   |  8 +++++
>   arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts   | 16 +++++++++
>   arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 36 ++++++++++++++++++++
>   drivers/power/reset/syscon-reboot-mode.c           | 39 ++++++++++++++++++++++
>   include/dt-bindings/soc/rockchip,boot-mode.h       |  2 ++
>   5 files changed, 101 insertions(+)
> ---
> base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
> change-id: 20260928-b4-rk3576-reboot-mode-d3804e39df04
> 
> Best regards,
> --
> Alexey Charkov <alchark@flipper.net>
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

