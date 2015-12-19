From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH RESEND] thermal: power_allocator: req_range
 multiplication should be a 64 bit type
Date: Sat, 19 Dec 2015 13:49:59 +0000
Message-ID: <20151219134958.GB2594@e104805>
References: <1448982923-19416-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44660 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753648AbbLSNuC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 19 Dec 2015 08:50:02 -0500
Content-Disposition: inline
In-Reply-To: <1448982923-19416-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>
Cc: dan.carpenter@oracle.com, linux-pm@vger.kernel.org

Eduardo, Rui,

On Tue, Dec 01, 2015 at 03:15:23PM +0000, Javi Merino wrote:
> req_range is declared as a u64 to cope with overflows in the
> multiplication of two u32.  As both req_power and power_range are u32,
> we need to make sure the multiplication is done with u64 types.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>  drivers/thermal/power_allocator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Any comments on this?  If not, can it be merged?

Thanks,
Javi
