From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ARM: cpuidle: Fix error return code
Date: Thu, 11 Aug 2016 14:39:02 +0100
Message-ID: <20160811133902.GC26202@red-moon>
References: <1470920550-21625-1-git-send-email-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54118 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbcHKNjG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Aug 2016 09:39:06 -0400
Content-Disposition: inline
In-Reply-To: <1470920550-21625-1-git-send-email-christophe.jaillet@wanadoo.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Aug 11, 2016 at 03:02:30PM +0200, Christophe JAILLET wrote:
> We know that 'ret = 0' because it has been tested a few lines above.
> So, if 'kzalloc' fails, 0 will be returned instead of an error code.
> Return -ENOMEM instead.
> 
> Fixes: a0d46a3dfdc3 ("ARM: cpuidle: Register per cpuidle device")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/cpuidle/cpuidle-arm.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
