From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Dangers of touching disk between
	suspend and resume
Date: Tue, 28 Nov 2006 10:43:51 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0611281034130.3064-100000@iolanthe.rowland.org>
References: <1164727307.26898.12.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1164727307.26898.12.camel@systems03.lan.brontes3d.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: Daniel Drake <ddrake@brontes3d.com>
Cc: suspend-devel@lists.sourceforge.net, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, 28 Nov 2006, Daniel Drake wrote:

> Hi,
> 
> I have some questions about this text in Documentation/power/swsusp.txt:
> 
>  * If you touch anything on disk between suspend and resume...
>  *				...kiss your data goodbye.
> 
> It's obvious that this is a bad idea but I'm interested in the details.
> I'm working with the userspace suspend-to-disk tools in this case.
> 
> Specifically, where it says "kiss your data goodbye" is that saying that
> upon next resume you would lose data in open and unsaved documents (i.e.
> session data), or does it mean that your root partition is effectively
> destroyed?

Almost anything could happen, depending on the type of filesystem and the 
nature of the changes you make to the disk.

> Is the danger only in touching the swap partition where the resume data
> is saved, or is mounting any of the filesystems that are mounted in the
> suspended session dangerous?

Touching _anything_ is dangerous.

> How dangerous?

Like I said above, it depends.

> Are we talking instant loss
> of entire filesystem, or just a chance that some files will be
> corrupted?

File corruption is the most likely outcome, but I wouldn't say that 
losing an entire filesystem is impossible.  You'd have to try pretty hard, 
though.  Running mkfs would certainly do it.  :-)

> When does the corruption happen - during mount after suspend
> but before resume, or during resume after suspend+modifications?

Corruption occurs when you write to the disk.  Note the the disk doesn't
have to be mounted.  In addition, even if you mount an ext3 filesystem
read-only, the fs code will play back the journal -- thereby writing to
the disk.

> What kind of dangers are associated with suspending to disk, modifying
> data on disk but then *not* resuming (doing a complete boot, e.g.
> recreating the swap partition to prevent resume from being attempted)?

It doesn't matter whether or not you modify the disk data before 
rebooting.  Either way, the result will be pretty much the same as if your 
system had crashed at the time of the suspend.

> The context I'm thinking of is an engineer called out to repair a broken
> system. This system will not boot, lets say the RAM is screwed and the
> kernel hangs/panics during early init (before any resuming is
> attempted).
> 
> Without touching the disks, there is no way of knowing if the system was
> shut down fully or suspended-to-disk on last shutdown.

That's not true at all.  You don't have to touch the disks to read them.  
Mount all ext3 filesystems as ext2 and read-only.

> It is unknown
> whether it is safe to plug the disks into another system, mount them and
> recover data (since the last session might have been suspended). Even
> though some part of the hardware is broken, data loss is not an
> acceptable risk (except of course when the hard disks have failed).

It sounds like you're saying that nothing is safe except restarting
(either resume or reboot) on the original failed system.  So that's your
answer -- the only safe approach is to fix the computer and restart it.

Alan Stern


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
