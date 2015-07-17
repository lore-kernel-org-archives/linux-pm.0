From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Need a pairing decrement if pm_runtime_get_sync() fails?
Date: Fri, 17 Jul 2015 10:12:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1507170956330.10596-100000@netrider.rowland.org>
References: <86io9jvvyr.fsf@enight.me>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86io9jvvyr.fsf@enight.me>
Sender: linux-kernel-owner@vger.kernel.org
To: Junjie Mao <junjie.mao@enight.me>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Jul 2015, Junjie Mao wrote:

> Hi all,
> 
> While analyzing the source, I notice that many drivers use
> pm_runtime_get_sync() in the following pattern:
> 
>     err = pm_runtime_get_sync(...)
>     if (err < 0) {
>         dev_err(...);
>         return err;
>     }
> 
> Can this lead to the imbalance of runtime PM usage counter, as the
> counter is always incremented in __pm_runtime_resume() regardless of the
> return value?

Yes, it can.

>  Is a pairing decrement (e.g. pm_runtime_put_sync() or
> pm_runtime_put_noidle()) a must on the error-handling path? If so, which
> is a better fix, adding a pairing decrement to each call site, or
> decrementing the usage counter in __pm_runtime_resume() if rpm_resume()
> fails?

The thing is, most errors in runtime resume are not recoverable.  If 
the system isn't able to resume a device now, chances are it won't be 
able to resume the device later.  (The major exception is out-of-memory 
errors.)  That's probably why lots of drivers just give up.

On the other hand, there are places where the code is careful to 
decrement the usage counter when a get_sync fails.  For example, see 
drivers/usb/core/driver.c:usb_autoresume_device().

Another thing to consider is what happens when pm_runtime_get fails.  
The failure occurs after the subroutine call, in a workqueue routine.  
That routine doesn't know whether it should decrement the usage counter 
after a failure.  Perhaps the PM core should be fixed so that it _does_ 
know this.

Then the usage counter could always be adjusted by a core routine after 
a resume failure.  But of course, this means we would have to audit the 
kernel for places where the caller does its own adjustment.

Alan Stern
