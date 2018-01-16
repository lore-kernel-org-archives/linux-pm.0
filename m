From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3] thermal: Add cooling device's statistics in sysfs
Date: Tue, 16 Jan 2018 14:14:20 +0530
Message-ID: <20180116084420.GI22978@vireshk-i7>
References: <087186fecdfd85bead58e110cf8bf7ccdfab517b.1515663078.git.viresh.kumar@linaro.org>
 <20180112174606.GA11076@localhost.localdomain>
 <20180115044616.GC22978@vireshk-i7>
 <20180115163221.GA3756@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180115163221.GA3756@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 15-01-18, 08:32, Eduardo Valentin wrote:
> On Mon, Jan 15, 2018 at 10:16:16AM +0530, Viresh Kumar wrote:
> > No because I am exiting early for same sates in that routine.
> 
> Did I miss that hunk?

Yes. It is something like this.

+       if (stats->state == new_state)
+               goto unlock;
+

-- 
viresh
