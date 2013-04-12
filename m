From: Borislav Petkov <bp@alien8.de>
Subject: Re: [patch v7 0/21] sched: power aware scheduling
Date: Fri, 12 Apr 2013 19:12:51 +0200
Message-ID: <20130412171251.GF2368@pd.tnic>
References: <1365040862-8390-1-git-send-email-alex.shi@intel.com>
 <516724F5.20504@kernel.org>
 <5167C9FA.8050406@intel.com>
 <20130412162348.GE2368@pd.tnic>
 <1365785311.5814.36.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1365785311.5814.36.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>
Cc: Alex Shi <alex.shi@intel.com>, Len Brown <lenb@kernel.org>, mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org, arjan@linux.intel.com, pjt@google.com, namhyung@kernel.org, morten.rasmussen@arm.com, vincent.guittot@linaro.org, gregkh@linuxfoundation.org, preeti@linux.vnet.ibm.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, len.brown@intel.com, rafael.j.wysocki@intel.com, jkosina@suse.cz, clark.williams@gmail.com, tony.luck@intel.com, keescook@chromium.org, mgorman@suse.de, riel@redhat.com, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 12, 2013 at 06:48:31PM +0200, Mike Galbraith wrote:
> (just saying there are other aspects besides joules in there)

Yeah, but we don't allow any regressions in sched*, do we? Can we pick
only the good cherries? :-)

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
