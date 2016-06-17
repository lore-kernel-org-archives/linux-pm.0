From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND PATCH v2 2/2] power/idle: enhance the precision of
 sleep_length
Date: Fri, 17 Jun 2016 11:27:37 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1606171125460.5839@nanos>
References: <1466154816-17900-1-git-send-email-zhaoyang.huang@spreadtrum.com> <1466154816-17900-2-git-send-email-zhaoyang.huang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49589 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbcFQJ3p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 05:29:45 -0400
In-Reply-To: <1466154816-17900-2-git-send-email-zhaoyang.huang@spreadtrum.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, zhaoyang.huang@spreadtrum.com

On Fri, 17 Jun 2016, Zhaoyang Huang wrote:
> There should be a gap between tick_nohz_idle_enter and
> tick_nohz_get_sleep_length when idle, which will cause the
> sleep_length is not very precised. Change it in this patch.

What kind of imprecision are we talking about? Seconds, nanoseconds or
lightyears?

Your changelog lacks any form of useful information.

Thanks,

	tglx

 
