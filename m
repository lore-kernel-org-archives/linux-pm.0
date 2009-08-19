From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 1/7] PM: Update kerneldoc comments in
 drivers/base/power/main.c
Date: Wed, 19 Aug 2009 18:28:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908191822520.26174-100000__16306.5781853676$1250721298$gmane$org@iolanthe.rowland.org>
References: <200908192357.31358.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908192357.31358.rjw@sisk.pl>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:

> On Monday 17 August 2009, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PM: Update kerneldoc comments in drivers/base/power/main.c
> > 
> > The kerneldoc comments in drivers/base/power/main.c are generally
> > outdated and some of them don't describe the functions very
> > accurately.  Update them and standardize the format to use spaces
> > instead of tabs.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Any objections to this patch from anyone?  Greg, Alan, Randy?

Just some very minor changes.

> >  /**
> > - *	pm_op - execute the PM operation appropiate for given PM event
> > - *	@dev:	Device.
> > - *	@ops:	PM operations to choose from.
> > - *	@state:	PM transition of the system being carried out.
> > + * pm_op - Execute the PM operation appropiate for given PM event.
> > + * @dev: Device to handle.
> > + * @ops: PM operations to choose from.
> > + * @state: PM transition of the system being carried out.
> >   */

Here and in several places below, "appropriate" is missing an "r".

> >  /**
> > - *	pm_noirq_op - execute the PM operation appropiate for given PM event
> > - *	@dev:	Device.
> > - *	@ops:	PM operations to choose from.
> > - *	@state: PM transition of the system being carried out.
> > + * pm_noirq_op - Execute the PM operation appropiate for given PM event.
> > + * @dev: Device to handle.
> > + * @ops: PM operations to choose from.
> > + * @state: PM transition of the system being carried out.
> >   *
> > - *	The operation is executed with interrupts disabled by the only remaining
> > - *	functional CPU in the system.
> > + * The driver of @dev will not receive interrupts while this fuction is being
> > + * executed.
> >   */

Here and in several places below, "function" is missing an "n".

> >  /**
> > - *	dpm_resume - Resume every device.
> > - *	@state: PM transition of the system being carried out.
> > + * dpm_resume - Execute "resume" callbacks for non-sysdev devices.
> > + * @state: PM transition of the system being carried out.
> >   *
> > - *	Execute the appropriate "resume" callback for all devices the status of
> > - *	which indicates that they are inactive.
> > + * Execute the appropriate "resume" callback for all devices the status of which
> > + * indicates that they are suspended.
> >   */

The phrasing is slightly awkward.  "... all devices whose status
indicates..." would be better.  Below as well.

> >  /**
> > - *	dpm_resume_end - Restore state of each device in system.
> > - *	@state: PM transition of the system being carried out.
> > + * dpm_resume_end - Execute "resume" callbacks and complete system transition.
> > + * @state: PM transition of the system being carried out.
> >   *
> > - *	Resume all the devices, unlock them all, and allow new
> > - *	devices to be registered once again.
> > + * Resume all the devices, unlock them all, and complete the PM transition of
> > + * the system.
> >   */

The "unlock them all" part is a fossil.  It should be removed.

Alan Stern
