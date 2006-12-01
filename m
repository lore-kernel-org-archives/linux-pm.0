From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC][PATCH -mm 1/5] PM: Make
	freeze_processes SMP-safe
Date: Sat, 2 Dec 2006 00:38:42 +0100
Message-ID: <200612020038.43160.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0612011659530.3431-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0612011659530.3431-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: suspend-devel@lists.sourceforge.net, pm list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, 1 December 2006 23:07, Alan Stern wrote:
> On Fri, 1 Dec 2006, Rafael J. Wysocki wrote:
> 
> > Well, the current code does exactly the same - it freezes userland tasks
> > by sending them fake signals (and there's no way to check if such a process
> > holds any locks at that time).  Moreover, it's been doing that from day one
> > and my patch doesn't change that.
> 
> Obviously the scenario I described is very unlikely.  It would depend on 
> a user program doing exactly the wrong thing at the wrong time, _and_ 
> using a USB mass storage device for swapping, _and_ getting an I/O error 
> while reading or writing the memory image.
> 
> > If you have an unfreezeable process that depends on locks that may be held
> > by userland tasks, then _this_ is a bug, IMHO.
> 
> In this case it isn't absolute dependence.  If usb-storage isn't able to
> obtain the lock it needs, then it times out after 1 second and simply
> doesn't reset the device.

Well, I think as long as the system can recover, it's all fine.

> Still, you would have your work cut out trying to find all the places in
> the kernel where an unfreezable process takes a lock which might be held
> by a user process.  For instance, I doubt that all the workqueue threads
> could pass this test.

Fortunately such problems have never been reported, so we can postpone the
hunt for these places a little. ;-)  But seriously, they are potentially dangerous
with the current code, so in fact we'll need to have a look at them at some
point in the future.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
