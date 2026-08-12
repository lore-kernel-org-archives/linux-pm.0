Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A584772A9;
	Wed, 12 Aug 2026 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573434; cv=none; b=DSFB6iYgjjnqdKGD7izE2WuqXB7jqq3TgmydDqxVWbLXwOsX2kwD13/rcx9zwGQMnmtBclJEnw3P5U2qO1G3UcdMR8zm/UCiKuDwN0QmMkKmtR/RGZbHZ29ExdrrM5VKTMdFi4yf01cGdJU9SYneDSzDa/fb8cVzxOYp8MbTnx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573434; c=relaxed/simple;
	bh=fC2yCEqRCpIHq1qM+f4cckcfWDYZAeZlSf1UN35AXeQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C83RDMdH+iHE5yJO7+S6HU+P6e3gM3qjf2XomAbhP2dCG25WddEvEV2IJ8ylI76fHlDpQLmEC9cgLP11brnlEvC9L4s9lFJA5m8us8WzYFnz/wfqs7oNHo8VAi6xeQa80trrX9oquH53qep+FYc5irO0xwcUNPYJxytniHwoZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DBB1F000E9;
	Wed, 12 Aug 2026 22:23:52 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 759951830B1; Thu, 13 Aug 2026 00:23:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Andreas Kemnade <andreas@kemnade.info>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kalle Niemi <kaleposti@gmail.com>, 
 =?utf-8?q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>, 
 Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>, 
 Markus Laine <markus.laine@fi.rohmeurope.com>
In-Reply-To: <cover.1786356145.git.mazziesaccount@gmail.com>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
Subject: Re: [PATCH 0/5] ROHM bd71828 power-supply fixes
Message-Id: <178657343044.347615.4384018520136265988.b4-ty@b4>
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


On Mon, 10 Aug 2026 13:08:09 +0300, Matti Vaittinen wrote:
> Fix a few issues from PSU drivers for ROHM components.
> 
> I hired couple of gnomes to work for me. :) (Ran AI reviews).
> Unsurprizingly some bugs were spotted. Time to try fix mess (mostly) I
> have (originally) authored.
> 
> Bugs were found by AI review but fixes are made by hand. Hence no
> AI-tooling tags are added. Please, let me know if one is needed.
> 
> [...]

Applied, thanks!

[1/5] power: supply: bd71815: Fix temperature reading
      commit: c15f0eabec5a051cb8190fa2bff3b211730f4acb
[2/5] power: supply: bd71828: Fix current direction
      commit: d012fab12fed2053e0dca4c8cd4e2b2053afabfb
[3/5] power: supply: bd71828: Drop duplicate power-supply property
      commit: 6605209ceb53eaa25582d1f4726217bd09eff392
[4/5] power: supply: bd71828: Do not hide errors
      commit: a3c841e420e124783a805919ab072551543e477b
[5/5] power: supply: bd99954: Drop bad register fields
      commit: 177299384a224377b4152242d875e752e5958c02

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

