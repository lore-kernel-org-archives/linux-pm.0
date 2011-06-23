From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PCI / PM: Block races between runtime PM and
 system sleep
Date: Thu, 23 Jun 2011 17:02:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106231656340.2033-100000__44288.4400640198$1308867885$gmane$org@iolanthe.rowland.org>
References: <201106232249.35053.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106232249.35053.rjw@sisk.pl>
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 23 Jun 2011, Rafael J. Wysocki wrote:

> > > Index: linux-2.6/drivers/base/power/runtime.c
> > > ===================================================================
> > > --- linux-2.6.orig/drivers/base/power/runtime.c
> > > +++ linux-2.6/drivers/base/power/runtime.c
> > > @@ -455,12 +455,14 @@ static int rpm_resume(struct device *dev
> > >  	dev_dbg(dev, "%s flags 0x%x\n", __func__, rpmflags);
> > >  
> > >   repeat:
> > > -	if (dev->power.runtime_error)
> > > +	if (dev->power.runtime_error) {
> > >  		retval = -EINVAL;
> > > -	else if (dev->power.disable_depth > 0)
> > > -		retval = -EAGAIN;
> > > -	if (retval)
> > >  		goto out;
> > > +	} else if (dev->power.disable_depth > 0) {
> > > +		if (!(rpmflags & RPM_GET_PUT))
> > > +			retval = -EAGAIN;
> > 
> > Do you also want to check the current status?  If it isn't RPM_ACTIVE 
> > then perhaps you should return an error.
> 
> That depends on whether or not we want RPM_ACTIVE to have any meaning for
> devices whose power.disable_depth is nonzero.  My opinion is that if
> power.disable_depth is nonzero, the runtime PM status of the device
> shouldn't matter (it may be changed on the fly in ways that need not
> reflect the real status).

Then maybe this disable_depth > 0 case should return something other
than 0.  Something new, like -EACCES.  That way the caller would
realize something strange was going on but wouldn't have to treat the 
situation as an error.

After all, the return value from pm_runtime_get_sync() is documented to 
be the error code for the underlying pm_runtime_resume().  It doesn't 
refer to the increment operation -- that always succeeds.

Alan Stern
