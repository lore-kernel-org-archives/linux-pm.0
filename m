From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] PM: fix async resume following suspend
	failure
Date: Sat, 18 Jun 2011 15:23:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106181521090.32242-100000@netrider.rowland.org>
References: <201106181950.50392.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106181950.50392.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 18 Jun 2011, Rafael J. Wysocki wrote:

> > @@ -596,7 +597,7 @@ void dpm_resume(pm_message_t state)
> >  
> >  	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
> >  		INIT_COMPLETION(dev->power.completion);
> > -		if (is_async(dev)) {
> > +		if (is_async(dev) && dev->power.is_suspended) {
> 
> If we check dev->power.is_suspended here, we won't complete the
> device's power.completion, which is necessary if the device is someone's
> parent.  Moreover, I think we should clear the device's is_prepared
> flage at this point.

Yes.  I was trying to avoid starting up unnecessary threads, but 
clearly that is less important than being correct.

> > @@ -881,6 +882,7 @@ static int __device_suspend(struct devic
> >  	}
> >  
> >   End:
> > +	dev->power.is_suspended = !error;
> >  	device_unlock(dev);
> >  	complete_all(&dev->power.completion);
> 
> This change doesn't seem to be correct too, because error is 0 if
> async_error is true, but the device won't be suspended in that case
> too.

Okay; I should have been more careful.  Thanks for fixing this up.

Alan Stern
