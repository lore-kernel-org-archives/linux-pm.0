Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B747AF61;
	Tue,  4 Aug 2026 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874330; cv=none; b=dPZ2ak4vv4RlxCMUzR6gaiBVLpZxZfeL1HDGTBicY+Bag+xOWCTAut8oUyGleYtCszbtnwe/rFgpu0Utes/vz9p6XrLTjucQwsj1ritBq1zylxdNUYuvXb74rfjOvSqnAOKjPXVZMJd/eJcriXGce3roD+IAxNRnWg+kaFShK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874330; c=relaxed/simple;
	bh=tQJqp4wVoR0FAeF3E424yktgYkqumSOwRjIbP17oW5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qDcOaVC8socR6EIk114X9FUMks1sTT2Vc365Axlj5s8fgmX9xjSbJrkBlABkajTn9RPzxqN0MlZjU2hURcVVYJ9Q8/mr8Y1dx7IDKwah6RmCZ6w9tEoiIqsfnsnghZvPI44StOl5a7iyRDrFlLAt6oPCBU5IY8RIi8RGhl8m7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZjFZD8E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZjFZD8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A5F1F000E9;
	Tue,  4 Aug 2026 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785874329;
	bh=tQJqp4wVoR0FAeF3E424yktgYkqumSOwRjIbP17oW5E=;
	h=From:To:Cc:Subject:Date;
	b=fZjFZD8EaGYqh4yxz4JHp1OujtrXrjdzBSe8jb6FNJ7jskjnGrl+Z4jDqO3s6SwUT
	 EQ2s3ikxrS9omh6yQ2Og7oG1PboZZFW40xYxzFMYvwsHf7Kew9muDrSYMBHjQxNXwY
	 LB1qny76ZtTS9s8hehaXVsC0UhxgSUfY6JG+ncpwvoUia6wPaTN1iRABOvK5N2WhpF
	 HMH6cWIZKm5ldBjb0O2lZCSLCrbrkXAwSbiz1p01VBELeAZlWLE1gai9xCAhdPs69b
	 o153I0QvIlmV+sXj8qgAbuPoSdvCovuD7NYXqQlhN5XNjhfz8jATZbTrFMJQ/aAK+E
	 0MxomIQUoOWkQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 0/2] thermal: hwmon: Fix thermal zone removal deadlock
Date: Tue, 04 Aug 2026 22:06:29 +0200
Message-ID: <12947893.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

This series is a replacement for

https://lore.kernel.org/linux-pm/23195575.EfDdHjke4D@rafael.j.wysocki/

with an additional patch to fix a UAF issue reintroduced by the
reverts at

https://lore.kernel.org/linux-pm/6319276.lOV4Wx5bFT@rafael.j.wysocki/

The first patch needs to go into 7.2-rc along with these revers,
while the second one is regarded as 7.3 material.

Thanks!



