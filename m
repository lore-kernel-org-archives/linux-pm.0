From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][PATCH 0/2 -mm] kexec based hibernation
Date: Wed, 29 Aug 2007 12:41:25 +1000
Message-ID: <46D4DCD5.4030601@yahoo.com.au>
References: <9D7649D18729DE4BB2BD7B494F7FEDC257EA60@pdsmsx415.ccr.corp.intel.com>
	<1188180997.3247.68.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1188180997.3247.68.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Huang, Ying wrote:
> On Mon, 2007-08-27 at 09:28 +0800, Hu, Fenghua wrote:
> 
>>One quick question is, can it improve hiberation/wakeup time?
> 
> 
> In general, for kexec based hibernation, what increases
> hibernation/wakeup time:
> 
> - One extra Linux boot is needed to hibernate and wakeup.
> 
> 
> What decreases hibernation/wakeup time:
> 
> - Most hibernation/wakeup work is done in full functional user space
> program, so it is possible to do some optimization, such as parallel
> compression.

- It does not have to reclaim pagecache before suspend?

- It does not have to restore working set afterwards?

(You could do this to reduce image size, of course, but it can
be optional which is nice).


> So, I think the kexec based hibernation may be slower than original
> implementation in general. In this prototype implementation, the
> hibernation/wakeup time is much longer than original hibernation/wakeup
> implementation. But it has much to be optimized and I think it can
> approach the speed of the original implementation after optimization.

Also, don't just look at the time to do a simple suspend/resume cycle,
but the full cost of going from working state to working state (eg.
grep a kernel tree or two!).

Although the kexec details are out of my league, I really like
everything about the concept :) Nice work.

-- 
SUSE Labs, Novell Inc.
