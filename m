Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2930FC39;
	Mon,  2 Mar 2026 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494920; cv=none; b=GMH1jGY6XCQz4IBjNw2P1xHU6l/WE4YSFyMnr/Fhl6SQh/EoPg14kWBKyCryIbkMUHs/5iRTOtoMxG8X0wVWpw805A457oUiypzysRvz+0UM1RVYItGzIoNWtgj1QPGdfnjwW996RDR1LtS6KJXu3qYAfHsxfovUK9oPip8wX5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494920; c=relaxed/simple;
	bh=n+ZWgwIbO4QbTza1qF1GmlgopNyYlWY+IyZ+8XvPkf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CkH9wwpiVo37CKKEB6SxNblzLrqclMBJbZTCbFhQ9FnH1oP0jxa5gkPkK8r5iR6HQ0pRyEi0GSlK5yRd+L/9CkUF8RUQqxJaEht0jjy8R3BGMCeNaS5CimVODH6YztxdDQXEpGaP9mUyjH9RgvMdiEgKO+B4JdJMirz2vF/D4m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E17C2BC86;
	Mon,  2 Mar 2026 23:41:59 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 2D4A7181254; Tue, 03 Mar 2026 00:41:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Xichao Zhao <zhao.xichao@vivo.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org
In-Reply-To: <aZYoL2MnTYU5FuQh@google.com>
References: <aZYoL2MnTYU5FuQh@google.com>
Subject: Re: [PATCH] power: supply: sbs-manager: normalize return value of
 gpio_get
Message-Id: <177249491817.606802.14188854399988847340.b4-ty@collabora.com>
Date: Tue, 03 Mar 2026 00:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 18 Feb 2026 12:59:49 -0800, Dmitry Torokhov wrote:
> The GPIO get callback is expected to return 0 or 1 (or a negative error
> code). Ensure that the value returned by sbsm_gpio_get_value() is
> normalized to the [0, 1] range.
> 
> 

Applied, thanks!

[1/1] power: supply: sbs-manager: normalize return value of gpio_get
      commit: b4512ae0d55a5632294a16eae765e8b4c41b8856

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

