From: Tejun Heo <tj@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Wed, 30 Mar 2016 13:09:35 -0400
Message-ID: <20160330170935.GH7822@mtj.duckdns.org>
References: <20160320182958.GR20028@mtj.duckdns.org>
 <Pine.LNX.4.44L0.1603211036360.1708-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33221 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbcC3RJi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 13:09:38 -0400
Received: by mail-yw0-f180.google.com with SMTP id h65so66421579ywe.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 10:09:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1603211036360.1708-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, florian@mickler.org, jkosina@suse.cz, Linux-pm mailing list <linux-pm@vger.kernel.org>

Hello, Alan.

On Mon, Mar 21, 2016 at 10:38:55AM -0400, Alan Stern wrote:
> Even if we avoid freezing any high-level kernel constructs, there will 
> _still_ be problems if a high-level construct blocks waiting for a 
> low-level driver that is plugged... which is exactly the sort of thing 
> that can happen when you call flush_delayed_work().

The problem is caused by or at least made difficult to solve by having
these dependencies lumped up together.  If a device is detected to
have been removed across suspend, the device should be marked as gone
and further IO requests should be failed immediately instead of
getting blocked on filesystem layer generally blocked on global
freezer state.

Thanks.

-- 
tejun
