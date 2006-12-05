From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 1/2]: PM: Fix handling of stopped
	tasks
Date: Tue, 5 Dec 2006 14:13:31 +0000
Message-ID: <20061205141331.GB4637@ucw.cz>
References: <200612032318.29030.rjw@sisk.pl> <200612032350.23067.rjw@sisk.pl>
	<20061205103429.GB5306@elf.ucw.cz> <200612051206.40709.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200612051206.40709.rjw@sisk.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, pm list <linux-pm@lists.osdl.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Actually, what do you think about this patch? It removes special
> > handling of TASK_TRACED, and should do the trick, too...
> 
> Well, I don't think so, ....

> > @@ -1702,7 +1702,9 @@ finish_stop(int stop_count)
> >  		read_unlock(&tasklist_lock);
> >  	}
> >  
> > -	schedule();
> > +	do {
> > +		schedule();
> > +	} while (try_to_freeze());
> >  	/*
> >  	 * Now we don't run again until continued.
> >  	 */
> 
> ... because if you want try_to_freeze() here to trigger, then the task in
> question should have PF_FREEZE set, but we don't set it anywhere.

?? We set it to all the processes, so stopped processes get it,
too...??
							Pavel

-- 
Thanks for all the (sleeping) penguins.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
