From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Thu, 14 Jul 2016 08:38:36 +0900
Message-ID: <20160713233836.GA28362@kroah.com>
References: <20160701172232.GD28719@htj.duckdns.org>
 <20160706182842.GS2671@ubuntu>
 <20160711102603.GI12410@quack2.suse.cz>
 <20160711154438.GA528@swordfish>
 <20160711223501.GI4695@ubuntu>
 <20160712231903.GR4695@ubuntu>
 <20160713054507.GA563@swordfish>
 <20160713153910.GY4695@ubuntu>
 <CAJZ5v0ifOMb=wCvCRoGb2AHTfGLc0z10_fPUYVMP3pH_kWtr4A@mail.gmail.com>
 <20160713231858.GG4695@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42936 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbcGMXie (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 19:38:34 -0400
Content-Disposition: inline
In-Reply-To: <20160713231858.GG4695@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Alex Elder <alex.elder@linaro.org>, johan@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Linux PM <linux-pm@vger.kernel.org>, Petr Mladek <pmladek@suse.com>

On Wed, Jul 13, 2016 at 04:18:58PM -0700, Viresh Kumar wrote:
> > Are all of those messages printed actually useful?
> 
> Hmm, maybe not. But that's not the point I was trying to raise, as I
> earlier mentioned :)
> 
> We have a problem with asynchronous printing after disabling
> interrupts on the last running CPU, and we are trying to disable that
> from suspend_console(), because we already have a function to call
> this from.

Note, this problem has also been seen in "the wild" in a number of
3.10-based systems where a printk message happens right when suspend is
happening.  If we are unlucky, it hits, causing a watchdog to trigger
and the system is reset.  My personal phone happens to be one of those
"unlucky" ones and is reset every other day or so due to this bug :(

So yes, lots of printk() messages will cause this to be hit more often,
like in the system that Viresh is working on here.  But it will also
trigger on "normal" systems as well, just much more infrequently.

thanks,

greg k-h
