From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hibernation considerations
Date: Sat, 21 Jul 2007 09:56:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707210954490.8201-100000__46411.1476358541$1185026238$gmane$org@netrider.rowland.org>
References: <200707212243.35602.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707212243.35602.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: david@lang.hm, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

On Sat, 21 Jul 2007, Nigel Cunningham wrote:

> What am I missing in the following suggested solution?
> 
> 1) In the freezer code, we implement a new TIF_LATEFREEZE process flag, which, 
> when set, causes a  userspace process to be frozen with kernel threads 
> instead of with userspace ones. When freezing, we freezing !TIF_LATEFREEZE, 
> sync and then freeze TIF_LATEFREEZE and freezable kernel threads.
> 
> 2) In the fuse code, the PID of the process that will do the work gets passed 
> to the fuse kernel code when the mount is done. The kernel code sets the 
> TIF_LATEFREEZE flag, and resets it on umount.

What happens when one FUSE filesystem makes use of another?  You'll 
still end up with unfreezable processes, except that now you won't 
detect them until the LATEFREEZE stage.

Alan Stern
