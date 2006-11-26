From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC][PATCH -mm 4/5] swsusp: Add
	PLATFORM_SNAPSHOT and PLATFORM_RESTORE ioctls
Date: Mon, 27 Nov 2006 00:12:11 +0100
Message-ID: <200611270012.12019.rjw@sisk.pl>
References: <200611252210.58203.rjw@sisk.pl> <200611252245.28687.rjw@sisk.pl>
	<20061126195110.GE12535@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061126195110.GE12535@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sunday, 26 November 2006 20:51, Pavel Machek wrote:
> Hi!
> 
> > Since pm_ops->finish() has to be called after enable_nonboot_cpus() and before
> > device_resume(), from the userland interface perspective it should be treated
> > as a part of the atomic suspend and resume operations.  For this reason we
> > need two additional ioctls to be called instead of ATOMIC_SNAPSHOT and
> > ATOMIC_RESTORE, respectively, when the platform suspend mode is to be used.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  kernel/power/power.h |    4 ++
> >  kernel/power/user.c  |   71 +++++++++++++++++++++++++++++++++++++++++++--------
> >  2 files changed, 64 insertions(+), 11 deletions(-)
> > 
> > Index: linux-2.6.19-rc6-mm1/kernel/power/power.h
> > ===================================================================
> > --- linux-2.6.19-rc6-mm1.orig/kernel/power/power.h
> > +++ linux-2.6.19-rc6-mm1/kernel/power/power.h
> > @@ -133,7 +133,9 @@ struct resume_swap_area {
> >  #define SNAPSHOT_PMOPS			_IOW(SNAPSHOT_IOC_MAGIC, 12, unsigned int)
> >  #define SNAPSHOT_SET_SWAP_AREA		_IOW(SNAPSHOT_IOC_MAGIC, 13, \
> >  							struct resume_swap_area)
> > -#define SNAPSHOT_IOC_MAXNR	13
> > +#define SNAPSHOT_PLATFORM_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 14, unsigned int)
> > +#define SNAPSHOT_PLATFORM_RESTORE	_IO(SNAPSHOT_IOC_MAGIC, 15)
> > +#define SNAPSHOT_IOC_MAXNR	15
> 
> Maybe we should add SNAPSHOT_WITH_FLAGS (uint)
>                     RESTORE_WITH_FLAGS (uint)
> 
> with one of those flags being USE_PLATFORM_MODE? We may need more
> flags in future...

Sure, we can do that.

> ...or maybe have ioctl(fd, USE_PLATFORM_MODE)?

No.  At least I'm not going to implement it. ;-)

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
