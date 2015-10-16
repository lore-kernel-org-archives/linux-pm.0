From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 4/5] cpufreq: create cpu/cpufreq/policyX directories
Date: Fri, 16 Oct 2015 11:21:18 +0530
Message-ID: <20151016055118.GR19018@linux>
References: <cover.1444924623.git.viresh.kumar@linaro.org>
 <594e7c8e74ca56cef58d29327518f5223e89e208.1444924623.git.viresh.kumar@linaro.org>
 <561FFDA7.3080903@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <561FFDA7.3080903@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15-10-15, 12:25, Saravana Kannan wrote:
> Btw, does a Review-by have an implicit Acked-by?

I have attended a session at Linaro Connect where this was discussed
and the answer was:

Acked-by: is more of a general agreement from the person that he is
fine with the patch, but he might not have done a very careful review
and he isn't really responsible for the patch's content.

Reviewed-by: is a more strict tag and implies that the reviewer has
reviewed it at his best and he is as much responsible for the content
of the patch as the author.

> Kinda unrelated to this patch, but shouldn't this function undo the
> symlinks is has created so far before returning? Otherwise, we'd be
> leaving around broken symlinks.

Hmm, yeah. Will fix it separately.

-- 
viresh
