From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] pm: Add runtime PM statistics to sysfs
Date: Sat, 10 Jul 2010 09:00:55 -0700
Message-ID: <20100710090055.119f77fd__1918.92421939901$1278777496$gmane$org@infradead.org>
References: <Pine.LNX.4.44L0.1007091056510.1582-100000@iolanthe.rowland.org>
	<Pine.LNX.4.44L0.1007091106070.1582-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007091106070.1582-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 9 Jul 2010 11:11:06 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Fri, 9 Jul 2010, Alan Stern wrote:
> 
> > On Thu, 8 Jul 2010, Arjan van de Ven wrote:
> > 
> > > From: Arjan van de Ven <arjan@linux.intel.com>
> > > Subject: pm: Add runtime PM statistics to sysfs
> > > 
> > > In order for PowerTOP to be able to report how well the new
> > > runtime PM is working for the various drivers, the kernel needs
> > > to export some basic statistics in sysfs.
> > > 
> > > This patch adds two sysfs files in the runtime PM domain that
> > > expose the total time a device has been active, and the time a
> > > device has been suspended.
> > > 
> > > With this PowerTOP can compute the activity percentage
> > > 
> > > Active %age = 100 * (delta active) / (delta active + delta
> > > suspended)
> > > 
> > > and present the information to the user.
> > > 
> > > I've written the PowerTOP code (slated for version 1.12) already,
> > > and the output looks like this:
> > > 
> > > Runtime Device Power Management statistics
> > > Active  Device name
> > >  10.0%	06:00.0 Ethernet controller: Realtek Semiconductor
> > > Co., Ltd. RTL8101E/RTL8102E
> > 
> > 
> > > @@ -411,6 +433,7 @@ int __pm_runtime_resume(struct device *dev,
> > > bool from_wq) }
> > >  
> > >  	if (retval) {
> > > +		update_pm_runtime_accounting(dev);
> > >  		dev->power.runtime_status = RPM_SUSPENDED;
> > >  		pm_runtime_cancel_pending(dev);
> > >  	} else {
> > 
> > This line was added in the wrong place.  It belongs either before
> > the "if (retval) {" or after the "} else {".
> 
> Whoops, sorry, my mistake.  It doesn't belong here at all.  It
> belongs considerably earlier in the function, before the line:

you are correct.

I'll fix it, I think I'll make a small helper that does the account and
assignment in one place, so that we then can have a rule that nobody
updates this field without calling the function


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
