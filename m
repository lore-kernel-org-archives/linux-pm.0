From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC][PATCH -mm 1/5] PM: Make
 freeze_processes SMP-safe
Date: Thu, 30 Nov 2006 10:43:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0611301033440.3204-100000@iolanthe.rowland.org>
References: <200611301607.05122.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200611301607.05122.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 30 Nov 2006, Rafael J. Wysocki wrote:

> In fact, I really mean that if we want a process to go to the refrigerator, we
> have to set PF_FREEZE for it (otherwise try_to_freeze() won't do anytning).
> Thus because we want stopped processes to go to the refrigerator once they
> have received the continuation signal, we have to set PF_FREEZE for them,
> so we should call either freeze_process() or just freeze() for them.
> 
> Now once we have set PF_FREEZE for a stopped process, we shouldn't count
> it as freezeable any more, because we can't do anything more with it.
> Moreover, if the process hasn't received the continuation signal before we
> call freeze_processes(), PF_FREEZE set will still be set for it, so we have to
> clear it (otherwise the process would go to the refrigerator as soon as it
> receives the continuation signal).

I haven't followed the patches, but this obviously is a very tricky issue.  
A stopped process might be waiting for a signal or event that can be sent
only by another process which is already frozen -- in which case the
stopped process is itself effectively frozen without your doing anything
to it.

On the other hand, a stopped process might be waiting for a signal that 
can be sent by an unfreezable process -- and the stopped process might be 
holding a lock which is needed by some other unfreezable process, so you 
need to allow it to run long enough to release the lock before freezing 
it.

Unless you can somehow rule out this scenario (unfreezable process waiting 
for resource held by unfrozen but stopped and freezable process), I don't 
see how this approach can be made to work.

Alan Stern


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
