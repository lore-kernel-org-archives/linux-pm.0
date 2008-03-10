From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Separate suspend and hibernation
 callbacks (highest level) - updated
Date: Sun, 9 Mar 2008 22:52:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803092219290.31643-100000__20638.6307174855$1205117672$gmane$org@netrider.rowland.org>
References: <200803092150.07065.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803092150.07065.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Sun, 9 Mar 2008, Rafael J. Wysocki wrote:

> > If @prepare returns an error (such as -EAGAIN) then @complete shouldn't be called.
> 
> Hmm, I'd prefer to call it if ->prepare() fails too.  The -EAGAIN case is
> special, because in fact there's no warranty that ->prepare() will be called
> again (for example, the new child's ->suspend() may fail before that happens),
> so we need to do the clean up after it.  In general, if ->complete() is assumed
> to be called after a failing ->prepare() too, that simplifies the code a bit.

I'm quite certain this is a bad idea.

The kerneldoc says it all: @complete undoes the changes made by
@prepare.  If @prepare failed then it didn't make any changes (or else
it already undid any changes that were made), so @complete shouldn't be
called.  This is the way all programming interfaces should work.

Don't worry about complicating the core code a little bit.  It's just
in one spot; much more important is that the calling convention should
be clear.  My way is very simple: Every successful call to @prepare is
balanced by exactly one call to @complete.

> First, I moved the pm_dev_dbg() stuff into the inner if () blocks.
> Second, I made it possible to use ->prepare() and ->complete() in the
> "noirq" case as well and added a comment about the "noirq" callbacks.
> Finally, I cut some rough edges here and there (at least I hope so).

There's almost nothing left to comment on in the patch itself.  I'll 
have to try it out before giving any further feedback...

> + * @complete: Undo the changes made by @prepare().  This method is executed for
> + *	all kinds of resume transitions, immediately following one of the resume
> + *	callbacks: @resume(), @thaw(), @restore(), or @recover().  Also executed
> + *	if a suspend callback (@suspend(), @freeze(), @poweroff(), @quiesce())
> + *	immediately following a successful @prepare() fails OR if @prepare()
> + *	itself fails.  @complete() cannot fail.

Of course this comment should be changed to match the actual behavior.  
There's no need to mention that @complete cannot fail; this is obvious
because it returns void.

> + * @thaw: Hibernation-specific, executed after creating a hibernation image.
> + *	Undo the changes made by the preceding @freeze(), so the device can be
> + *	operated in the same was as immediately before the call to @freeze().

s/was/way/   I spotted this typo in @recover before but missed it here.

> +struct pm_ops {
> +#ifdef CONFIG_PM_SLEEP
> +	int (*prepare)(struct device *dev);
> +	void (*complete)(struct device *dev);
> +#endif
> +#ifdef CONFIG_SUSPEND
> +	int (*suspend)(struct device *dev);
> +	int (*resume)(struct device *dev);
> +#endif
> +#ifdef CONFIG_HIBERNATION
> +	int (*freeze)(struct device *dev);
> +	int (*thaw)(struct device *dev);
> +	int (*poweroff)(struct device *dev);
> +	int (*quiesce)(struct device *dev);
> +	int (*restore)(struct device *dev);
> +	int (*recover)(struct device *dev);
> +#endif

Mention perhaps that although the "resuming" operations (i.e.,
resume, thaw, restore, and recover) can return errors, the PM core
doesn't do anything about those errors other than print them in the
system log.  There's nothing it _can_ do...

> +/**
> + * Device power management states
> + *
> + * These state labels are used internally by the PM core to indicate the current
> + * status of a device with respect to the PM core operations.
> + *
> + * DPM_ON		Device is regarded as operational.

Add: Set this way initially and when ->resume(), ->thaw(), ->restore(), 
->recover(), or ->complete() is about to be called.  Also set when 
->prepare() fails.

> + *
> + * DPM_SUSPENDING	Device is currently being suspended.

Add: Set when ->prepare() is about to be called.

> + *
> + * DPM_OFF		Device is regarded as suspended.

Add: Set when ->suspend(), ->freeze(), ->poweroff(), or ->quiesce() is 
about to be called.

Alan Stern
