From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Sat, 30 Jul 2016 11:12:17 +0900
Message-ID: <20160730021217.GA531@swordfish>
References: <20160701165959.GR12473@ubuntu>
 <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu>
 <20160713054507.GA563@swordfish>
 <20160729204201.GA4605@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34821 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbcG3CMt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2016 22:12:49 -0400
Content-Disposition: inline
In-Reply-To: <20160729204201.GA4605@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, rjw@rjwysocki.net, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>

On (07/29/16 13:42), Viresh Kumar wrote:
[..]
> I haven't seen any issues with it yet and it works just fine. Please feel free
> to add below for the entire series including this hunk.
> 
> Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks a lot!
will refresh the series next week.

sorry, haven't gotten many chances to investigate the sched
throttling so far.

	-ss
