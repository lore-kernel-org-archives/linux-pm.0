From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Wed, 2 May 2007 18:11:54 +0400
Message-ID: <8f8ff01d0705020711r630b8b92sdd2cd9316eb39edc@mail.gmail.com>
References: <20070425072350.GA6866@ucw.cz> <200705020002.55331.rjw@sisk.pl>
	<8f8ff01d0705012213j54f15c4er2897731336b1ddb5@mail.gmail.com>
	<200705021542.24988.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705021542.24988.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

Rafael,

> Concluding, it seems to me that the "restore" code path is correct, but the
> "hibernate" code path is not and should be reworked.  Also, it seems that
> acpi_pm_prepare() and acpi_pm_enter() should be fixed for the s2ram case
> either (_PTS should be executed after device_suspend() and _GTS should
> be executed in acpi_pm_enter(), right before the transition is completed).

Current implementation is not fully up-to spec, so we may try to get
it closer to, I agree.

> When we restore the system state from a hibernation image, the "boot kernel" is
> first started.  It loads the image into memory, calls
> device_suspend(PMSG_PRETHAW), suspends sysdevs etc., and replaces itself with
> the "resumed kernel".  It doesn't call acpi_pm_prepare(), which I think is
> right, because it doesn't want to start any power transition, not even a
> fake one.  Now, the "resumed kernel" takes control, resumes sysdevs and calls
Currently call to prepare() is needed to stop ACPI devices to send
GPEs to ACPI drivers.
If you remove it, Acer laptops will resume without ACPI interrupt at
all (with all problems from it).
> acpi_pm_finish(), which seems to be about OK, except that I'm not sure if _BFS
> should be executed in that case (the ACPI spec seems to assume that the
> hibernation image will be loaded into memory by a boot loader).

> Next, we suspend sysdevs etc., and create the memory snapshot.  We want
> to be able to save it, so w call acpi_pm_finish(), which causes _BFS and _WAK
> to be executed *after* _GTS, which is clearly against the spec (might this be the
> reason why (7) is sometimes necessary?).  Moreover, calling _BFS at this stage
> makes no sense, IMHO, since there hasn't been any transition (the system has
> not slept).  What I think we should do at this point is to execute _WAK only,
> which means "power transition aborted" to the firmware, and continue with
> device_resume().

But I don't get your idea about executing _finish() between _prepare()
and _enter()...
_finish is executed only if _prepare() fails, so we are rolling back,
or it is executed after we loaded the image and transfered execution
to it, so again -- we are going from _prepare() state to running
state...

Regards,
Alex.
