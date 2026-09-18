Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4533264FD;
	Fri, 18 Sep 2026 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772471; cv=none; b=qA25HnyKEtpYu5XVKogAjr0+u+S2SAhR4dK1h00VWDFKl2N1KAXCEDnSqJPqh3Kl1mtguTVR89CKc/j+qpRTgKzq6h4h2r5FHAa9s5w+ETPhx3sbektxp4TJ5JIwozzE4dujvxdaclfpkTOpyQeqxDG33CNZ2eCkqxNGqKbgHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772471; c=relaxed/simple;
	bh=V7pBa/KMrAJDHm4lTEygfzTTl+/XTHvWYHKI7oYDBQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF4kd/jb9483NtVLDuoRhFcwtx6q2YlpJq9Nhyf/ZYrvsUf4CHmuueRl0OLm7KcGSLE7WN3zvEfPTjnQeQmIvzfJivk8/wwmaKWyRhu+7C2cK7HY2vqgcCYdjjk3Z2CIvg44aWBrlVswkpf2bwzfknmriI+7vOUo0akWrhsBNPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flOQ3ytx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flOQ3ytx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5DF1F000FF;
	Fri, 18 Sep 2026 23:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789772469;
	bh=SN+cGtUcaDOXnci0UtnpePkFtN0EYV845cfIYt8n+7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=flOQ3ytxsAwXtDjXhE3lWkmvTLpnoqeZnMIlinf02PTdQ/+E+iC2gVenIoyWSuxsE
	 FTrW7YLcU0pbEkpirrU3rBgWvqjWKqK6xJDqrOyE2jm6AQ3wKwUcp8xMt4fdUcX4s9
	 dFp2juVIjMsWyfL59WOGGaxe7ncOAAiyz9htdiLLJHq8zg14+sWu9xUJp/25J/crGC
	 bEMi+7ix4GhbCw7iS/nhy0HDIrhIMZIyg9QDiK51Ith0JsQxRw5oIv3khqUKIaukB8
	 VrDey+9KvV+4hsLEOPVB5etPhj/tGIarpF/D3Jz/i4tONxYP0GSOW6yy/UVZQ3DyL1
	 /9r9IfDXxIWEQ==
Date: Fri, 18 Sep 2026 23:01:07 +0000
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
Message-ID: <20260918230107-GKC297024@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
 <a4359efeee2220903a05a2383a651ec8ec7284b7.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4359efeee2220903a05a2383a651ec8ec7284b7.camel@icenowy.me>

Hi Icenowy, 

On 17:00 Fri 18 Sep     , Icenowy Zheng wrote:
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
> I think there also exists solutions for K3 that uses RPMI power
> domains, and let their ESOS firmware to access the hardware.
> 
Yes, I'm aware of that

> What's the relationship of this implementation with the ESOS
> implementation? Should the ESOS part be disabled to use this
> implementation?
> 
I should say, it's a mutually exclusive solution, so yes, the ESOS part
should be disabled in order to use this version

The motivation of this patch is trying to support drm/display driver's
PM requirement, while avoid going with vendor's complicated RPMI solution
which isn't mainline ready

-- 
Yixun Lan (dlan)
