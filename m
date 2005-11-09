From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH 0/2] swsusp: improve freeing of
	memory
Date: Thu, 10 Nov 2005 00:19:30 +0100
Message-ID: <20051109231930.GJ12459@elf.ucw.cz>
References: <200511082355.43984.rjw@sisk.pl>
	<20051109003221.GA22540@elf.ucw.cz>
	<200511092349.03702.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============39068305470437492=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200511092349.03702.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============39068305470437492==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > If you want someone to test crypto swsusp, ask ast@domdv.de. But
> > removing that option is okay, too.
> 
> And which one do you prefer?

Remove, I need something to encourage people to move reading/writing
of image to userland ;-).

> > I still miss those "a"s in "swap".
> 
> Ahh, _these_ "a"s.  OK, no problem, I'll add them (I didn't get it
> previously, sorry).

:-).

> > +void snapshot_pblist_set(struct pbe *pblist)
> > +{
> > +       pagedir_nosave = pblist;
> > +}
....
> > If you really want to clean this up, swsusp_save should probably be 
> > 
> > int swsusp_save(struct pbe **pblist, int *nr_pages)
> 
> Then I'll have to mess up with the assembly parts, which I'd like to avoid
> as long as reasonable, especially as far as it gets to the ppc one ...

No, I do not think you have to. Make swsusp_save() assign to
pagedir_nosave; that's okay. But swsusp_save is part of snapshot.c,
and assembly parts belong logically there, too, so you at least do not
export pagedir_nosave uglyness outside snapshot.c.
								Pavel
-- 
Thanks, Sharp!

--===============39068305470437492==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============39068305470437492==--
