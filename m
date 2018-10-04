From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / core: Clear the direct_complete flag on errors
Date: Thu, 4 Oct 2018 19:47:02 +0200
Message-ID: <CAJZ5v0ih4Hn5W-dTzOayMyMfLMe=djKVhxBcoQ=7oJz6QnpTJQ@mail.gmail.com>
References: <61559514.Vym8FNvob2@aspire.rjw.lan> <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, alcooperx@gmail.com, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 4, 2018 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If __device_suspend() returns early on an error or pending wakeup
> > and the power.direct_complete flag has been set for the device
> > already, the subsequent device_resume() will be confused by it
> > and it will call pm_runtime_enable() incorrectly, as runtime PM
> > has not been disabled for the device by __device_suspend().
>
> I think it would be fair to mention that is related to the async
> suspend path, in dpm_suspend().

OK, fair enough.

> >
> > To avoid that, clear power.direct_complete if __device_suspend()
> > is not going to disable runtime PM for the device before returning.
>
> Overall, by looking at the behavior in dpm_suspend() of async
> suspended devices, it does look a bit fragile to me.
>
> My worries is that we put asynced suspended devices in the
> dpm_suspended_list, no matter if the device was successfully suspended
> or not. This differs from the no-async path.

That's because this was the most straightforward way to organize that
(otherwise you need to worry about the list locking with respect to
the async suspends etc and you really need to preserve the ordering
there).

> In the long run, maybe we should change that instead?

Is there anything wrong with it really?
