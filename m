From: Tejun Heo <tj@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Wed, 16 Mar 2016 09:35:54 -0700
Message-ID: <20160316163554.GK6980@mtj.duckdns.org>
References: <20160316150053.GG6980@mtj.duckdns.org>
 <Pine.LNX.4.44L0.1603161127020.2250-100000@iolanthe.rowland.org>
 <CAJZ5v0j4DGEiKzKwnw4vc2gD-6XXKt2H656Q1kGrRD==y-s5Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36470 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbcCPQf5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 12:35:57 -0400
Received: by mail-pf0-f175.google.com with SMTP id u190so81385581pfb.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 09:35:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j4DGEiKzKwnw4vc2gD-6XXKt2H656Q1kGrRD==y-s5Fw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, florian@mickler.org, jkosina@suse.cz, Linux-pm mailing list <linux-pm@vger.kernel.org>

Hello, Rafael.

On Wed, Mar 16, 2016 at 05:31:23PM +0100, Rafael J. Wysocki wrote:
> Essentially, every device interface that might be accessed by user
> space would have to be intercepted somehow.

That's what we're doing now.  What I'm suggesting is that we should be
plugging the point where they come together instead of the sources of
which there can be many.  Freezing does block a lot of those sources
but not all.

Thanks.

-- 
tejun
