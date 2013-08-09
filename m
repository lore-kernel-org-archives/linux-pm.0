From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 2/2] cpuidle: kirkwood: Staticize local symbol
Date: Fri, 9 Aug 2013 07:37:59 -0400
Message-ID: <20130809113759.GP8204@titan.lakedaemon.net>
References: <000601ce94cf$ae4f0b40$0aed21c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33895 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754606Ab3HILiF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2013 07:38:05 -0400
Content-Disposition: inline
In-Reply-To: <000601ce94cf$ae4f0b40$0aed21c0$@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 'Silviu-Mihai Popescu' <silviupopescu1990@gmail.com>

On Fri, Aug 09, 2013 at 04:11:34PM +0900, Jingoo Han wrote:
> This local symbol is used only in this file.
> Fix the following sparse warnings:
> 
> drivers/cpuidle/cpuidle-kirkwood.c:73:5: warning: symbol 'kirkwood_cpuidle_remove' was not declared. Should it be static?
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/cpuidle/cpuidle-kirkwood.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
