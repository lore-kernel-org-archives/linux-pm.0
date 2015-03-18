From: Ian Malone <ibmalone@gmail.com>
Subject: Re: [PATCH REGRESSION FIX] x86 idle: restore mwait_idle()
Date: Wed, 18 Mar 2015 01:55:48 +0000
Message-ID: <CAL3-7Mqxaeig50JLg0e28TW8eB2HvYMZgWAASayoO-6_BDoXsg@mail.gmail.com>
References: <1ae2a8af42281d6b9888ac8c76bab7bd2f431d44.1389763084.git.len.brown@intel.com>
	<345254a551eb5a6a866e048d7ab570fd2193aca4.1389763084.git.len.brown@intel.com>
	<52D8567A.8090308@mit.edu>
	<1389932442.5449.4.camel@marge.simpson.net>
	<1390037633.5676.3.camel@marge.simpson.net>
	<1390061684.5566.4.camel@marge.simpson.net>
	<CAL3-7MoEXfW0LTdQi3pakL+OaiKcVHPzPng142KKjCX66mNXDg@mail.gmail.com>
	<1426395191.2990.16.camel@gmail.com>
	<CAL3-7Mo_OFdHdGDXq61eNuSqYaQiiGeBWsuGiSBsfcxSa2xExQ@mail.gmail.com>
	<20150317082203.GC28462@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150317082203.GC28462@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>, Andy Lutomirski <luto@amacapital.net>, Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Josh Boyer <jwboyer@redhat.com>, stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 17 March 2015 at 08:22, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Ian Malone <ibmalone@gmail.com> wrote:
>

>> Looks like Ingo Molnar has committed to tip which is probably a good
>> sign, thanks all.
>> (Have to hand this system on to someone who wont be patching kernels...)
>
> Guys, since I don't have the affected hardware, mind testing the
> latest sched/core tree:
>
>   git clone git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>   cd tip
>   git checkout sched/core
>   # build a test kernel and boot it
>
> Or if you already have a kernel git tree, do something like this to
> pick up the scheduler development tree:
>
>   cd linux.git
>   git remote add git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip
>   git remote update
>   git checkout tip/sched/core
>   # build a test kernel and boot it
>
> and check whether the mwait related bugs are now fixed for good?
>

Fixes https://bugzilla.kernel.org/show_bug.cgi?id=60770, thank you.

-- 
imalone
http://ibmalone.blogspot.co.uk
