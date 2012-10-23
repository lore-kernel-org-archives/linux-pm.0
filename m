From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: drivers/cpufreq/cpufreq_governor.c:46:53: sparse: incorrect type
 in argument 2 (different modifiers)
Date: Tue, 23 Oct 2012 15:41:19 +0800
Message-ID: <20121023074119.GA921@localhost>
References: <50862255.Foit2oXcLVE39lAk%fengguang.wu@intel.com>
 <CAKohpo=PF-MkG8KDRWSfoBXkK102r7WwToQ01UmfetvarRyK3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:40887 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450Ab2JWHl0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Oct 2012 03:41:26 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpo=PF-MkG8KDRWSfoBXkK102r7WwToQ01UmfetvarRyK3w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Lists linaro-dev <linaro-dev@lists.linaro.org>

Hi Viresh,

On Tue, Oct 23, 2012 at 10:55:51AM +0530, Viresh Kumar wrote:
> Hi Fengguang,
> 
> Thanks for your mail. Few things i learnt from it:
> - Rafael has already applied my patches :)
> - I haven't used sparse in my life till this point. Now i know how to use it.

Good to know that! :-)

> On 23 October 2012 10:21, Fengguang Wu <fengguang.wu@intel.com> wrote:
> > Hi viresh,
> >
> > FYI, there are new sparse warnings show up in
> 
> Actually these aren't new warnings, but old. Because some part is moved from
> one file to another, that's why your script shows them as new warnings.

You are right, the build system is actually catching new "error
messages" strictly speaking.

> Anyway, i don't hesitate in fixing them.

Thanks and appreciated!

Thanks,
Fengguang
