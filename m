From: Tejun Heo <tj@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Sun, 20 Mar 2016 14:29:58 -0400
Message-ID: <20160320182958.GR20028@mtj.duckdns.org>
References: <20160318203242.GL20028@mtj.duckdns.org>
 <Pine.LNX.4.44L0.1603181651400.1866-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35869 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbcCTSaA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Mar 2016 14:30:00 -0400
Received: by mail-yw0-f180.google.com with SMTP id g3so193949752ywa.3
        for <linux-pm@vger.kernel.org>; Sun, 20 Mar 2016 11:30:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1603181651400.1866-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, florian@mickler.org, jkosina@suse.cz, Linux-pm mailing list <linux-pm@vger.kernel.org>

Hello,

On Fri, Mar 18, 2016 at 05:06:01PM -0400, Alan Stern wrote:
> The original problem here was that some unfreezable code was waiting
> (via flush_delayed_work) on frozen code, and it was blocking the
> routine that would unfreeze things.  Therefore the order of freezing or
> thawing has no bearing on this particular problem.

Yeah, this one is caused by a high-level kernel construct being frozen
and device resuming as a whole taking place before unfreezing.  The
eventual goal would be avoiding freezing any high-level kernel
constructs as it can lead to circular dependencies as shown here.

> Now, I have nothing against finer-grained control of freezing, although
> I'm not sure how you would implement it in cases where a kthread is not
> per-device but rather is per-driver or per-subsystem.  But we will 
> still have to handle inversions where unfreezable code is waiting for 
> frozen code.

It won't be simple one-to-one conversion for all cases.  It's about
terminating suspend handling where the endpoints actually are after
all.

thanks.

-- 
tejun
