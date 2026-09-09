Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8415678CA;
	Wed,  9 Sep 2026 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986997; cv=none; b=t16DJxnoM6LmH3k5KvR0kP+DhbzTjKFlRRTTmsTWhe8wnrcD+nL6YwO7II0aBIm6KRAQxWwkfQN65hq/Q4LXSSY0JFNcKHlLgSY0nDicLgdlcbBvAKIhqQgniP6cXpka0hONmqt+hCivei1kwDKcwEWRuWcKCEXNNf2MqchhZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986997; c=relaxed/simple;
	bh=yiA2wFjuymTXui3ZDBJp7bpFchdTnQXhxtcstkg7Qhg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LjapcZm+3tX7uJe7nGYYXcUe7kuRjScE6mDgFRvBt25HDBXS26SOSG9dzsSYCmTZY4W+xoSVsrzFogOkm2UgkMcdnI50lnayodcsJAe56q90xRxAfM/E/BZeUsVCsZkifwf5KFaet8qEeDeLlX69ghjknX+v+TiHmW0F1Fr26fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258351F0089F;
	Wed,  9 Sep 2026 20:49:35 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 26924183382; Wed, 09 Sep 2026 22:49:32 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Santosh Shilimkar <ssantosh@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Hemanth Selam <hemanth.selam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20260907091212.28352-1-hemanth.selam@gmail.com>
References: <20260907091212.28352-1-hemanth.selam@gmail.com>
Subject: Re: [PATCH v2] power: reset: keystone: fix missing space in error
 message
Message-Id: <178898697214.883277.5680260868662724018.b4-ty@b4>
Date: Wed, 09 Sep 2026 22:49:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 07 Sep 2026 14:42:12 +0530, Hemanth Selam wrote:
> The two string literals are concatenated, so the message prints
> "has to contain atleast one entry".
> 
> v1 added the missing space but kept the string split across two lines.
> Krzysztof Kozlowski pointed out the string should not be wrapped at all,
> which also matches coding-style.rst: never break user-visible strings,
> because that breaks the ability to grep for them.  Join it into one
> line instead; the result exceeds 80 columns, which is expected for a
> user-visible string.
> 
> [...]

Applied, thanks!

[1/1] power: reset: keystone: fix missing space in error message
      commit: 49ee04619f820ac0e5ca618dfc0657229eadeddc

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

