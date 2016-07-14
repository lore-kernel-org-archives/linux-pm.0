From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Preemption (hogging) of the work handler
Date: Thu, 14 Jul 2016 15:14:37 -0700
Message-ID: <20160714221437.GF3057@ubuntu>
References: <20160701165959.GR12473@ubuntu>
 <163184622.ctfAvoN0Mo@vostro.rjw.lan>
 <20160714143939.GF13151@quack2.suse.cz>
 <56498260.j02nbY6ACm@vostro.rjw.lan>
 <20160714145554.GG13151@quack2.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35278 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbcGNWOo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2016 18:14:44 -0400
Received: by mail-pf0-f182.google.com with SMTP id c2so34275662pfa.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2016 15:14:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160714145554.GG13151@quack2.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vlevenetz@mm-sol.com, vaibhav.hiremath@linaro.org, alex.elder@linaro.org, johan@kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, linux-pm@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>

On 14-07-16, 16:55, Jan Kara wrote:
> Agree on that - but that seems to be a problem of a particular wakeup
> implementation of the 3.10 kernel Viresh is using, not a problem of the
> upstream kernel.

I think we can get it to trigger on mainline as well. Also to mention that I
also don't see it on every suspend. Probably hrtimer_active() call returns true
in the sequence somewhere earlier, and we don't have to go activate a hrtimer.

-- 
viresh
