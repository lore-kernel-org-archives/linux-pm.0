From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: PM / OPP: Add clock-latency-ns support
Date: Wed, 12 Aug 2015 10:58:51 +0300
Message-ID: <20150812075851.GB32040@mwanda>
References: <20150810163804.GA10496@mwanda>
 <20150811081228.GC5509@linux>
 <20150811135122.GL5096@mwanda>
 <20150811185421.GM2839@codeaurora.org>
 <20150812065709.GM32049@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:23203 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933412AbbHLH7A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 03:59:00 -0400
Content-Disposition: inline
In-Reply-To: <20150812065709.GM32049@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org

On Wed, Aug 12, 2015 at 12:27:09PM +0530, Viresh Kumar wrote:
> On 11-08-15, 11:54, Stephen Boyd wrote:
> > Making it portable should be simple enough by having a temporary
> > variable of type u32 though.
> 
> Right.
> 
> @Dan: Does this look fine to you?

Looks good.

regards,
dan carpenter

