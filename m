From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH 0/2] swsusp: improve freeing of
	memory
Date: Thu, 10 Nov 2005 11:34:18 +0100
Message-ID: <200511101134.18484.rjw@sisk.pl>
References: <200511082355.43984.rjw@sisk.pl> <200511092349.03702.rjw@sisk.pl>
	<20051109231930.GJ12459@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051109231930.GJ12459@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday, 10 of November 2005 00:19, Pavel Machek wrote:
> Hi!
> 
> > > If you want someone to test crypto swsusp, ask ast@domdv.de. But
> > > removing that option is okay, too.
> > 
> > And which one do you prefer?
> 
> Remove, I need something to encourage people to move reading/writing
> of image to userland ;-).

OK
I'll do it in a separate patch if you don't mind.

> > > I still miss those "a"s in "swap".
> > 
> > Ahh, _these_ "a"s.  OK, no problem, I'll add them (I didn't get it
> > previously, sorry).
> 
> :-).
> 
> > > +void snapshot_pblist_set(struct pbe *pblist)
> > > +{
> > > +       pagedir_nosave = pblist;
> > > +}
> ....
> > > If you really want to clean this up, swsusp_save should probably be 
> > > 
> > > int swsusp_save(struct pbe **pblist, int *nr_pages)
> > 
> > Then I'll have to mess up with the assembly parts, which I'd like to avoid
> > as long as reasonable, especially as far as it gets to the ppc one ...
> 
> No, I do not think you have to.

I mean swsusp_save() is called from the assembly and currently does not take
any arguments, so I'll have to change the assembly to make it take some.

> Make swsusp_save() assign to 
> pagedir_nosave; that's okay. But swsusp_save is part of snapshot.c,
> and assembly parts belong logically there, too, so you at least do not
> export pagedir_nosave uglyness outside snapshot.c.

swsusp_save() already sets pagedir_nosave and that's not a problem.
[BTW swsusp_save() could return the number of the image pages,
but this would change the meaning of swsusp_arch_suspend()'s
return value too.]

The problem with pagedir_nosave is on resume, because we have to tell
the snapshot part where the pagedir starts.  One solution is to make
swsusp_read() like this:

int swsusp_read(struct pbe **);

and pass the pagedir_nosave's address to it.  Analogously, swsusp_write()
could be made like this:

int swsusp_write(unsigned int nr_pages);

and pass nr_pages to write_suspend_image().

Would that be OK?

Rafael
