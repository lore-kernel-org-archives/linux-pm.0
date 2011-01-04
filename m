From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: Question about timers during system suspend
Date: Wed, 5 Jan 2011 05:27:34 +0530
Message-ID: <BLU102-W11E15CD0A639C1DE2097CAEB080@phx.gbl>
References: <BLU102-W26157F65094C5BCB0C51ADEB080@phx.gbl>,
	<201101050005.42914.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101050005.42914.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


 
Dear rafael,
 
Thanks for quick reply.
 
>> I have question regarding the timers during system suspend. If a software timer is
> > active in device driver, will this timer be stopped during system suspend?
>
> What do you mean by "stopped"? Do you mean canceled?
 
I mean cancel the software timer. But if the software timer is active as you already mentioned it will not prevent
system suspend. I mean to say if the driver has active software timer means software timer is not fired yet and device driver
will return from suspend callback without cancelation software timer and it times out after this
will not prevent system suspend to return error code.
 
right??
 
or is it mandatory to cancel the software timer during suspend callback to device driver?
 
 
Regards
raj
 



----------------------------------------
> From: rjw@sisk.pl
> To: rajkumar278@hotmail.com
> Subject: Re: [linux-pm] Question about timers during system suspend
> Date: Wed, 5 Jan 2011 00:05:42 +0100
> CC: linux-pm@lists.linux-foundation.org
>
> On Tuesday, January 04, 2011, Raj Kumar wrote:
> >
> > Hi,
>
> Hi,
>
> > I have question regarding the timers during system suspend. If a software timer is
> > active in device driver, will this timer be stopped during system suspend?
>
> What do you mean by "stopped"? Do you mean canceled?
>
> > If the timer is active, will it prevent the system from full suspend?
>
> No, it won't.
>
> > The another thing is during system suspend, how the user space code know about suspend?
>
> It doesn't, unless it's notified by the user space process initiating suspend.
>
> > One way is that device driver gets the suspend and it notifies the user space.
>
> That doesn't work, because user space is frozen when drivers' suspend routines
> are being called. It might work if the driver in question registered a power
> management notifier and sent a notification to user space from there.
>
> > But is there way that during system goes into full suspend, is any user space component that will
> > give notifications to applications that has registered for system suspend transition?
>
> That depends on the configuration of user space. pm-utils can do that for one
> example.
>
> Thanks,
> Rafael 		 	   		  
