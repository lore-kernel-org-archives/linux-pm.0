From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/6] Freezer: Be more verbose
Date: Tue, 10 Jul 2007 17:05:22 +0200
Message-ID: <20070710150522.GB5133@atrey.karlin.mff.cuni.cz>
References: <200707092229.08898.rjw@sisk.pl> <200707092233.52475.rjw@sisk.pl>
	<20070709234625.GK1967@elf.ucw.cz> <200707100801.44087.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707100801.44087.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > --- linux-2.6.22-rc6-mm1.orig/kernel/power/process.c
> > > +++ linux-2.6.22-rc6-mm1/kernel/power/process.c
> > > @@ -237,20 +237,23 @@ static int try_to_freeze_tasks(int freez
> > >   */
> > >  int freeze_processes(void)
> > >  {
> > > -	int error;
> > > +	int error = 0;
> > 
> > You set error unconditionally few lines below.
> 
> Ah, thanks.  There were a couple of versions of this patch and I forgot to
> remove this.
> 
> > > -	printk("Stopping tasks ... ");
> > > +	printk("Freezing user space processes ... ");
> > >  	error = try_to_freeze_tasks(FREEZER_USER_SPACE);
> > >  	if (error)
> > > -		return error;
> > > +		goto Exit;
> > > +	printk("done.\n");
> > >  
> > > +	printk("Freezing remaining freezable tasks ... ");
> > 
> > can we ust do printk(" rest ... "); ? Saves one line... and suspend
> > process is too verbose anyway.
> 
> In fact, this is related to the next patch, in which try_to_freeze_tasks() is
> reworked and without this it won't be clear which phase of the freezing has
> failed (in case of failure, that is).

Ok, ACK , then.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
