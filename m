From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Tue, 12 Jul 2016 13:08:34 -0700
Message-ID: <20160712200834.GO4695@ubuntu>
References: <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712093805.GA498@swordfish>
 <20160712125243.GA8597@pathway.suse.cz>
 <20160712131203.GN4695@ubuntu>
 <20160712171113.GD4695@ubuntu>
 <CAJZ5v0jNgDkkBAX0teTo8MEHa2f+5+TAmiyFWwvEUjTkEez9Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34841 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbcGLUIm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2016 16:08:42 -0400
Received: by mail-pa0-f48.google.com with SMTP id dx3so9779609pab.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2016 13:08:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jNgDkkBAX0teTo8MEHa2f+5+TAmiyFWwvEUjTkEez9Jg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Linux PM <linux-pm@vger.kernel.org>

On 12-07-16, 21:59, Rafael J. Wysocki wrote:
> It looks like a new printk() waits for a previous one to make progress
> and since progress cannot be made under the suspend conditions, it
> waits forever.

Thanks.

Maybe, but to mention this clearly again, this doesn't happen
every time. Sometime it takes 100 suspend/resume cycles to hit this
thing.

Lets see what Jan and Sergey have to say on this, as they were the
ones who wrote these patches :)

-- 
viresh
