From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] PM: Change ordering of suspend and
	resume code
Date: Mon, 18 Dec 2006 16:10:30 +0100
Message-ID: <200612181610.31039.rjw@sisk.pl>
References: <200612171858.16380.rjw@sisk.pl> <20061218074226.GO26170@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061218074226.GO26170@suse.de>
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
To: Stefan Seyfried <seife@suse.de>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, 18 December 2006 08:42, Stefan Seyfried wrote:
> Hi,
> 
> On Sun, Dec 17, 2006 at 06:58:15PM +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > As indicated in a recent thread on Linux-PM, it's necessary to call
> > pm_ops->finish() before devce_resume(), but enable_nonboot_cpus() has to be
> > called before pm_ops->finish()
> > (cf. http://lists.osdl.org/pipermail/linux-pm/2006-November/004164.html).
> > For consistency, it seems reasonable to call disable_nonboot_cpus() after
> > device_suspend().
> > 
> > This way the suspend code will remain symmetrical with respect to the resume
> > code and it may allow us to speed up things in the future by suspending and
> > resuming devices and/or saving the suspend image in many threads.
> 
> Good. A thread to do progress bars :-)

I thought about something like multiple compression/encryption threads, but
well ... ;-)

> > The first patch changes the ordering of the suspend-to-RAM code and is
> > untested, because my boxes continue refusing to resume from RAM for other
> > reasons.  If anyone can, please do me a favour and test it.
> > 
> > The second patch changes the ordering of the built-in suspend-to-disk code,
> > and the last two patches modify the swsusp userland interface code
> > accordingly.  As far as the last patch is concerned, I've decided to change
> > the existing ioctls, so that the patched kernel works with the "old" userland.
> > I don't think this change breaks anything of importance, but if it does, we
> > can just add (yet) another ioctl to set the platform mode, although in that
> > case the userland would have to be changed as well.
> > 
> > All of the patches are against 2.6.20-rc1 and should not be used with any
> > earlier kernel.
> 
> I'll test them,

Thanks.

> but probably not this year :-( 
> I'll only get to it during the first week of January.

That will be fine.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
