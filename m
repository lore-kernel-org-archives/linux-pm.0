From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Tue, 12 Jul 2016 06:02:31 -0700
Message-ID: <20160712130231.GM4695@ubuntu>
References: <20160701165959.GR12473@ubuntu>
 <2231804.EWgFb9e2VG@vostro.rjw.lan>
 <20160711224601.GJ4695@ubuntu>
 <2571775.VuqrgkDp1o@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33485 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933382AbcGLNCf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2016 09:02:35 -0400
Received: by mail-pa0-f50.google.com with SMTP id ks6so6620507pab.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2016 06:02:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2571775.VuqrgkDp1o@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jan Kara <jack@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>

On 12-07-16, 14:24, Rafael J. Wysocki wrote:
> On Monday, July 11, 2016 03:46:01 PM Viresh Kumar wrote:
> > Yeah and I am not sure how should I go ahead about this issue now :)
> 
> FWIW, I think the reason why the "synchronous printk" works is because after
> disabling the non-boot CPU, the only remaining one disables local interrupts
> and won't do any async work any more until resume.

Right. After disabling interrupts, the other printk messages gets
printed only after the system resumes. I am not that worried about
printk not working after that point, but on how does asynchronous
printing affect the system to crash or come to a complete hang?

Any clues on why that can happen ?

> But you started to talk about suspend/resume and such at one point and that
> message should have been CCed to linux-pm.
> 
> And the reason why is because problems you see during suspend/resume may very
> well be suspend-specific and not visible otherwise.  In which case you'll
> likely need input from the people on linux-pm.

Yeah, I *should* have cc'd the PM list then. Thanks for helping out
Rafael :)

-- 
viresh
