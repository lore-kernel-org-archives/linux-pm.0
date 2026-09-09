Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBBB56B874;
	Wed,  9 Sep 2026 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986996; cv=none; b=furwtQzDNahO0URBjXqe0uyBsPAAqH5QkBGiqeR4e3ARdGKM4I0qZgu5DihacP6zgOW8FfzlDWPweasMjzGnl6BwmpsiyJ0WbfcQeaAVJ4Y8QnLgMhBO7ngrt5W7rehgoUI5qc7ztFsZYyAQtNBKHzrpRQiANU6mmEXiDSyikT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986996; c=relaxed/simple;
	bh=mPMsA/YYKQS83gAyS387EMvPWkcbLuBQSG9gMe0Ux+0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FKd2j2bb0kf8U6s4rDVxswqE7KaW4xnISKp9dT22juVRxs6quSUOOVLm3rjUfMpqyIy2z/Fg66vp+uSTsVB92rcQJgNsRtkdSwCm3Ph+zbPOtw0A9HVjkjlAqCQZadKDkGIr77f7j5CltHGPiyw6Uz3TGo3xAcp78u+lIuXcOV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3CD1F008A2;
	Wed,  9 Sep 2026 20:49:35 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 36955183384; Wed, 09 Sep 2026 22:49:32 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1788290289.git.waqar.hameed@axis.com>
References: <cover.1788290289.git.waqar.hameed@axis.com>
Subject: Re: [PATCH v2 0/8] Add sysfs entry for system load control
Message-Id: <178898697221.883277.11703155914560526018.b4-ty@b4>
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


On Tue, 01 Sep 2026 21:35:07 +0200, Waqar Hameed wrote:
> During discussions of the development of a new driver [1], it was
> concluded that a new `sysfs` ABI for controlling the connection from
> power to system load is wanted. This patchset introduces this.
> 
> There are already several drivers that are controlling this, but with
> their own custom `sysfs` entries. The drivers in this patchset were find
> with a simple `grep` for `bat\s?fet` (there might be more?), and then
> converted to use this new `sysfs` ABI. The old custom ABIs are left
> untouched of course, for backward compatibility.
> 
> [...]

Applied, thanks!

[1/8] power: supply: Pack power_supply_desc to eliminate holes
      commit: 1948a667e2b9e2628a73f7b594bc2461b3062471
[2/8] power: supply: Add sysfs entry for system load control
      commit: eb16583b98416ea8472a48356e5eeeecbd7ab2e2
[3/8] power: supply: ltc4162-l: Use POWER_SUPPLY_PROP_LOAD_SWITCH
      commit: 63ca332b361df73d0f69ebf20a325e8f014d8982
[4/8] power: supply: rt9471: Use POWER_SUPPLY_PROP_LOAD_SWITCH
      commit: 63c85b1ae2f602d7865964e078b35b24196409f7
[5/8] power: supply: rt9467: Use POWER_SUPPLY_PROP_LOAD_SWITCH
      commit: 22baf7437615b94a4dad8288b14ae8815761d70d
[6/8] power: supply: bq24257: Use POWER_SUPPLY_PROP_LOAD_SWITCH
      commit: f7259dbf1e73f759c4a0c972a402bec3f6756b28
[7/8] power: supply: bq24190: Use POWER_SUPPLY_PROP_LOAD_SWITCH
      commit: 22d3111d524958c849e8105a8201ef40bd86c1ff
[8/8] power: supply: bq25630: Add support for BATFET control
      commit: 800ab4aa3ebc56333d65d158aa61bae56f9b79ec

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

