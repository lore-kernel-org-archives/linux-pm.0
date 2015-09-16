From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / sleep: Fix broken builds without
 CONFIG_PM_SLEEP_DEBUG
Date: Wed, 16 Sep 2015 08:00:29 +0530
Message-ID: <20150916023029.GC29235@linux>
References: <e7097f9c9cc28de234486e3f3865bf9bbea92aac.1442304707.git.viresh.kumar@linaro.org>
 <20150916020023.GB29235@linux>
 <4506267.XG2T0Et70c@vostro.rjw.lan>
 <13895814.vlsbGKVKtB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <13895814.vlsbGKVKtB@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, alexandra.yates@linux.intel.com, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 16-09-15, 04:54, Rafael J. Wysocki wrote:
> > Yes, it was slightly messed up.  Should be better now, though.

Yeah, its fine now.

> And as a side note, for patches that are in bleeding-edge only and not in
> something like linux-next, you don't need to bother anyone with fixes except
> for me (and maybe the patch author for their education mostly).
> 
> And I either drop patches that cause build problems to happen in bleeding-edge
> or fix them.  That's what bleeding-edge is for.

Okay, will keep that in mind.

-- 
viresh
