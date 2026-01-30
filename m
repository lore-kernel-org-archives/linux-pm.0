Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A75A32B99F;
	Fri, 30 Jan 2026 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760616; cv=none; b=Oby5k513oyXeS7hSfUY02UGxp9+YP2o1IevIQ2AseSf2S/b+As/lWxIbQcQbU3IV2ZqWAsk3Eqp3aEn8rTQeoH5JQhrDlT9ZGibrL2xfGOR00tmU6PRiUB0QBwn5duOY/1yGvgH7XwC0KWH+Jf6Xg9ddQdc9ax4tLRlwgKoCcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760616; c=relaxed/simple;
	bh=Lo2fUO90q/v1JUx9mj7PlHCHtIMjuN2bDdqaRtG0DWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQn7XNqMC+pzf6eGoWyHpN+rgwnF+oBDQF1K9En0KJzveZWSGW36+7amhFU0DuG8bgDXlFOAXaMXI5GMfSTGVolgxiQq9TDte6fa2kP3CNsq6agxUG9ueV4J9NZWp/Z+yoNGQG0ct7kJL/a5HRzOUQY7u6ovS9Snwkyx/1i8C70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=D0WOjZgd; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="D0WOjZgd"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 628DA1FB55;
	Fri, 30 Jan 2026 09:10:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1769760603;
	bh=67UzpBZIHZQ7e3X7q7iVPb/2tlQ+jW3PPWa81fH4DkI=; h=From:To:Subject;
	b=D0WOjZgdfDvtz72Ej5e3wl3mgZGzTCEqRfblslZM9Fw6nO7dz3qj6cy1pOLoJa87x
	 KlmpewBFqFdIK7Nw7RrJEpMEt3v1LtNHjdiUGgRcs8csoc/59uDhz+jWtE7KbA8trU
	 v4nhwOT7RnM6j/LEiz+8rxy1L3j4HrJGm6qy4zLZHbV6lnboDPy84ZLRwRPmzZvd9k
	 EADxG9zetZmg9SQKrHYR+btK7wbzmgVwTMRELquv7pLwEsHka3B/6uh6iDc+Qmqt14
	 vS+n+qYn5I9BUaYpRoAC3bnX7X0Z1JX9YKUMwa5V+NITTWnUNebnEL05ZpQ3TyYzW9
	 J2Gd9aq64wynw==
Date: Fri, 30 Jan 2026 09:09:59 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] power: reset: tdx-ec-poweroff: fix restart
Message-ID: <20260130080943.GA157514@francesco-nb>
References: <20260130071208.1184239-1-ghidoliemanuele@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130071208.1184239-1-ghidoliemanuele@gmail.com>

On Fri, Jan 30, 2026 at 08:11:35AM +0100, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> During testing, restart occasionally failed on Toradex modules.
> 
> The issue was traced to an interaction between the EC-based reset/poweroff
> handler and the PSCI restart handler. While the embedded controller is
> resetting or powering off the module, the PSCI code may still be invoked,
> triggering an I2C transaction to the PMIC. This can leave the PMIC I2C
> in a frozen state.
> 
> Add a delay after issuing the EC reset or power-off command to give the
> controller time to complete the operation and avoid falling back to another
> restart/poweroff provider.
> 
> Also print an error message if sending the command to the embedded controller
> fails.
> 
> Fixes: 18672fe12367 ("power: reset: add Toradex Embedded Controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


