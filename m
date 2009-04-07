From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: pm-hibernate : possible circular locking dependency
 detected
Date: Tue, 07 Apr 2009 10:43:50 +0200
Message-ID: <1239093831.798.5717.camel__34642.8214958452$1239094078$gmane$org@twins>
References: <Pine.LNX.4.44L0.0904061439230.4571-100000@iolanthe.rowland.org>
	<200904062158.11245.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904062158.11245.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Linux Kernel List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Mon, 2009-04-06 at 21:58 +0200, Rafael J. Wysocki wrote:
> On Monday 06 April 2009, Alan Stern wrote:
> > On Mon, 6 Apr 2009, Gautham R Shenoy wrote:
> > 
> > > > If I understand correctly it isn't really a deadlock scenario, but it
> > > > is a lockdep violation.  The violation is:
> > > > 
> > > > 	The pci_device_probe() path 2) proves that dpm_list_mtx [4] can
> > > > 	be acquired while cpu_hotplug.lock [3] is held;
> > > > 
> > > > 	The hibernate() path 3) proves that cpu_hotplug.lock [3] can be
> > > > 	acquired while dpm_list_mtx [4] is held.
> > > > 
> > > > The two pathways cannot run simultaneously (and hence cannot deadlock) 
> > > > because the prepare() stage of hibernation is supposed to stop all 
> > > > device probing.  But lockdep will still report a problem.
> > > 
> > > Thanks for clarifying this Alan. I guess it boils down to teaching
> > > lockdep about this false-positive.
> > 
> > Or else changing the code somehow to avoid the violation completely.  
> > But I have no idea how...  And AFAIK, teaching lockdep about special 
> > cases like this is not so easy to do.
> 
> Yeah, I've just wanted to ask about that.  Peter, how can we do it?

I think it would come down to modeling that blocking of probes as a lock
or something -- because that's basically what it is.

So on the regular probe path, take a read lock of this lock, and on the
suspend path take it as write or something.
