From: Alex Shi <alex.shi@intel.com>
Subject: Re: [patch v7 0/21] sched: power aware scheduling
Date: Sun, 14 Apr 2013 09:36:52 +0800
Message-ID: <516A0834.6080201@intel.com>
References: <1365040862-8390-1-git-send-email-alex.shi@intel.com> <516724F5.20504@kernel.org> <5167C9FA.8050406@intel.com> <20130412162348.GE2368@pd.tnic> <1365785311.5814.36.camel@marge.simpson.net> <20130412171251.GF2368@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130412171251.GF2368@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Mike Galbraith <efault@gmx.de>, Len Brown <lenb@kernel.org>, mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org, arjan@linux.intel.com, pjt@google.com, namhyung@kernel.org, morten.rasmussen@arm.com, vincent.guittot@linaro.org, gregkh@linuxfoundation.org, preeti@linux.vnet.ibm.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, len.brown@intel.com, rafael.j.wysocki@intel.com, jkosina@suse.cz, clark.williams@gmail.com, tony.luck@intel.com, keescook@chromium.org, mgorman@suse.de, riel@redhat.com, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04/13/2013 01:12 AM, Borislav Petkov wrote:
> On Fri, Apr 12, 2013 at 06:48:31PM +0200, Mike Galbraith wrote:
>> (just saying there are other aspects besides joules in there)
> 
> Yeah, but we don't allow any regressions in sched*, do we? Can we pick
> only the good cherries? :-)
> 

Thanks for all of discussion on this threads. :)
I think we can bear a little power efficient lose when want powersaving.

For second question, the performance increase come from cpu boost
feature, the hardware feature diffined, if there are some cores idle in
cpu socket, other core has more chance to boost on higher frequency. The
task packing try to pack tasks so that left more idle cores.

The difficult to merge this feature into current performance is that
current balance policy is trying to give as much as possible cpu
resources to each of task. that just conflict with the cpu boost condition.

-- 
Thanks
    Alex
