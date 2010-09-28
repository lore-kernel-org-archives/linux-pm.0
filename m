From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: runtime: add missed
	pm_request_autosuspend
Date: Wed, 29 Sep 2010 00:14:42 +0200
Message-ID: <201009290014.42718.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1009271038410.1751-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009271038410.1751-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, September 27, 2010, Alan Stern wrote:
> On Mon, 27 Sep 2010, Ming Lei wrote:
> 
> > 2010/9/27 Alan Stern <stern@rowland.harvard.edu>:
> > > On Mon, 27 Sep 2010 tom.leiming@gmail.com wrote:
> > >
> > >> From: Ming Lei <tom.leiming@gmail.com>
> > >>
> > >> Commit 5789bdd542c6bfbb662915c67bffc14198aa5dda
> > >> [PM / Runtime: Implement autosuspend support] introduces
> > >> "autosuspend" facility for runtime PM, but misses
> > >> helper function of pm_request_autosuspend, so add it.
> > >
> > > I didn't add the helper function because I couldn't think of any
> > > places where it would be needed.  Do you have an example?
> > 
> > I add the helper function since there are the function descriptions
> > more than more in the documentation file of runtime_pm.txt, so I
> > think it is missed.
> > 
> > >
> > >> --- a/include/linux/pm_runtime.h
> > >> +++ b/include/linux/pm_runtime.h
> > >> @@ -164,6 +164,11 @@ static inline int pm_request_resume(struct device *dev)
> > >>       return __pm_runtime_resume(dev, RPM_ASYNC);
> > >>  }
> > >>
> > >> +static inline int pm_request_autosuspend(struct device *dev)
> > >> +{
> > >> +     return __pm_runtime_suspend(dev, RPM_ASYNC | RPM_AUTO);
> > >> +}
> > >> +
> > >>  static inline int pm_runtime_get(struct device *dev)
> > >>  {
> > >>       return __pm_runtime_resume(dev, RPM_GET_PUT | RPM_ASYNC);
> > >>
> > >
> > > This isn't good enough.  If you provide the function then you have to
> > > update the documentation file too.
> > 
> > You have updated the documentation file already in your patch, :-)
> 
> Oops!  You're right.  My mistake, I apologize.  Guess I changed my mind 
> about it and then forgot partway through.  :-)
> 
> Yes, the function should be added.

I applied the patch to suspend-2.6/linux-next.

Thanks,
Rafael
