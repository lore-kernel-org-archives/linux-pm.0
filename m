From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC][PATCH -mm 1/5] PM: Make
 freeze_processes SMP-safe
Date: Fri, 1 Dec 2006 17:07:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0612011659530.3431-100000@iolanthe.rowland.org>
References: <200612012219.44076.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612012219.44076.rjw@sisk.pl>
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

On Fri, 1 Dec 2006, Rafael J. Wysocki wrote:

> Well, the current code does exactly the same - it freezes userland tasks
> by sending them fake signals (and there's no way to check if such a process
> holds any locks at that time).  Moreover, it's been doing that from day one
> and my patch doesn't change that.

Obviously the scenario I described is very unlikely.  It would depend on 
a user program doing exactly the wrong thing at the wrong time, _and_ 
using a USB mass storage device for swapping, _and_ getting an I/O error 
while reading or writing the memory image.

> If you have an unfreezeable process that depends on locks that may be held
> by userland tasks, then _this_ is a bug, IMHO.

In this case it isn't absolute dependence.  If usb-storage isn't able to
obtain the lock it needs, then it times out after 1 second and simply
doesn't reset the device.

Still, you would have your work cut out trying to find all the places in
the kernel where an unfreezable process takes a lock which might be held
by a user process.  For instance, I doubt that all the workqueue threads
could pass this test.

Alan Stern


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
