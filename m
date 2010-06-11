From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH v4] pm_qos: make update_request non blocking
Date: Fri, 11 Jun 2010 17:49:54 +0200
Message-ID: <20100611174954.41df0606__3316.66879724271$1276271496$gmane$org@schatten.dmk.lab>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276266352.2862.70.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: markgross@thegnar.org, Frederic Weisbecker <fweisbec@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linville@tuxdriver.com, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Fri, 11 Jun 2010 09:25:52 -0500
James Bottomley <James.Bottomley@suse.de> wrote:

> On Thu, 2010-06-10 at 16:41 +0200, Florian Mickler wrote:
> > > > So the notified value is always the latest or there is another
> > > > notification underway.
> > > 
> > > Well, no ... it's a race, and like all good races the winner is non
> > > deterministic.
> > 
> > Can you point out where I'm wrong?
> > 
> > U1. update_request gets called
> > U2. 	new extreme value gets calculated under spinlock
> > U3.	notify gets queued if its WORK_PENDING_BIT is not set.
> > 
> > run_workqueue() does the following:
> > R1. clears the WORK_PENDING_BIT
> > R2. calls update_notify()
> > R3. 	reads the current extreme value
> > R4. 	notification gets called with that value		
> > 
> > 
> > If another update_request comes to schedule_work before
> > run_workqueue() has cleared the WORK_PENDING_BIT, the work will not be
> > requeued, but R3 isn't yet executed. So the notifiers will get the last
> > value.
> 
> So the race now only causes lost older notifications ... as long as the
> consumers are OK with that (it is an API change) then this should work.
> You're still not taking advantage of the user context passed in, though,
> so this does needlessly delay notifications for that case.

Right. We can use execute_in_process_context. 
 
> Actually, pm_qos_remove now needs a flush_scheduled work since you don't
> want to return until the list is clear (since the next action may be to
> free the object).

Yes. Good point, will fix. 

> James
> 

Cheers,
Flo
