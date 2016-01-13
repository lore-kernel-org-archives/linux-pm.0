From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH RESEND] thermal: power_allocator: req_range
 multiplication should be a 64 bit type
Date: Wed, 13 Jan 2016 16:10:25 +0000
Message-ID: <20160113161024.GD2594@e104805>
References: <1448982923-19416-1-git-send-email-javi.merino@arm.com>
 <20151219134958.GB2594@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41463 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbcAMQK2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Jan 2016 11:10:28 -0500
Content-Disposition: inline
In-Reply-To: <20151219134958.GB2594@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, Zhang Rui <rui.zhang@intel.com>
Cc: dan.carpenter@oracle.com, linux-pm@vger.kernel.org

On Sat, Dec 19, 2015 at 01:49:58PM +0000, Javi Merino wrote:
> Eduardo, Rui,
> 
> On Tue, Dec 01, 2015 at 03:15:23PM +0000, Javi Merino wrote:
> > req_range is declared as a u64 to cope with overflows in the
> > multiplication of two u32.  As both req_power and power_range are u32,
> > we need to make sure the multiplication is done with u64 types.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > ---
> >  drivers/thermal/power_allocator.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Any comments on this?  If not, can it be merged?

If there are no objections, can this be merged?

Thanks,
Javi
