From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH v4] pm_qos: make update_request non blocking
Date: Mon, 14 Jun 2010 10:10:06 -0500
Message-ID: <1276528206.5374.24.camel__37677.1551477306$1276528417$gmane$org@mulgrave.site>
References: <1276097381-3982-1-git-send-email-florian@mickler.org>
	<1276097832.4343.223.camel@mulgrave.site>
	<20100609180033.39d5b499@schatten.dmk.lab>
	<1276099645.4343.257.camel@mulgrave.site>
	<20100609183204.1eeca494@schatten.dmk.lab>
	<1276103149.4343.350.camel@mulgrave.site>
	<20100610094525.0449d797@schatten.dmk.lab>
	<1276177144.27283.37.camel@mulgrave.site>
	<20100610164118.15ec7a05@schatten.dmk.lab>
	<1276266352.2862.70.camel@mulgrave.site>
	<20100614163339.755a2b5b@schatten.dmk.lab>
	<1276526646.5374.8.camel@mulgrave.site>
	<20100614164948.3b39d550@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100614164948.3b39d550@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: markgross@thegnar.org, Frederic Weisbecker <fweisbec@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linville@tuxdriver.com, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Mon, 2010-06-14 at 16:49 +0200, Florian Mickler wrote:
> On Mon, 14 Jun 2010 09:44:06 -0500
> James Bottomley <James.Bottomley@suse.de> wrote:
> 
> > On Mon, 2010-06-14 at 16:33 +0200, Florian Mickler wrote:
> > > On Fri, 11 Jun 2010 09:25:52 -0500
> > > James Bottomley <James.Bottomley@suse.de> wrote:
> > > 
> > > > 
> > > > Actually, pm_qos_remove now needs a flush_scheduled work since you don't
> > > > want to return until the list is clear (since the next action may be to
> > > > free the object).
> > > 
> > > The work-items are allocated in the pm_qos objects (which get never
> > > freed), so we should be fine there.
> > 
> > That's not a safe assumption.  Once we get into drivers, timers and cpu
> > ilde states, I can see these things being in modules.
> > 
> > Regardless, it's bad programming practise to be using something after
> > the final remove is called, it certainly violates the principle of least
> > surprise and would usually eventually cause problems.
> > 
> > James
> > 
> 
> I absolutely defer to you in this question. But there is no
> pm_qos_remove at the moment, as far as I see? Should I add one? When
> and how would it be called?
> 
> Maybe I'm not understanding you right at the moment. 

You need to flush in pm_qos_remove_notifier() to make sure you aren't
racing deferred work in the removed notifier with a return from remove,
so that the outcome is always consistent (i.e. the notifier sees all
pending events before removal).  On closer inspection, it looks like the
notifier mutexes are sufficient to make sure it doesn't return running
the notifier to be removed ... but that does mean that add and remove
require user context.

James
