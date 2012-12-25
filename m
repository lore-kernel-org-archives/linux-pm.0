From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 16/25] PM / Domains: don't use [delayed_]work_pending()
Date: Tue, 25 Dec 2012 09:03:28 -0800
Message-ID: <20121225170328.GH10220@mtj.dyndns.org>
References: <1356141435-17340-1-git-send-email-tj@kernel.org>
 <1356141435-17340-17-git-send-email-tj@kernel.org>
 <21556832.hKrqJSonFg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:42810 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921Ab2LYRDd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Dec 2012 12:03:33 -0500
Content-Disposition: inline
In-Reply-To: <21556832.hKrqJSonFg@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

Hello, Rafael.

On Sat, Dec 22, 2012 at 12:57:20PM +0100, Rafael J. Wysocki wrote:
> On Friday, December 21, 2012 05:57:06 PM Tejun Heo wrote:
> > There's no need to test whether a (delayed) work item in pending
> > before queueing, flushing or cancelling it.  Most uses are unnecessary
> > and quite a few of them are buggy.
> 
> Is the particular one you're removing from domain.c buggy?

It's a bit difficult to tell without understanding the code base but
from quick glancing it looks like it could be.  The queueing and
actual excution don't grab the same lock, so there doesn't seem to be
anything work_pending() returning %true for a work item which already
started executing.  Even if the bug is there, it's likely to be very
difficult to trigger tho, so I wouldn't consider it an urgent fix.

Thanks.

-- 
tejun
