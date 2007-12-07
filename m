From: "huang ying" <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 3/4 -mm] kexec based hibernation -v7 : kexec
	hibernate/resume
Date: Fri, 7 Dec 2007 21:28:55 +0800
Message-ID: <851fc09e0712070528w6701505cr999371ca5ac77307__8460.37628730318$1197034221$gmane$org@mail.gmail.com>
References: <1197042820.24045.63.camel@caritas-dev.intel.com>
	<200712071352.34475.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712071352.34475.rjw@sisk.pl>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Dec 7, 2007 8:52 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, 7 of December 2007, Huang, Ying wrote:
> > This patch implements kexec based hibernate/resume. This is based on
> > the facility provided by kexec_jump. The states save/restore code of
> > ordinary kexec_jump is overridden by hibernate/resume specific
> > code.
>
> Can you explain in more details how this works?

Two blocking notifier chain named kjump_chain_pre and kjump_chain_post
are defined, the basic procedure of kexec jump is as follow:

call functions in kjump_chain_pre
jump to peer kernel
call functions in kjump_chain_post

A command is the first parameter of functions in chain. If A command
is processed in a function, the function will execute and stop the
chain (return NOTIFY_STOP), otherwise it will do nothing (return
NOTIFY_DONE). If no function has interest in the command, the default
behavior will be executed (kexec_vcall_pre, kexec_vcall_post).

So for each command the procedure is as follow:

KJUMP_CMD_HIBERNATE_WRITE_IMAGE:
[chain] kexec_snapshot
jump to kexeced kernel
[chain] kexec_prepare_write_image /* in kexeced kernel */

KJUMP_HIBERNATE_RESUME:
[chain] kexec_prepare_resume /* in kexeced kernel */
jump to kexec kernel
[chain] kexec_resume

> > The ACPI methods are called at specified environment to conform
> > the ACPI specification. A new reboot command is added to go to ACPI S4
> > state from user space.
>
> Well, I still don't like the amount of duplicated code introduced by this patch.

Yes, there are too many duplicated code. They should be merged. But I
want to delay the merging until the kexec based hibernation code goes
more stable.

> Also, IMO it should be using the mutual exclusion mechanisms used by the
> existing hibernation code, ie. pm_mutex and the snapshot_device_available
> atomic variable.

Now the kexec_lock is used as a mutex between kexec related
operations. It seems reasonable to use pm_mutex and maybe
snapshot_device_available to eliminate potential conflict between
kexec based hibernation and u/swsusp.

Best Regards,
Huang Ying
