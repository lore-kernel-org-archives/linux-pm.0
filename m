Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D0411F9E;
	Wed, 12 Aug 2026 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573434; cv=none; b=SSh0NFx54Y1OYUjFXrylDXQUrPrgckJ0baArzAIqGHhqrtkS1wSdzL1ApuVqYRWf6w7WhIekfQ4gjY6OVDS6ITckLuJBiCAv1B8LH2U5LPs2WnBNtVxGKgNzQfOPKqiQlOV/8dsrbg4H/mF1xzNoL3shiatwBflpRSnlVrDw0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573434; c=relaxed/simple;
	bh=gMgmV3P5nIbMo9/0xJSwTj8/wRbVEJ2t23zfDyZrJvg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wl5aSPGJFYsCD+8o6JQIuaQIdQN9zK1qrYekW+Cp/qU/Zgef8avZ0Tm6+KeZANt00s6ZfJEoEiZWKRKgfz8vMBy1BdI25USVEm/AWIhIrL0AiZ429CQ1NtMkn8vshkeXrPsdl03XK0SBJLGrVMvmKOer5sjqnxJ+pKUW8B0JkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A04D1F00A3A;
	Wed, 12 Aug 2026 22:23:52 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 9F4F11830B5; Thu, 13 Aug 2026 00:23:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Jianing Li <m13940358460@163.com>
Cc: Iskren Chernev <me@iskren.info>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Matheus Castello <matheus@castello.eng.br>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260810004701.1683-1-m13940358460@163.com>
References: <20260810004701.1683-1-m13940358460@163.com>
Subject: Re: [PATCH] power: supply: max17040: synchronize work cancellation
 on suspend
Message-Id: <178657343063.347615.2933073571109497351.b4-ty@b4>
Date: Thu, 13 Aug 2026 00:23:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 10 Aug 2026 08:47:01 +0800, Jianing Li wrote:
> max17040_work() requeues itself after every poll. cancel_delayed_work()
> only cancels a pending instance and does not wait for a callback that is
> already running.
> 
> If system suspend races with the polling callback, the callback can
> continue accessing the fuel gauge and requeue itself after the suspend
> callback returns.
> 
> [...]

Applied, thanks!

[1/1] power: supply: max17040: synchronize work cancellation on suspend
      commit: 86a3a8a926aa5969c329d1df2d3259f189961bbc

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

