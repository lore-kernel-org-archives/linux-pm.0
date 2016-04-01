From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86: Calculate MHz using APERF/MPERF for cpuinfo and
 scaling_cur_freq
Date: Fri, 1 Apr 2016 11:50:05 +0200
Message-ID: <20160401095005.GA25313@pd.tnic>
References: <6e0c25e64e0fb65a42dfc63ad5f660302e07cd87.1459485198.git.len.brown@intel.com>
 <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com>
 <20160401080328.GC3448@twins.programming.kicks-ass.net>
 <9222CD56-C603-449C-A049-E518DAFA6883@linux.intel.com>
 <20160401082323.GE3448@twins.programming.kicks-ass.net>
 <20160401082923.GH11035@twins.programming.kicks-ass.net>
 <7239BF36-2C27-4325-A5B8-01BC4CA58B4C@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7239BF36-2C27-4325-A5B8-01BC4CA58B4C@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephane Gasparini <stephane.gasparini@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 01, 2016 at 11:30:48AM +0200, Stephane Gasparini wrote:
> The MSRs will not wrap that often.

Unless some yahoo goes and does WRMSR APERF <big_value_close_to_wrap_around>.

I think we should handle that gracefully too, regardless of how "smart"
that move might be.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
