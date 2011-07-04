From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: Random freezing failure with NFS and automount
Date: Mon, 4 Jul 2011 22:44:49 +0530
Message-ID: <20110704171449.GC5357@dirshya.in.ibm.com>
References: <20110628155054.GA23242@dirshya.in.ibm.com>
	<201107030907.18203.rjw@sisk.pl>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201107030907.18203.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

* Rafael J. Wysocki <rjw@sisk.pl> [2011-07-03 09:07:18]:

> Hi,
> 
> On Tuesday, June 28, 2011, Vaidyanathan Srinivasan wrote:
> > Hi,
> > 
> > I have random freezing failures on my laptop running 2.6.39 kernel.
> > The laptop has NFS client and automount.  Network could have been
> > disconnected by the time suspend is attempted, hence nfs client should
> > fail all operations, just freeze and allow laptop to suspend.
> > 
> > I need some help to drill deeper at this log and also suggestions on
> > config options to try and get more information to help me root cause
> > this issue.
> > 
> > This happens once in 4-5 suspend/resume cycles, does not succeed on
> > retry, eventually I have to reboot.
> 
> This is a tasks freezer failure, ie. the freezing of tasks fails, because
> one of them refuses to handle signals for 20 s.  This is probably related
> to waiting on a VFS mutex in the TASK_UNINTERRUPTIBLE state.
> 
> We don't handle those cases nicely right now, sorry about that.

Hi Rafael,

Thanks for taking a look.  The NFS mount option in hard,intr so
I would expect an interruptible sleep.  I will take this to file
system folks and see if they can help.  I will also review my mount
options to improve the situation.

When you said we are not handling the situation, what did you mean?
We seem to cleanly unfreeze the tasks and return the system to working
state (though suspend fails).  Maybe we should send some signals and
try to prod the failing task to get to freeze?  What is needed here to
improve our framework?

--Vaidy
