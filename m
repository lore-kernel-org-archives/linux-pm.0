Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40038A28C;
	Fri, 30 Jan 2026 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811875; cv=none; b=TwJqCLfct7+7DdK8nPdgIJUMl8LNOzHgHKAqabWbVDDfQuck6fpvxZmNW4uRF86U6y5TgS/kvGi7NsMIkbo3wV1PqbfuFmRAz1Y5uaQYKwIMhSIUqgY+dwOLT/J8cm8JCn0MvmUfWUN0nWx0UpGklyNlsiNCngr1+4Zsh3nK38Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811875; c=relaxed/simple;
	bh=C8l+bxn/3dt/Na/JetrtGx+8ReAzUbl3NznilTqVcYs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k6BbDPraHEs9mGMYAlscR0Fl+OShK4sABqqaC2J9cZ9oloG6jJ0MUE9oS411funIhx7bFwaLQOHBCljLg7cmXKIY0JOE2/VE9KVO1cgAXmDJFKuMzN25LUVcVQcbCh4EuF7zBPtUyV65cDQZhib6LBGerA4tyT3rSNBHFJDL4nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E23C2BC87;
	Fri, 30 Jan 2026 22:24:34 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id D20751805FE; Fri, 30 Jan 2026 23:24:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <aWi_GG74sZRfajA_@mva-rohm>
References: <aWi_GG74sZRfajA_@mva-rohm>
Subject: Re: [PATCH] power: supply: bd71828: Use dev_err_probe()
Message-Id: <176981186784.331784.4686693358681648734.b4-ty@collabora.com>
Date: Fri, 30 Jan 2026 23:24:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 15 Jan 2026 12:19:04 +0200, Matti Vaittinen wrote:
> The driver uses separate error printing and error returning at probe()
> for locations where the error value is hard-coded and can't be
> EPROBE_DEFER. This helps to omit the extra return value check which is
> done in dev_err_probe().
> 
> Using the dev_err_probe() has some other benefits besides handling the
> -EPROBE_DEFER though, like standardizing the print for error numbers.
> Some believe thes outweigh the benefit of skipping the extra check.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bd71828: Use dev_err_probe()
      commit: 12bdf471e374b34cb0e48b29bb9eb9127ed26fc5

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

