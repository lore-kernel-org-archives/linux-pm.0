From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/6] Suspend: Use common prefix in messages
Date: Tue, 27 Nov 2007 17:16:14 +0100
Message-ID: <200711271716.14562.rjw@sisk.pl>
References: <200711270025.08128.rjw@sisk.pl> <200711270030.10561.rjw@sisk.pl>
	<20071127002145.GD9759@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071127002145.GD9759@elf.ucw.cz>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 27 of November 2007, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Make suspend messages start with one common prefix "PM: ".
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> I do not think I like the PREFIX idea (see other message).

The problem is that we use three different types of messages:
- with no prefix at all
- with "PM: "
- with "swsusp: "
and I think that we should use just one, preferably "PM: ".

> > @@ -344,11 +344,12 @@ static int enter_state(suspend_state_t s
> >  	if (!mutex_trylock(&pm_mutex))
> >  		return -EBUSY;
> >  
> > -	printk("Syncing filesystems ... ");
> > +	printk(KERN_INFO PREFIX "Syncing filesystems ... ");
> >  	sys_sync();
> > -	printk("done.\n");
> > +	printk(KERN_INFO "done.\n");
> 
> 
> Plus this is wrong.

Yes, I've had a temporary blackout regarding prinkt(), not even making much
sense ...

I'll resend the entire series in a while.

Greetings,
Rafael
