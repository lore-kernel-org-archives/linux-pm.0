From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: export suspend_set_ops,
	suspend_valid_only_mem
Date: Sun, 26 Jun 2011 11:08:43 +0000
Message-ID: <20110626110843.GC1101__31866.0069875934$1309086607$gmane$org@localhost.ucw.cz>
References: <1306542839-5688-1-git-send-email-khilman@ti.com>
	<201106121620.20442.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201106121620.20442.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun 2011-06-12 16:20:20, Rafael J. Wysocki wrote:
> On Saturday, May 28, 2011, Kevin Hilman wrote:
> > Some platforms wish to implement their PM core suspend code as
> > modules.  To do so, these functions need to be exported to modules.
> > 
> > Reported-by: Jean Pihet <j-pihet@ti.com>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> 
> Applied to suspend-2.6/linux-next.

I'd do export_symbol_gpl on those; it is really tightly coupled...

       			    	      pavel

> > @@ -44,6 +44,7 @@ void suspend_set_ops(const struct platform_suspend_ops *ops)
> >  	suspend_ops = ops;
> >  	mutex_unlock(&pm_mutex);
> >  }
> > +EXPORT_SYMBOL(suspend_set_ops);
> >  
> >  bool valid_state(suspend_state_t state)
> >  {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
