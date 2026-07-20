Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B555F42F717;
	Mon, 20 Jul 2026 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583828; cv=none; b=iQFRIi0dzZDS71hocY1us0nmrPq/3uhSZ8923bXz+Y9UtGAGd4z+aMNLDx4xgXubi/zHo+WvhobVpuOfecyjokhlatVx7hmq31FWPXlau4A2hvStqReXXopXj+bvJzW2N7oleJVCnmqeU24NEbY05En5bLlMn9bAxvq66Ndb3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583828; c=relaxed/simple;
	bh=DIOEDQq/PObBIfaYPlWT2/OBR6ueqCZTQHm3/rr/zlI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pwle50vTL89eAgFONTpWEVFXnVncd+Ai/Eh9VaGVP7kUFRZXMcnZV4XP+8oBK87JdiBdzGgTYTX1INW7Zfliv7JmV8u7m0bcBd+G/dOsn9z24Ckh1zp9YlWj+XNTgvgprbyanVQQPpcmSRoAGBnusms7aHlqOsXSfHRfcKqxAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADDF1F00A3F;
	Mon, 20 Jul 2026 21:43:47 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D985B180CA6; Mon, 20 Jul 2026 23:43:45 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev
In-Reply-To: <20260615063105.39152-1-pengpeng@iscas.ac.cn>
References: <20260615063105.39152-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] power: supply: cros_peripheral_charger: unregister EC
 notifier
Message-Id: <178458382588.311390.12180878039745728593.b4-ty@collabora.com>
Date: Mon, 20 Jul 2026 23:43:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 15 Jun 2026 14:31:05 +0800, Pengpeng Hou wrote:
> cros_pchg_probe() registers an EC event notifier whose callback uses the
> devm-allocated charger_data via container_of().  The driver has no
> remove callback and does not unregister the notifier, so the notifier
> chain can retain a pointer to freed driver state after unbind or probe
> cleanup.
> 
> Register a devm cleanup action immediately after the notifier is
> installed so the notifier is unregistered before the driver state is
> released.  Also fail probe if the notifier cannot be registered, instead
> of leaving a charger device that cannot receive EC events.
> 
> [...]

Applied, thanks!

[1/1] power: supply: cros_peripheral_charger: unregister EC notifier
      commit: c9386d5fabbe006c1f793b22bb80036303d1d166

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

