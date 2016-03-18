From: Tejun Heo <tj@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Fri, 18 Mar 2016 16:25:26 -0400
Message-ID: <20160318202526.GI20028@mtj.duckdns.org>
References: <20160317000501.GM21104@mtj.duckdns.org>
 <Pine.LNX.4.44L0.1603171455541.2097-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34138 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbcCRUZ3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 16:25:29 -0400
Received: by mail-qk0-f172.google.com with SMTP id p130so331759qke.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2016 13:25:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1603171455541.2097-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jiri Kosina <jikos@kernel.org>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

Hello, Alan.

On Thu, Mar 17, 2016 at 02:58:31PM -0400, Alan Stern wrote:
> Actually, it does cause dependency issues.  The prototype example is
> fuse, when one process can't be frozen because it is waiting in the
> kernel for file I/O to complete, but the I/O involves a fuse filesystem
> and the userspace driver is already frozen.

Fuse is a clearly exceptional case where kernel internals depend on
userland for forward-progress.  I don't think this has much bearing on
the overall design.

Thanks.

-- 
tejun
