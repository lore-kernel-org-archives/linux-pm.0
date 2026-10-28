Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192460;
	b=XK1ZwCMOYcEPWv0tBaKggnnn9RRq0dqRmk5xxzA/Xn+mmnIq8yCu9GYFK3mVyq30WMaL
	 YPvcq96ehFsx4zgD2qKZDWXxItsC7OhwIKHctXKRWOAi3HCkY+keSctlirw+31D1pyEqw
	 7/8acUOx5JSFYZCmENol80/uVOr/mq1FobDQQQewK1V9WnIZg5YTfoQsAMRfWDkH6kVdP
	 G02g3nXokXr7zSQ9UXvsC2RjGQwYoWe2YMpuLgU9j4W+SLjbQVcasNzOPziiLKlDq3XTh
	 dNJdFWZ1GTji9+FyvirpiOvGuALcoPk+UnKrI6o/HGCl0ZDOFyR/6ofUKuWyTNNKmkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192460;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/b8FWkKHJmTpCsH9i7LnGOalRtFf2x74JQCgiMUf79c=;
	b=XgF1gdT2J8sA17LK/jnFNpFJnFycjlv+lKylEgQG3EZzpN7ZgTIxxXHVU+e2ZvZ5oL/2
	 cTBC6XokDew9aGRoGaPpJh6iycJCvFUY0+JuCbw80P5/jH43A73D4ZDCFC51Y/9cSqxBL
	 cC0OCNng9qsJNHwGql3jYgLnfwyNw/Y2lkLWG60AXkYEoxIr4VnB3flT0y+N8+Zijuu4l
	 qbuFrKyYxHyo6BrUzlV6meDFoPNklBiCpxvo0XBz3yAbplMZjH80hKjqjYkt5nvD5vnW2
	 ICPVsA8t6c6/l9QVy+/B4UkJ/zczW0KFoHfBosOJZX19ToxgJ0aegOiEjDWzN26HEbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8SfeHac;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D71B606A31A;
	Wed, 28 Oct 2026 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8SfeHac
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE581F01825;
	Wed, 28 Oct 2026 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793192460;
	bh=/b8FWkKHJmTpCsH9i7LnGOalRtFf2x74JQCgiMUf79c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y8SfeHac2Om0LaOQZNy6NMDNPSxIvEtbMwVdvnqjRLkRROH9EHwzJjDlUH+5lmhrt
	 +JGeqTniBSoEs1XpeHV8vjN7pwwaXXPYc0zfj/mfA+tgiIYSOC/P9A5H+1p5mknIaH
	 x7thJBo0uWRmXISUmDfym08cIfhi0i3t31SL+rtCuQcmil0RbCt7NhLYRKAkDjsZkM
	 5JhP3Tbn38lwLjhoI2GyzhSugZKJXeo4zV3IpQ+MfxEDt21hUncSh+beYl+WUx6kVm
	 KfWs7gd7LTBJUWC8J1jpBxQfaeeOMBHXc4WFZI/ttJdrPRWAcd34tBmE0jblm6itOo
	 7Uw20Uez4FVYQ==
Date: Wed, 28 Oct 2026 14:00:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, 
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: thermal: Drop thermal zone node name length
 limit
Message-ID: <20261028-worthy-prudent-cuckoo-d5ed97@quoll>
References: <20261026094956.2323036-1-daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026094956.2323036-1-daniel.lezcano@oss.qualcomm.com>

On Mon, Oct 26, 2026 at 10:49:56AM +0100, Daniel Lezcano wrote:
> Device Tree bindings describe hardware and must remain OS-agnostic.

DTS describes hardware. Bindings describe the ABI between hardware and
software, so if SW requires something regarding the DTS, should be
placed in the binding as well, IMO.

Best regards,
Krzysztof

