Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649175;
	b=q+2aBzmYPPZ5WD2oSei8J6e2peUh4gAiJUTZUgw5/bCvuQI/4aX22uZXxXGhQzeboeUC
	 mj3Vi6I9WtHh7CqIHTQplQdM6ZCxbNdOVn29JbPR2Li8x104bUiC8/HlMVoGms+w+6kjH
	 7RZu8DKW8Vgk4eUgz67BwHBoPFszh3uvbrX+WBR2kHMq3O91iLu18+xq0w7WmYUYSelsx
	 x33cVuHGfgFwjM3dUkiynqIX21aIB2Fe7oXvl/aSjm/aU4hOvsiyzKegYcryqr0eP7QH+
	 SwgV7DbRb6QT+vKyCHgZnmEvKJZm7xDCdhV1LC1542pWM9oZrg3Y5fqY6spjDb9T5TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649175;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=M0xXm6XiXe004uqwr7i/jYND3X6GY5GXFr/RX21T58E=;
	b=zS7U538lRI5V2cjXKZXcWxhpX8mNeqaGdS3y9pUPDm4kLx0HiKV9mipWNJRAzCoMiIHZ
	 nIybPt0gnBAug/Fslbm6UFizf/ntDKNMx9C+kAI/v+6sSs+tZiiH42WuESfMz4hjymXQg
	 F965/DhDVCayzDb0IaPS0/NSthVvLvxA0xDZKkwLBMSTfQ3wxeAoePV7nuZEVgGX08fkc
	 0/n5W9sz3K6uJGdYOaow9A89xb4GbWjY21ciDzvs5SDdZ3Q8o8rUmeYg/LbkC9T+Tci/n
	 1bm8r+4MQ/XTv3jEvqUm9+qhDlKOpMF6pgnsM32czsGyAbPw47GjrZn64KlHerNa4Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dw4FJ4fC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E71606A329
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dw4FJ4fC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A381F00A21;
	Mon,  2 Nov 2026 19:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649175;
	bh=M0xXm6XiXe004uqwr7i/jYND3X6GY5GXFr/RX21T58E=;
	h=From:To:Cc:Subject:Date;
	b=Dw4FJ4fCFEZOF56lsYOzVN8UG/50T2zyBrXVRZ6DXs/7RrR8ZN9/JoNSWFaHoj/tR
	 Y/r+mLwKuL5ZvHjItu0kXISuLx2lhHlqvesMMtCox6NEsXSi6k30ZAIUR5IQp0dFFq
	 jststBZ+MRmb8HuzlHVXT4P7UTS30GeuHS7jVW9lA4r6PnOXWUhXhM8p+D5aax5B85
	 uNgHrA9U6RgJ88Ud7ytSHI25V5kEv7gimyb9TL4nT9WgeA5HBOdM+V3nz+5HcWg7X1
	 Jf0fKpw2OBFoIaWTCOaLAsWLy4BZkk2fSayz08MKgoTE1z3DCE1ZjDFpCphTNCojGQ
	 eYAcn9njxXpZw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v1 0/4] cpufreq: Fix synchronization with system suspend/resume
Date: Mon, 02 Nov 2026 20:48:13 +0100
Message-ID: <5162355.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

This series fixes issues related to the synchronization between cpufreq
and the intel_pstate driver with system suspend/resume mentioned here:

https://lore.kernel.org/linux-pm/CAJZ5v0hT6aoX4tuJM+rO_5iequFc_7rEXCoaFnHoJBaH3JP4KA@mail.gmail.com/

The first patch actually prevents governor operations from being
carried out on suspended cpufreq policies.

The second one forces the driver callback to be invoked on the
first frequency update after cpufreq policy resume.

The third one causes intel_pstate to invalidate the cached last
P-state value during suspend.

The last one is a cleanup on top of the previous three.

Thanks!



