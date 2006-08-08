From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Date: Tue, 8 Aug 2006 13:16:00 +0200
Message-ID: <200608081316.00749.rjw@sisk.pl>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<20060808110447.GM4025@suse.de> <20060808110726.GN4025@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060808110726.GN4025@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Jiri Slaby <jirislaby@gmail.com>, andre@linux-ide.org, linux-ide@vger.kernel.org, Jason Lunz <lunz@gehennom.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 08 August 2006 13:07, Jens Axboe wrote:
> On Tue, Aug 08 2006, Jens Axboe wrote:
> > On Tue, Aug 08 2006, Rafael J. Wysocki wrote:
> > > On Tuesday 08 August 2006 12:43, Jens Axboe wrote:
> > > > On Tue, Aug 08 2006, Jiri Slaby wrote:
> > > > > Rafael J. Wysocki wrote:
> > > > > >On Monday 07 August 2006 18:23, Jason Lunz wrote:
> > > > > >>In gmane.linux.kernel, you wrote:
> > > > > >>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6=
/2.6.18-rc3/2.6.18-rc3-mm2/
> > > > > >>>I tried it and guess what :)... swsusp doesn't work :@.
> > > > > >>>
> > > > > >>>This time I was able to dump process states with sysrq-t:
> > > > > >>>http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
> > > > > >>>
> > > > > >>>My guess is ide2/2.0 dies (hpt370 driver), since last thing ke=
rnel =

> > > > > >>>prints is suspending device 2.0
> > > > > >>Does it go away if you revert this?
> > > > > >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2=
.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resum=
e.patch
> > > > > >>
> > > > > >>That should only affect resume, not suspend, but it does mess a=
round
> > > > > >>with ide power management. Is this maybe happening on the *seco=
nd*
> > > > > >>suspend?
> > > > > >>
> > > > > >>>-hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDM=
A(33)
> > > > > >>>+hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> > > > > >>This looks suspicious. -mm does have several ide-fix-hpt3xx pat=
ches.
> > > > > >
> > > > > >I found that git-block.patch broke the suspend for me.  Still ha=
ve no idea
> > > > > >what's up with it.
> > > > > =

> > > > > I suspect elevator changes. The wait_for_completion is not woken =
in
> > > > > ide-io by ll_rw_blk. But I don't understand block layer too much.
> > > > =

> > > > The ide changes are far more likely, it's probably missing a comple=
tion.
> > > =

> > > Actually I think the commit f74bf2e6b415588e562fdcfdd454d587eb33cd46
> > > (Remove ->waiting member from struct request) is wrong, because
> > > generic_ide_suspend() uses the end_of_io member of rq to pass the PM =
data
> > > to ide_do_drive_cmd() where the pointer gets overwritten by &wait (mu=
st_wait
> > > is "true", because action =3D=3D ide_wait).  Previously &wait was sto=
red in
> > > rq->waiting and it didn't overwrite the PM data.
> > =

> > Indeed, that looks broken now. That must be what is screwing it up. With
> > the former patch applied, did cdrom detection still look funny to you?

Hm, I'm not sure what you mean ...

> > =

> > I'll concoct a fix for that breakage.
> =

> Something like this.

Looks good, I'll give it a try.

Rafael
