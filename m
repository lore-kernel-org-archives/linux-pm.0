From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] freezer: fix freeze timeout on exec
Date: Thu, 8 Nov 2018 11:50:30 +0100
Message-ID: <20181108105030.GB9939@redhat.com>
References: <1541671796-8725-1-git-send-email-chanho.min@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541671796-8725-1-git-send-email-chanho.min@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanho Min <chanho.min@lge.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Christian Brauner <christian@brauner.io>, Anna-Maria Gleixner <anna-maria@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Seungho Park <seungho1.park@lge.com>
List-Id: linux-pm@vger.kernel.org

On 11/08, Chanho Min wrote:
>
> Suspend fails due to the exec family of fuctnions blocking the freezer.
> This issue has been found that it is mentioned in the ancient mail thread.
> The casue is that de_thread() sleeps in TASK_UNINTERRUPTIBLE waiting for all
> sub-threads to die, and we have the "deadlock" if one of them is frozen.
> It causes freeze timeout as bellows.
>
> Freezing of tasks failed after 20.010 seconds (1 tasks refusing to freeze, wq_busy=0):
> setcpushares-ls D ffffffc00008ed70     0  5817   1483 0x0040000d
>  Call trace:
> [<ffffffc00008ed70>] __switch_to+0x88/0xa0
> [<ffffffc000d1c30c>] __schedule+0x1bc/0x720
> [<ffffffc000d1ca90>] schedule+0x40/0xa8
> [<ffffffc0001cd784>] flush_old_exec+0xdc/0x640
> [<ffffffc000220360>] load_elf_binary+0x2a8/0x1090
> [<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
> [<ffffffc00021c584>] load_script+0x20c/0x228
> [<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
> [<ffffffc0001ce8e0>] do_execveat_common.isra.14+0x4f8/0x6e8
> [<ffffffc0001cedd0>] compat_SyS_execve+0x38/0x48
> [<ffffffc00008de30>] el0_svc_naked+0x24/0x28
>
> To fix this, I suggest a patch by emboding the mentioned solution.
> First, revive and rework cancel_freezing_and_thaw() function whitch stops the
> task from sleeping in refrigirator reliably. And, The task to be killed does not
> allow to freeze.

Can't we simply change de_thread() to use freezable_schedule() ?

Oleg.
