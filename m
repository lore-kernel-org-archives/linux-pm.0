From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] usb: avoid PM error messages during
	resume if a device was disconnected
Date: Wed, 3 Jun 2009 10:08:52 +0200
Message-ID: <200906031008.53326.rjw__44184.7467948266$1244016592$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906022056070.8257-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906022056070.8257-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, Frans Pop <elendil@planet.nl>, linux-usb@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 03 June 2009, Alan Stern wrote:
> On Wed, 3 Jun 2009, Rafael J. Wysocki wrote:
> 
> > > +	/* Avoid PM error messages for devices disconnected while suspended
> > > +	 * as we'll display regular disconnect messages just a bit later.
> > > +	 */
> > > +	if (status == -ENODEV)
> > > +		return 0;
> > > +	return status;
> > 
> > + return status == -ENODEV ? 0 : status;
> > 
> > maybe?
> > 
> > >  }
> > >  
> > >  #endif /* CONFIG_PM */
> 
> Personally, I would do:
> 
> 	if (status == -ENODEV)
> 		status = 0;
> 	return status;
> 
> It doesn't make any difference; they are all equally good.
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

OK

Am I supposed to take this patch directly or push it to Greg?

Rafael
