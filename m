From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: pm-hibernate : possible circular locking dependency
 detected
Date: Mon, 6 Apr 2009 14:42:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0904061439230.4571-100000__10710.3678551086$1239043626$gmane$org@iolanthe.rowland.org>
References: <20090406152038.GB17559@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090406152038.GB17559@in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Rusty Russell <rusty@rustcorp.com.au>, Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Mon, 6 Apr 2009, Gautham R Shenoy wrote:

> > If I understand correctly it isn't really a deadlock scenario, but it
> > is a lockdep violation.  The violation is:
> > 
> > 	The pci_device_probe() path 2) proves that dpm_list_mtx [4] can
> > 	be acquired while cpu_hotplug.lock [3] is held;
> > 
> > 	The hibernate() path 3) proves that cpu_hotplug.lock [3] can be
> > 	acquired while dpm_list_mtx [4] is held.
> > 
> > The two pathways cannot run simultaneously (and hence cannot deadlock) 
> > because the prepare() stage of hibernation is supposed to stop all 
> > device probing.  But lockdep will still report a problem.
> 
> Thanks for clarifying this Alan. I guess it boils down to teaching
> lockdep about this false-positive.

Or else changing the code somehow to avoid the violation completely.  
But I have no idea how...  And AFAIK, teaching lockdep about special 
cases like this is not so easy to do.

Alan Stern
