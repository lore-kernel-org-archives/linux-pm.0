Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813886;
	b=xs/RLkuiEIWQ72Ie/dmA0CPjPluq4PsSCE5J3tHo16453xHp+955Ta1oYdINi7tu/cBt
	 NUogzysuU0mR0plHdwZJKlPInf7wHc166BX0a/WmmEX3SWt9BUNOqGYqSPtyYVktHnnLJ
	 /vAURWOCTtHxMB1BnowlPN7m6WsQKsdgb0/fx3/AvJj+jla0vzYhYd9M+iHJmi9IJXklP
	 MpN4lGxaXlPYTe59fxCdARGMpa9MeDwpPnzuZRRaOrIgnxvHINQxRviYca+88I3r/Q3Hn
	 GJCFBNiuK4qzMX/KGCPMUK5QB/JM83l/crKzeUp1OvFgY+V2x7I2q7vb2Puqe9800ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813886;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=rExq5lVgGWK4apmzgUlwWDmXwLy4VEHNZ1es8dXhvVE=;
	b=4fkXOqvWH/2mrKnzWjf9GykC6ZC+rsTWi4TPH7p2M+95Cbk8ZwaJxbdITP3Glb/uZCRo
	 VJttbq0U3HJqrl/fO24JaxSJ1yBdBquBDHifvw1QVPakeHVkXU6kvrtpZcOsijzween5c
	 OqqUx0C3/abAzCOacqvqFD1lxDNQPaO0ReQdfZnn+VZzuA0OyXNPuNCIkKSopFhtrO9aC
	 8bDwT9ptne5tGbuyuznEyXybNyrA0tuaQBWDjdPASzgO8zmcf8/DamuGMUkqLVencwMXw
	 4zbGe/nqRtS7whb9T1rPFHwD+ETYpcEA/3c/NRSYrUoByFaKaf1HSynEeoNHy009FEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvfGFuDs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AE606A323;
	Mon, 16 Nov 2026 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mvfGFuDs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEC41F000C4;
	Mon, 16 Nov 2026 07:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794813886;
	bh=rExq5lVgGWK4apmzgUlwWDmXwLy4VEHNZ1es8dXhvVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mvfGFuDsbEoyV//bYp/TgAXOj4AbmwFqmsUi1kOGSCEXv6FGrB1f5YDBrhyNbot36
	 doepZFbmmt+bXjfCy8Nrn9wDJypNVn9KTGQj0PBQcyNBaOOYjFu1ecTKS3dMvipA67
	 P3cF1K+fzMypnqSvZCTkr39hJ/x+U7mPUDrKMRc0ZnBmu46jcbOgULWB4M1YBet9dt
	 QWbXz0hx5sfvcTCrjiJBfBNCfu0y0p4I6RiYCVov5kvyt0bW/qpS2mj2Kx6lb8UmWI
	 npv27uacIOu3oL2FjqmFRHfzc5Vzk/Hf++p7Oi1phgXGUM99I/oAbPP2z0CPd3+nsZ
	 Y7Wr0dPVr01kA==
Date: Mon, 16 Nov 2026 07:24:42 +0000
From: Yixun Lan <dlan@kernel.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Icenowy Zheng <uwu@icenowy.me>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH] pmdomain: core: connect consumer with supplier via
 device link
Message-ID: <20261116072442-GKA100890@kernel.org>
References: <20261112-01-pm-device-link-v1-1-8932e0862378@kernel.org>
 <CAPx+jO-37Km71oSW+zOO7BBWLj86SNCn=U=EGmBXdC5SfX4nbA@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO-37Km71oSW+zOO7BBWLj86SNCn=U=EGmBXdC5SfX4nbA@mail.gmail.com>

Hi Ulf,

On 12:33 Sat 14 Nov     , Ulf Hansson wrote:
> On Thu, Nov 12, 2026 at 8:45 AM Yixun Lan <dlan@kernel.org> wrote:
> >
> > Connect downstream Power Domain consumer with the supplier through
> > the device link API, So when the pmdomain driver is unloaded or unbinded,
> > the consumer can be automatically notified and purged gracefully.
> >
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> 
> Can you check if the below commit that sits on my fixes branch solves
> this problem for you?
> 
No, I've cherry-picked below commit and it does not solve my issue,
 it's a different problem.

Problem here is the pm consumer side isn't aware pm driver is removed. 

> e279833a5362 pmdomain: core: Wait for device link removals before
> dropping genpd->dev
> 
> Kind regards
> Uffe
> 

-- 
Yixun Lan (dlan)
