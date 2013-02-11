From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [cpufreq] WARNING: at kernel/lockdep.c:2739 lockdep_trace_alloc()
Date: Mon, 11 Feb 2013 21:08:00 +0800
Message-ID: <20130211130800.GA16039@localhost>
References: <20130211085220.GA10857@localhost>
 <CAKohpo=WRgdBUfzKrs7yeNDCgT6w+j7GPFr8QfbPOShdGgEd1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10294 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757156Ab3BKNId (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Feb 2013 08:08:33 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpo=WRgdBUfzKrs7yeNDCgT6w+j7GPFr8QfbPOShdGgEd1w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 11, 2013 at 02:40:39PM +0530, Viresh Kumar wrote:
> On 11 February 2013 14:22, Fengguang Wu <fengguang.wu@intel.com> wrote:
> > Greetings,
> 
> Hi Fengguang,
> 
> > I got the below oops and the first bad commit is
> >
> > commit 50f6802f8dccb7bbad29010e57973d46b7e7a07e
> > Author: Viresh Kumar <viresh.kumar@linaro.org>
> > Date:   Thu Feb 7 10:55:00 2013 +0530
> 
> There is something really wrong. This problem was earlier reported
> and was fixed immediately. And shouldn't be there with linux-next
> branch of Rafael.
> 
> What tree are you working on ?
> 
> Even in linux-next/master i see above commit as:
> 
> commit 2eaa3e2df185997e92596ab14a2a67dde3876d2e
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Thu Feb 7 10:55:00 2013 +0530
> 
>     cpufreq: Fix locking issues

Viresh, I confirmed that the updated commit is fine. Sorry for the noise!

Fengguang
