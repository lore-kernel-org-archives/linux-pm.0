Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1EF47252F;
	Sun,  4 Oct 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136014; cv=none; b=SGsUFdQ5CL1VTXr3KTW159cL3z0OaW0aVrlVd7wmHd7LabB9XG9KSZTUl7XkHA4rQZ7r3M9oIVQvlNc3eML+gdRWiIwAXoHG/OFV5/FnEm34uClDwa9EmEvSnP/PCXJeVY/DdvPLeF0c5vcBgLEd8Gq4U8BSbRZGSOSx/W2k4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136014; c=relaxed/simple;
	bh=lWsALHRYIKxIo+BLZKULZ7zxRVGzu9xMsh9iJShiWK0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OIprGlgZ6cRaQ99OYmulnU/Ep3L8mEcXdLB3/oTgHHpuoIc9QumqbXP7wPmIb+Hfqhwbg9GfiK7gOlBCS10sme82MrHTu+TehvjYtSXy5FSwo3UUFEp307qeASIwPuuHfugr02pen/DbYYqVK0njln7GXKEQH0FLBKOQh+HiQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9174B1F0089B;
	Sun,  4 Oct 2026 17:46:43 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 2386A182ABC; Sun, 04 Oct 2026 19:46:38 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260821153949.2914201-1-daniel.lezcano@oss.qualcomm.com>
References: <20260821153949.2914201-1-daniel.lezcano@oss.qualcomm.com>
Subject: Re: [PATCH] power: supply: Fix power limit documentation
Message-Id: <179113599813.190565.1879048790781384569.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:46:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Fri, 21 Aug 2026 17:39:49 +0200, Daniel Lezcano wrote:
> The documentation for the input current and voltage limits recommends
> using those properties for problems that can be solved using a power
> limit. This contradicts the recommendation to prefer input_power_limit
> for such cases.
> 
> Similarly, the input_power_limit documentation recommends using the
> current or voltage limits for problems that can be solved with a power
> limit, which conveys the opposite of the intended meaning.
> 
> [...]

Applied, thanks!

[1/1] power: supply: Fix power limit documentation
      commit: 23a00d8fb0452a4b182f4fea01e244f47758f4ee

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

