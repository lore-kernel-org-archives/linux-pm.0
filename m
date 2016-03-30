From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: acpi: policy->driver_data can't be NULL in
 ->exit()
Date: Wed, 30 Mar 2016 16:51:04 +0530
Message-ID: <20160330112104.GF24343@vireshk-i7>
References: <f4f0e029b46cdd09dd7d3f0035e8588f5de94e21.1459311858.git.viresh.kumar@linaro.org>
 <CAJZ5v0hqrUyi2ggsDyOq9y0Q9BzktYdSG6DZQMfMF9HsqRLf0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34925 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbcC3LVI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 07:21:08 -0400
Received: by mail-pf0-f169.google.com with SMTP id n5so40075795pfn.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 04:21:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hqrUyi2ggsDyOq9y0Q9BzktYdSG6DZQMfMF9HsqRLf0g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 30-03-16, 13:15, Rafael J. Wysocki wrote:
> On Wed, Mar 30, 2016 at 6:24 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Its always set by ->init() and so it will always be there in ->exit().
> > There is no need to have a special check for just that.
> 
> I'm not sure what happens if there are two (or more) CPUs in the policy, though.
> 
> That case is almost certainly handled incorrectly here (or rather not
> handled at all), but it may just happen to sort of work, because the
> first exiting CPU will clear driver_data and the second one will
> notice that it is NULL now.  Of course, that still is racy with
> respect to governors etc, but I'd rather fix the driver properly.

Sorry, I probably didn't understood your comments properly.

But, the core will call ->exit() only for the last exiting CPU. So,
driver_data will never be NULL.

-- 
viresh
