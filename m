Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28EC137750;
	Mon, 21 Sep 2026 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961745; cv=none; b=g2kK7j5ubDrZE9mOscsiMV/yiaI65faqcE4iadGFY116DlT7s+kLwbCF/PvegVf7MzlrP+Lk0VYapJC17F4Avb7Shk4aopnmdqLosttyzi6cKVb6C59qaImqvfBBtuV6rdpIyJqAGuG0YkPqcK0YI3gRZZ7U87sPStDxBgwYEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961745; c=relaxed/simple;
	bh=fz6+v9N9vZnNUJRxljVDYRwQqnqDkcQzlFwG3oaBx84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4p7U5rlnoHVSjQGeWGJzY9kVmg/jc8/FBZlkY28AZz4GcYHrIHOE0AWcA4C6MVE+UqatkPgV9aRMcjzIs8spT/sNiHB9UjhcNaLcUx1eNMpiAtwjwQFofxvUO6BczmeBC7T7JnqsFrSNy8aPanoUUhcIJDV0nZqksSwvI6a950=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiqM7AiO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiqM7AiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9131F00893;
	Mon, 21 Sep 2026 03:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789961743;
	bh=/uc/dy3X3PpC2I1mymMB7hcZN+ZV0xyG3Njd3ZzgLFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LiqM7AiO2IjBtLmcuwiHc0Xis7kACHmYKH3NlI+J0E8skSi1jdzfkMwMBj3fwgFSI
	 ZUodi7bIfq1iHFdWccnIf3ZTZBJRaoxtjseyuhgd0FKbPtF/UBjECFi1B8mHnstAp2
	 lJuGWTJAGPStDQm0ydIJLIIi2ut5rRDbplt/EESN5YYu7qwgEP/Eg7mqxDOUImqvA+
	 FDBRBm7YNkrSRxSzhJ5+KCaq7yTOMKvB8emF4jRjZC6QqBNwRtRldjT+uHYu3s81jU
	 dzUmjMZiyJl7t97QEKuwdrYZmJjnGkoLl7K/b85Zom5A1FJLVfSVKecqCKgdX3GkbK
	 CAEOdFRyCjwxQ==
Date: Mon, 21 Sep 2026 03:35:40 +0000
From: Yixun Lan <dlan@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] pmdomain: spacemit: Add power domain driver
Message-ID: <20260921033540-GKG297024@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
 <56e5f32102c67575ded8af9e81a06dc9f1dcf0ee.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56e5f32102c67575ded8af9e81a06dc9f1dcf0ee.camel@icenowy.me>

Hi Icenowy,

On 20:56 Sun 20 Sep     , Icenowy Zheng wrote:
> 在 2026-09-18五的 02:40 +0000，Yixun Lan写道：
> >   SpacemiT's PMU (Power Management Unit) consist of several power
> > domains
> > which can be managed independently, depending on different
> > application
> > scenario, each domain can be powered on/off for saving power.
> > 
> >   The driver is implemented based on Linux Generic PM Domain
> > framework.
> > From a hardware perspective, either of two distinct power-on
> > sequences
> > are supported, in software mode (SW mode), the driver is responsible
> > for
> > controlling the states of bits such as sleep1, sleep2, isolation and
> > pwr_state, while in hardware mode (HW mode), the PMU hardware will
> > complete
> > the sequence automatically without requiring software intervention.
> 
> This driver is tested to be able to power up the GPU on SpacemiT K3,
> however the following warning appears in the kernel log:
> 
> ```
> genpd_provider audio: Fail to power-off domain: 2
> ```
> 
This is kind of an expected issue, due to hardware design, the audio
power switch is coupled with rcpu core, which means power off it will
also shut down the rcpu, so the power switch currently is configured
as always on from software perspective, it's unable to power-off even
in Linux or rcpu once system up.

I will drop audio power domain control in next version

> (BTW I built it as a module to prevent whole kernel being rebuilt)
> 
that's fine

-- 
Yixun Lan (dlan)
