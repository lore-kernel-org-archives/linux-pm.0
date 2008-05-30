From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2.6.26-rc4-git] PM: boot time suspend selftest
Date: Fri, 30 May 2008 12:59:48 +0200
Message-ID: <20080530105948.GA12236__43595.0192892507$1212145331$gmane$org@elte.hu>
References: <200805291333.42057.david-b@pacbell.net>
	<20080529162257.03426e48.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080529162257.03426e48.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org


* Andrew Morton <akpm@linux-foundation.org> wrote:

> > +	WARN_ON_ONCE(msec > (TEST_SUSPEND_SECONDS * 1000));
> 
> We should have a comment here explaining what we're warning about.  
> Why would it take more that five seconds?

i asked for that because we had regressions in the past in the form of 
"it takes one minute to resume".

> Better might be to just add a nice printk - I don't think we need the 
> stack trace here.

please keep the warn-on so that it can be detected automatically. Adding 
yet another printk just complicates the automated answer to the "is this 
kernel that just booted up fine or not" question.

In fact i'd love to have the analogue to /proc/lockdep_debug's 
"debug_locks: 0" output. I.e. the kernel should know it via one central 
flag whether any bugs that need human review have been detected so far. 

Say /proc/sys/kernel/kernel_is_buggy. This value could even be 
multi-level: a WARN_ON() increases it by +1, a kernel crash increases it 
by +1000. ( That way i could run overnight tests that will only stop on 
a kernel_is_buggy >= 1000 condition, while it could ignore simpler 
WARN_ON()s. )

	Ingo
