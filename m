Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C4471256;
	Sun,  4 Oct 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136002; cv=none; b=XCjJs+on7kWgBt0YTB2QLMs4BcNeQQOf+A6mRDWOy6ztZPPy8fDUTZAzp8NUabus41N81dQH62IvcMA/qbJP9q8YPvXxaEeJcLTDeLImryfE01TuJMc7cfH2FwBgnYBqZubgdgar2LVf1etgI8DKk/Ts8OGEHaL/9c9pjionEmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136002; c=relaxed/simple;
	bh=05OyPAKhqZ9SMk7olm8ICd5wAS9J7hWscORKLRwkwXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qSkt6f/eB1rD9o58gClU7qy9letaFLLiBlwM5hjncPdvJvglQhsZTnGGpoORWRdzW2QF3oTo8DptgWhszB3nrXVE1gJm9cABdjFaEAuQi0v/S31Ej3u1dnwD+eKjE/XGyscjSOpCHFMlsrpshNdjbjiuyA5PuXI23QsOaX9j9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BDA1F00893;
	Sun,  4 Oct 2026 17:46:41 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id ECBEA182AB7; Sun, 04 Oct 2026 19:46:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Liviu Nicoara <lnicoara@thinkoid.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260920193402.2402-1-lnicoara@thinkoid.org>
References: <20260920193402.2402-1-lnicoara@thinkoid.org>
Subject: Re: [PATCH] power: supply: qcom_battmgr: Report capacity on
 X1E80100
Message-Id: <179113599795.190565.17085852677358243884.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:46:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sun, 20 Sep 2026 15:34:02 -0400, Liviu Nicoara wrote:
> Commit 3f87baacea4d ("power: supply: qcom_battmgr: Report battery
> capacity") added POWER_SUPPLY_PROP_CAPACITY to the SC8280XP battery
> properties, computed from the firmware's charge and last-full values.
> When commit cc3e883a0625 ("power: supply: qcom_battmgr: Add charge
> control support") later gave X1E80100 a property table of its own, the
> table was copied without the capacity property, so X1E80100 machines
> expose energy_now and energy_full but no capacity.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_battmgr: Report capacity on X1E80100
      commit: f7c62ebfd9127b12a1e39f1cc7f3131cb3065886

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

