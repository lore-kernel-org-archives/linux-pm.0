From: Greg KH <gregkh@linuxfoundation.org>
Subject: Commit fcb6a15c2e7e (intel_pstate: Take core C0 time into account
 for core busy calculation) sucks rocks
Date: Wed, 19 Feb 2014 14:47:52 -0800
Message-ID: <20140219224752.GA370@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
Sender: cpufreq-owner@vger.kernel.org
To: Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Dirk,

I've been having some huge slowdowns on my box building kernels, and I
took the time to bisect it down to commit
fcb6a15c2e7e76d493e6f91ea889ab40e1c643a4 (intel_pstate: Take core C0
time into account for core busy calculation).  With that patch reverted
on Linus's current tree, my build speeds are back up to the normal rate.

The difference is huge, 2 minutes to do a kernel build with that patch
reverted, 8-10 minutes with it applied!  With all of the stable kernel
builds and other trees, this is a huge problem for my workload (all I do
is kernel builds it seems...)

I see some patches you marked as "fixes" that you sent to Rafael, do you
want me to test any of those?  How am I the only one seeing this
problem, do you need my cpu information or anything else?

Oh, and because of the problems, I'll just drop this patch from the
-stable trees for now, I don't want to pollute them with the issue until
it is resolved properly.

thanks,

greg k-h
