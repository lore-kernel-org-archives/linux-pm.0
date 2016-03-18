From: Tejun Heo <tj@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Fri, 18 Mar 2016 16:29:00 -0400
Message-ID: <20160318202900.GJ20028@mtj.duckdns.org>
References: <alpine.LNX.2.00.1603170036310.3656@cbobk.fhfr.pm>
 <Pine.LNX.4.44L0.1603171453540.2097-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33178 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbcCRU3F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 16:29:05 -0400
Received: by mail-qg0-f47.google.com with SMTP id a36so78511126qge.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2016 13:29:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1603171453540.2097-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jikos@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

Hello,

On Thu, Mar 17, 2016 at 02:55:47PM -0400, Alan Stern wrote:
> > Oh, I definitely belive that the current "holy grail" is to get rid of 
> > ktrehad / kernel code freezing. Userspace is a completely different story, 
> > I agree.
> 
> Why get rid of kernel code freezing?  It is the perfect solution for 
> some problems.

with pretty severe generic problems which are difficult to root out.
It's more about making it finer grained rather than removing it.

Thanks.

-- 
tejun
