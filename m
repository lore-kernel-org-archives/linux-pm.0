From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/3] power, vfs: move away from PF_KTHREAD freezing in
 favor of fs freezing
Date: Mon, 2 Nov 2015 12:05:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511021157320.22567@pobox.suse.cz>
References: <alpine.LNX.2.00.1510301424360.17538@pobox.suse.cz> <alpine.LNX.2.00.1510301439080.17538@pobox.suse.cz> <F50CC49E-C818-4631-AFB1-25A6EDC09BB0@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <F50CC49E-C818-4631-AFB1-25A6EDC09BB0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yalin wang <yalin.wang2010@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2 Nov 2015, yalin wang wrote:

> do you test your patch on kthread_bind()  kernel thread ?
> if you remove freeze_kernel_threads() function,
> this means lots of pthread will be running status during suspend .

pthreads? Again, userspace is frozen by that time.

> will have problem for bind thread , these thread will be migrate to other 
> CPU , will have problem running code on other CPU, another problems is 
> that the cpu_allowed_ptr is changed and will never be restore to original CPU mask .

Hmm, shouldn't that be fixed instead?

I mean, select_fallback_rq() will surely force a rq outside of the 
cpus_allowed if needed. I can imagine kthread bound to a particular CPU 
either wanting to keep itself affine to that CPU (and be scheduled out 
until CPU becomes online again), or it might want to actually be forced to 
another CPU and migrated back once "its own" CPU becomes available again.

But then yes, indeed, at the end of the day this is more or less what 
try_to_freeze() gives you. Fair enough, this might be one of cases where 
freezer for kthreads is actually useful (and would need to be documented 
to provide this semantics).

kthread CPU binding seems to be used by ~7 kthreads altogether in the 
kernel. Funily enough, quite some of them do not call try_to_freeze() at 
all. Which just demonstrates my point regarding how messy the current 
state of affairs is.

-- 
Jiri Kosina
SUSE Labs
