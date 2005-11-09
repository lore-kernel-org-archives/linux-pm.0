From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH 0/2] swsusp: improve freeing of
	memory
Date: Wed, 9 Nov 2005 23:49:03 +0100
Message-ID: <200511092349.03702.rjw@sisk.pl>
References: <200511082355.43984.rjw@sisk.pl>
	<20051109003221.GA22540@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051109003221.GA22540@elf.ucw.cz>
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

Thanks a lot for the review.

On Wednesday, 9 of November 2005 01:32, Pavel Machek wrote:
> Hi!
> 
> > The following two patches are designed to make swsusp free only as much
> > memory as needed for suspend and not as much as possible.  This speeds
> > up the suspend and resume significantly and causes the system to be much
> > more responsive after resume.
> 
> Yep, users will love you :-). But you need to let them know, and that
> probably means cc: on linux-kernel.

Well, that's the first iteration. ;-)

> If you want someone to test crypto swsusp, ask ast@domdv.de. But
> removing that option is okay, too.

And which one do you prefer?

> I still miss those "a"s in "swap".

Ahh, _these_ "a"s.  OK, no problem, I'll add them (I didn't get it
previously, sorry).

> +
> +unsigned int snapshot_nr_pages(void)
> +{
> +       return nr_copy_pages;
> +}
> +
> +struct pbe *snapshot_pblist(void)
> +{
> +       return pagedir_nosave;
> +}
> +
> +void snapshot_pblist_set(struct pbe *pblist)
> +{
> +       pagedir_nosave = pblist;
> +}
> 
> I really hate these. pblist_set( is the worst one. [Still improvement
> from previous versions, through.] Perhaps you can just access the
> variables directly?

Yes.  pagedir_nosave is global anyway, so it's not a big deal.  I've tried to
keep nr_copy_pages static, but it can be global as well, I think.

> If you really want to clean this up, swsusp_save should probably be 
> 
> int swsusp_save(struct pbe **pblist, int *nr_pages)

Then I'll have to mess up with the assembly parts, which I'd like to avoid
as long as reasonable, especially as far as it gets to the ppc one ...

Rafael
