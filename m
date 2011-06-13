From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Question about expected behavior when PM runtime is
 disabled
Date: Mon, 13 Jun 2011 16:33:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106131618450.1983-100000@iolanthe.rowland.org>
References: <201106132151.17569.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106132151.17569.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 13 Jun 2011, Rafael J. Wysocki wrote:

> > I think we need to have the PM core call pm_runtime_get_noresume()  
> > before invoking the resume_noirq (or thaw_noirq or restore_noirq)  
> > callback, and then call pm_runtime_put_sync() after invoking the
> > complete callback.  This would solve your race: The put_sync would 
> > invoke the runtime_idle method, which would start another runtime 
> > suspend or autosuspend.
> > 
> > (It used to be that the PM core called pm_runtime_get_noresume() 
> > earlier on, before the prepare callback.  This also solved your race, 
> > but it caused other problems and so was changed.)
> > 
> > It's true that subsystems could do this for themselves, but then they'd
> > _all_ have to do it.  So we might as well put it in the PM core.
> > 
> > Rafael, what do you think?
> 
> Yes, we can do that.
> 
> I even suspect that all subsystems will end up calling pm_runtime_disable()
> somewhere in the system suspend code path and pm_runtime_enable() during
> system resume.  It might be a good idea to do that in the core too, after
> calling the subsystem's .suspend() and before calling its .resume(),
> respectively.

Will that bring back Kevin's problems?  There was a specific commit:  
"PM: Allow pm_runtime_suspend() to succeed during system suspend".  If
the core disables runtime PM, won't he be right back where he was
before?

Alan Stern
