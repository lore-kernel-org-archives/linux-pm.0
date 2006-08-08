From: Jens Axboe <axboe@suse.de>
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Date: Tue, 8 Aug 2006 12:43:54 +0200
Message-ID: <20060808104353.GK4025@suse.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <44D707B6.20501@gmail.com>
	<20060807162322.GA17564@knob.reflex>
	<200608072247.59184.rjw@sisk.pl> <44D8626F.4020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44D8626F.4020101@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, andre@linux-ide.org, linux-pm@osdl.org, linux-ide@vger.kernel.org, Jason Lunz <lunz@gehennom.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 08 2006, Jiri Slaby wrote:
> Rafael J. Wysocki wrote:
> >On Monday 07 August 2006 18:23, Jason Lunz wrote:
> >>In gmane.linux.kernel, you wrote:
> >>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-=
rc3/2.6.18-rc3-mm2/
> >>>I tried it and guess what :)... swsusp doesn't work :@.
> >>>
> >>>This time I was able to dump process states with sysrq-t:
> >>>http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
> >>>
> >>>My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel =

> >>>prints is suspending device 2.0
> >>Does it go away if you revert this?
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc=
3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch
> >>
> >>That should only affect resume, not suspend, but it does mess around
> >>with ide power management. Is this maybe happening on the *second*
> >>suspend?
> >>
> >>>-hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> >>>+hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> >>This looks suspicious. -mm does have several ide-fix-hpt3xx patches.
> >
> >I found that git-block.patch broke the suspend for me.  Still have no id=
ea
> >what's up with it.
> =

> I suspect elevator changes. The wait_for_completion is not woken in
> ide-io by ll_rw_blk. But I don't understand block layer too much.

The ide changes are far more likely, it's probably missing a completion.

> Where the blk_end_sync_rq should be called from (why is not called at
> all)?

It's called from ->end_io() in end_that_request_last().

-- =

Jens Axboe
