From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 2/5] swsusp: Use memory bitmaps
	during resume
Date: Wed, 9 Aug 2006 14:04:56 +0200
Message-ID: <200608091404.56737.rjw@sisk.pl>
References: <200608091152.49094.rjw@sisk.pl> <200608091204.36186.rjw@sisk.pl>
	<20060809114942.GS3308@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060809114942.GS3308@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday 09 August 2006 13:49, Pavel Machek wrote:
> > Make swsusp use memory bitmaps to store its internal information during=
 the
> > resume phase of the suspend-resume cycle.
> > =

> > If the pfns of saveable pages are saved during the suspend phase instea=
d of
> > the kernel virtual addresses of these pages, we can use them during the=
 resume
> > phase directly to set the corresponding bits in a memory bitmap.  Then,=
 this
> > bitmap is used to mark the page frames corresponding to the pages that =
were
> > saveable before the suspend (aka "unsafe" page frames).
> > =

> > Next, we allocate as many page frames as needed to store the entire sus=
pend
> > image and make sure that there will be some extra free "safe" page fram=
es for
> > the list of PBEs constructed later.  Subsequently, the image is loaded =
and,
> > if possible, the data loaded from it are written into their "original" =
page frames
> > (ie. the ones they had occupied before the suspend).  The image data th=
at
> > cannot be written into their "original" page frames are loaded into "sa=
fe" page
> > frames and their "original" kernel virtual addresses, as well as the ad=
dresses
> > of the "safe" pages containing their copies, are stored in a list of PB=
Es.
> > Finally, the list of PBEs is used to copy the remaining image data into=
 their
> > "original" page frames (this is done atomically, by the architecture-de=
pendent
> > parts of swsusp).
> > =

> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> =

> ACK. If we get bitmap code we may as well use it. Should wait in -mm
> for a while.

Sure.

> > @@ -53,7 +40,7 @@ static inline void pm_restore_console(vo
> >  static inline int software_suspend(void)
> >  {
> >  	printk("Warning: fake suspend called\n");
> > -	return -EPERM;
> > +	return -ENOSYS;
> >  }
> >  #endif /* CONFIG_PM */
> >  =

> =

> Heh, yes, it is right.. it is also totally unrelated and changes
> userland interface ;-)))... which is probably okay here. But separate
> would be nice.

Ah, well, that's a "btw" thing. ;-)  Will separate.

Rafael
