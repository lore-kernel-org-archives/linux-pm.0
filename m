From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 0/7]  Fix issues and factorize arm/arm64 capacity
 information code
Date: Mon, 30 Jan 2017 18:21:00 +0000
Message-ID: <20170130182100.GE13332@e106622-lin>
References: <20170119143757.14537-1-juri.lelli@arm.com>
 <20170130122901.GA25681@e106622-lin>
 <20170130175138.GA26660@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753600AbdA3SUJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Jan 2017 13:20:09 -0500
Content-Disposition: inline
In-Reply-To: <20170130175138.GA26660@e104818-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, peterz@infradead.org, broonie@kernel.org, will.deacon@arm.com, gregkh@linuxfoundation.org, dietmar.eggemann@arm.com, robh+dt@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org

Hi Catalin,

On 30/01/17 17:51, Catalin Marinas wrote:
> On Mon, Jan 30, 2017 at 12:29:01PM +0000, Juri Lelli wrote:
> > I'd need more advice on this set, especially on how and if patch 6 could fly.
> 
> Since you got some comments and said that you are going to fix them in
> the next version, I guess people are waiting for you to post a new
> series.
> 

While this is true for Dietmar's and part of Russell's comments, I was
still waiting to understand where people think is better to move the
externs (as Russell pointed out), though, and if the whole idea could
fly.

I could certainly come up with a proposal on this point, but I didn't
simply want to spam people's mailboxes with a v2 (addressing relatively
minor points, IMHO) if v1 was already completely off. Apologies if that
wasn't clear from my replies.

Maybe you are saying that no comments are a good sign after all. :)

Best,

- Juri
