From: Tejun Heo <tj@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Fri, 18 Mar 2016 16:29:54 -0400
Message-ID: <20160318202954.GK20028@mtj.duckdns.org>
References: <CAJZ5v0i=7Sz17yr1_1fLiJq6oWRDRHOFukkzn3N=y3empshVGw@mail.gmail.com>
 <Pine.LNX.4.44L0.1603171452140.2097-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33950 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbcCRU37 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 16:29:59 -0400
Received: by mail-qk0-f175.google.com with SMTP id p130so383444qke.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2016 13:29:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1603171452140.2097-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jiri Kosina <jikos@kernel.org>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, Mar 17, 2016 at 02:53:42PM -0400, Alan Stern wrote:
> I agree, except that I think the most likely solution is to delay the 
> operations that require a freezable thing until after the system is 
> resumed.

Yes, by following the existing and well-established device suspend
order.

Thanks.

-- 
tejun
