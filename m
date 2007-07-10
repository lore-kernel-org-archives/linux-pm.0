From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 3/6] Freezer: Be more verbose
Date: Tue, 10 Jul 2007 08:01:43 +0200
Message-ID: <200707100801.44087.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl> <200707092233.52475.rjw@sisk.pl>
	<20070709234625.GK1967@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070709234625.GK1967@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, 10 July 2007 01:46, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Increase the freezer's verbosity a bit, so that it's easier to read problem
> > reports related to it.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  kernel/power/process.c |   17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> > 
> > Index: linux-2.6.22-rc6-mm1/kernel/power/process.c
> > ===================================================================
> > --- linux-2.6.22-rc6-mm1.orig/kernel/power/process.c
> > +++ linux-2.6.22-rc6-mm1/kernel/power/process.c
> > @@ -237,20 +237,23 @@ static int try_to_freeze_tasks(int freez
> >   */
> >  int freeze_processes(void)
> >  {
> > -	int error;
> > +	int error = 0;
> 
> You set error unconditionally few lines below.

Ah, thanks.  There were a couple of versions of this patch and I forgot to
remove this.

> > -	printk("Stopping tasks ... ");
> > +	printk("Freezing user space processes ... ");
> >  	error = try_to_freeze_tasks(FREEZER_USER_SPACE);
> >  	if (error)
> > -		return error;
> > +		goto Exit;
> > +	printk("done.\n");
> >  
> > +	printk("Freezing remaining freezable tasks ... ");
> 
> can we ust do printk(" rest ... "); ? Saves one line... and suspend
> process is too verbose anyway.

In fact, this is related to the next patch, in which try_to_freeze_tasks() is
reworked and without this it won't be clear which phase of the freezing has
failed (in case of failure, that is).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
