From: Mike Galbraith <bitbucket@online.de>
Subject: Re: 50 Watt idle power regression bisected to Linux-3.10
Date: Sat, 07 Dec 2013 09:39:50 +0100
Message-ID: <1386405590.5673.96.camel@marge.simpson.net>
References: <CAJvTdK=+aNN66mYpCGgbHGCHhYQAKx-vB0kJSWjVpsNb_hOAtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJvTdK=+aNN66mYpCGgbHGCHhYQAKx-vB0kJSWjVpsNb_hOAtQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Eder <jeder@redhat.com>, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2013-12-07 at 03:00 -0500, Len Brown wrote:

> No, Linux-3.13-rc3 does not fix this issue, even though it contains
> the following patch, claiming to address an issue with the commit above:
> 
> commit ea8117478918a4734586d35ff530721b682425be
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Wed Sep 11 12:43:13 2013 +0200
> 
>     sched, idle: Fix the idle polling state logic
> 
>     Mike reported that commit 7d1a9417 ("x86: Use generic idle loop")
>     regressed several workloads and caused excessive reschedule
>     interrupts.

It fixes that, except for my Q6600 box.  Too bad mwait_idle() went away,
beloved old box doesn't play hints game, so it continues to flog itself.

-Mike
