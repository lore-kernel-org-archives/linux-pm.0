From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Crash when suspending Lenovo T510 laptop (2.6.39.3)
Date: Fri, 5 Aug 2011 22:30:48 +0200
Message-ID: <201108052230.48862.rjw__7106.48931931264$1312577884$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1108051617430.2055-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1108051617430.2055-100000@iolanthe.rowland.org>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jesper Juhl <jj@chaosbits.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, August 05, 2011, Alan Stern wrote:
> On Fri, 5 Aug 2011, Rafael J. Wysocki wrote:
> 
> > > > I don't know how to fix it yet, but I think I know what the problem is.
> > > > Namely, a runtime suspend of the Ethernet adapter as occured in parallel with
> > > > the system-wide suspend and they clashed.  The runtime suspend has probably
> > > > been provoked by detaching the Ethernet cable from the box.
> > > 
> > > For them to clash in that way would mean that the PM workqueue didn't
> > > get frozen.
> > 
> > Not necessarily, I think.  It's sufficient that system suspend is started
> > while the runtime PM operation is in progress.
> 
> How so?  The system suspend doesn't call down to the subsystems or 
> drivers until after all the threads are frozen.  In this case the stack 
> dump shows that the runtime PM operation was asynchronous, running in a 
> workqueue thread (pm_runtime_work is one of the routines near the end 
> of the stack dump).  The thread wouldn't have frozen until the runtime 
> PM operation was complete.

You're right, sorry.  System suspend was not involved, so the problem
was triggerend by runtime suspend alone, resulting from unplugging the
Ethernet cable.

It looks like the crash started in pci_disable_msi().

Thanks,
Rafael
