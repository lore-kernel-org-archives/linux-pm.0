From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Date: Tue, 8 Aug 2006 15:50:35 +0200
Message-ID: <200608081550.36054.rjw@sisk.pl>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<200608081316.00749.rjw@sisk.pl> <20060808111925.GO4025@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060808111925.GO4025@suse.de>
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

On Tuesday 08 August 2006 13:19, Jens Axboe wrote:
> On Tue, Aug 08 2006, Rafael J. Wysocki wrote:
> > On Tuesday 08 August 2006 13:07, Jens Axboe wrote:
> > > On Tue, Aug 08 2006, Jens Axboe wrote:
> > > > On Tue, Aug 08 2006, Rafael J. Wysocki wrote:
> > > > > On Tuesday 08 August 2006 12:43, Jens Axboe wrote:
> > > > > > On Tue, Aug 08 2006, Jiri Slaby wrote:
> > > > > > > Rafael J. Wysocki wrote:
> > > > > > > >On Monday 07 August 2006 18:23, Jason Lunz wrote:
> > > > > > > >>In gmane.linux.kernel, you wrote:
> > > > > > > >>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches=
/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> > > > > > > >>>I tried it and guess what :)... swsusp doesn't work :@.
> > > > > > > >>>
> > > > > > > >>>This time I was able to dump process states with sysrq-t:
> > > > > > > >>>http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
> > > > > > > >>>
> > > > > > > >>>My guess is ide2/2.0 dies (hpt370 driver), since last thin=
g kernel =

> > > > > > > >>>prints is suspending device 2.0
> > > > > > > >>Does it go away if you revert this?
> > > > > > > >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2=
.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-r=
esume.patch
> > > > > > > >>
> > > > > > > >>That should only affect resume, not suspend, but it does me=
ss around
> > > > > > > >>with ide power management. Is this maybe happening on the *=
second*
> > > > > > > >>suspend?
> > > > > > > >>
> > > > > > > >>>-hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache,=
 UDMA(33)
> > > > > > > >>>+hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> > > > > > > >>This looks suspicious. -mm does have several ide-fix-hpt3xx=
 patches.
> > > > > > > >
> > > > > > > >I found that git-block.patch broke the suspend for me.  Stil=
l have no idea
> > > > > > > >what's up with it.
> > > > > > > =

> > > > > > > I suspect elevator changes. The wait_for_completion is not wo=
ken in
> > > > > > > ide-io by ll_rw_blk. But I don't understand block layer too m=
uch.
> > > > > > =

> > > > > > The ide changes are far more likely, it's probably missing a co=
mpletion.
> > > > > =

> > > > > Actually I think the commit f74bf2e6b415588e562fdcfdd454d587eb33c=
d46
> > > > > (Remove ->waiting member from struct request) is wrong, because
> > > > > generic_ide_suspend() uses the end_of_io member of rq to pass the=
 PM data
> > > > > to ide_do_drive_cmd() where the pointer gets overwritten by &wait=
 (must_wait
> > > > > is "true", because action =3D=3D ide_wait).  Previously &wait was=
 stored in
> > > > > rq->waiting and it didn't overwrite the PM data.
> > > > =

> > > > Indeed, that looks broken now. That must be what is screwing it up.=
 With
> > > > the former patch applied, did cdrom detection still look funny to y=
ou?
> > =

> > Hm, I'm not sure what you mean ...
> =

> -hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> +hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)

Ah, that.

> But perhaps that wasn't you?

No, that wasn't me. :-)

> > > > I'll concoct a fix for that breakage.
> > > =

> > > Something like this.
> > =

> > Looks good, I'll give it a try.
> =

> Thanks!

It fixes this particular issue for me, but your first patch (appended) is a=
lso
needed to prevent the box from hanging later during the resume (when it
tries to save the image).

Thanks,
Rafael


--
 drivers/ide/ide-io.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc3-mm2/drivers/ide/ide-io.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.18-rc3-mm2.orig/drivers/ide/ide-io.c
+++ linux-2.6.18-rc3-mm2/drivers/ide/ide-io.c
@@ -402,7 +402,7 @@ void ide_end_drive_cmd (ide_drive_t *dri
 			args[5] =3D hwif->INB(IDE_HCYL_REG);
 			args[6] =3D hwif->INB(IDE_SELECT_REG);
 		}
-	} else if (rq->cmd_type & REQ_TYPE_ATA_TASKFILE) {
+	} else if (rq->cmd_type =3D=3D REQ_TYPE_ATA_TASKFILE) {
 		ide_task_t *args =3D (ide_task_t *) rq->special;
 		if (rq->errors =3D=3D 0)
 			rq->errors =3D !OK_STAT(stat,READY_STAT,BAD_STAT);
