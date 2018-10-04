From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from menu_select()
Date: Thu, 4 Oct 2018 19:19:41 +0200
Message-ID: <CAJZ5v0h1Z7MKjq9XY0-tn9U4J3CdycYPbGkM3fjH7-FzaJ=uJA@mail.gmail.com>
References: <3510260.hvypppS8Bs@aspire.rjw.lan> <4130376.2FFt7p4687@aspire.rjw.lan>
 <20181004145116.GB1881@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004145116.GB1881@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 4, 2018 at 4:51 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On Tue, Oct 02, 2018 at 11:44:06PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Rearrange the code in menu_select() so that the loop over idle states
> > always starts from 0 and get rid of the first_idx variable.
> >
> > While at it, add two empty lines to separate conditional statements
> > one another.
> >
> > No intentional behavior changes.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> This code is becoming a bit complex to follow :/
>
> May be I missed something, but it is not possible to enter the condition without
> idx != 0, no ? (I meant the condition if ((drv->states[idx].flags &
> FLAG_POLLING))

Not sure what you mean.

We start with idx = -1, i = 0.  If state[0] is enabled, idx becomes 0.

If the target residency or exit latency of state[0] are already beyond
the limits, we just bail out and state[0] will be returned.

If not, we go to i = 1, but idx is still 0.  If the target residency
of state[1] is beyond predicted_us (which is the interesting case), we
check (drv->states[0].flags & FLAG_POLLING) and so on.

Currently, the polling state must be state[0] (if used at all) anyway.

> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>

Thanks!
