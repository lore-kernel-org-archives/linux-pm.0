From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/7] Documentation: arm: fix wrong reference number in DT
 definition
Date: Sat, 21 Jan 2017 14:55:09 -0600
Message-ID: <20170121205509.qv4b5cku47ysnkfx@rob-hp-laptop>
References: <20170119143757.14537-1-juri.lelli@arm.com>
 <20170119143757.14537-2-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35403 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdAUUzK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Jan 2017 15:55:10 -0500
Content-Disposition: inline
In-Reply-To: <20170119143757.14537-2-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org

On Thu, Jan 19, 2017 at 02:37:51PM +0000, Juri Lelli wrote:
> Reference to cpu capacity binding has a wrong number. Fix it.
> 
> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
