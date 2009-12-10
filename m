From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Thu, 10 Dec 2009 17:17:00 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912101653120.2680-100000__40320.730143185$1260483546$gmane$org@iolanthe.rowland.org>
References: <200912102214.40310.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912102214.40310.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 10 Dec 2009, Rafael J. Wysocki wrote:

> > You should see how badly lockdep complains about the rwsems.  If it 
> > really doesn't like them then using completions makes sense.
> 
> It does complain about them, but when the nested _down operations are marked
> as nested, it stops complaining (that's in the version where there's no async
> in the _noirq phases).

Did you set the async_suspend flag for any devices during the test?  
And did you run more than one suspend/resume cycle?

> +extern int __dpm_wait(struct device *dev, void *ign);
> +
> +static inline void dpm_wait(struct device *dev)
> +{
> +	__dpm_wait(dev, NULL);
> +}

Sorry, I intended to mention this before but forgot.  This design is
inelegant.  You shouldn't have inlines calling functions with extra
unused arguments; they just waste code space.  Make dpm_wait() be a
real routine and add a shim to the device_for_each_child() loop.

> @@ -366,7 +388,7 @@ void dpm_resume_noirq(pm_message_t state
>  
>  	mutex_lock(&dpm_list_mtx);
>  	transition_started = false;
> -	list_for_each_entry(dev, &dpm_list, power.entry)
> +	list_for_each_entry(dev, &dpm_list, power.entry) {
>  		if (dev->power.status > DPM_OFF) {
>  			int error;
>  
> @@ -375,23 +397,27 @@ void dpm_resume_noirq(pm_message_t state
>  			if (error)
>  				pm_dev_err(dev, state, " early", error);
>  		}
> +		/* Needed by the subsequent dpm_resume(). */
> +		INIT_COMPLETION(dev->power.completion);

You're still doing it.  Don't initialize the completions in a totally
different phase!  Initialize them directly before they are used.  
Namely, at the start of device_resume() and device_suspend().

One more thing.  A logical time to check for errors is just after
waiting for the children in __device_suspend(), instead of beforehand 
in async_suspend().  After all, if an error occurs then it's likely to 
happen while we are waiting.

Alan Stern
