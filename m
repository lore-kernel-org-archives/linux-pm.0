From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: question on freeze and aio
Date: Tue, 13 Feb 2007 16:01:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0702131557400.2741-100000@iolanthe.rowland.org>
References: <20070213101859.GD12996@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070213101859.GD12996@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, 13 Feb 2007, Pavel Machek wrote:

> > No, workqueues are not frozen unless they are explicitly declared as
> > freezeable.  Which currently is only done by XFS, AFAIKS.
> =

> Ok, then we have a bug in swsusp. Can someone locate _which_ workqueue
> is used for aio... and make it freezeable?

Here is an untested patch.  Does anybody have a way to test it?

(BTW, should it be spelled "freezeable" or "freezable"?)

Alan Stern



Index: usb-2.6/fs/aio.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- usb-2.6.orig/fs/aio.c
+++ usb-2.6/fs/aio.c
@@ -73,7 +73,7 @@ static int __init aio_setup(void)
 	kioctx_cachep =3D kmem_cache_create("kioctx", sizeof(struct kioctx),
 				0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 =

-	aio_wq =3D create_workqueue("aio");
+	aio_wq =3D create_freezeable_workqueue("aio");
 =

 	pr_debug("aio_setup: sizeof(struct page) =3D %d\n", (int)sizeof(struct pa=
ge));
 =
