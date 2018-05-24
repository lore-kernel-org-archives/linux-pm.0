From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RFC] suspend: Prevent might sleep splats
Date: Thu, 24 May 2018 17:45:05 +0200
Message-ID: <20180524154505.d5r77w7xinpbc36n@linutronix.de>
References: <20180524142426.jeyszeqdrjvb3tob@linutronix.de>
 <CAJZ5v0jyGVP4h6B=wkhHb7UV2yePHZVjkzodj0Djx-gUBxyMkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jyGVP4h6B=wkhHb7UV2yePHZVjkzodj0Djx-gUBxyMkA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 2018-05-24 17:07:16 [+0200], Rafael J. Wysocki wrote:
> On Thu, May 24, 2018 at 4:24 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> >
> > timekeeping suspend/resume calls read_persistent_clock() which takes
> > rtc_lock. That results in might sleep warnings because at that point
> > we run with interrupts disabled.
> >
> > We cannot convert rtc_lock to a raw spinlock as that would trigger
> > other might sleep warnings.
> >
> > As a workaround we disable the might sleep warnings by setting
> > system_state to SYSTEM_SUSPEND before calling sysdev_suspend() and
> > restoring it to SYSTEM_RUNNING afer sysdev_resume().
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Hmm.  Don't we also need to cover suspend-to-idle?

Well, if you agree with the approach then I would look into it.

Sebastian
