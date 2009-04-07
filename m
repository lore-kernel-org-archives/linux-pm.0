From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC Disable suspend on a specific device] This is a
	little change in linux power scheme
Date: Tue, 7 Apr 2009 22:57:23 +0200
Message-ID: <200904072257.23756.rjw@sisk.pl>
References: <20090407102914.GA25796@gandalf.sssup.it>
	<200904072055.08322.rjw@sisk.pl>
	<49DBA319.3030008@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49DBA319.3030008@gandalf.sssup.it>
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
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 07 April 2009, Michael Trimarchi wrote:
> Rafael J. Wysocki wrote:
> > On Tuesday 07 April 2009, Michael Trimarchi wrote:
> >   
> >> Hi,
> >>
> >> Rafael J. Wysocki wrote:
> >>     
> >>> On Tuesday 07 April 2009, Michael Trimarchi wrote:
> >>>   
> >>>       
> >>>> This is a little rework of linux power scheme. TODO:
> >>>> - remove recursive call
> >>>> - clean-up code
> >>>>
> >>>> Avoid suspend of a device that is connected with other coprocessor
> >>>> like GSM chip.
> >>>>     
> >>>>         
> >>> Well, can you please tell us a bit about the motivation for this work?
> >>>
> >>> I don't like the approach, but I'd like to know what you're trying to achieve.
> >>>   
> >>>       
> >> I works on an hardware that have the gsm connect to wm8753 and the 
> >> bluetooth subsystem
> >> too direct connected. So I would like that a phone call for example 
> >> remains on during
> >> system suspend. With this approch I can disable suspend of an entire 
> >> subtree of device,
> >> that can be used by other hardware component. This change avoid any 
> >> specific change to the
> >> driver.
> >>     
> >
> > Why do you want to avoid changing the driver, actually?
> >
> > Rafael
> >
> >   
> Because, the driver may be connected to other device and you must change 
> the entire
> set. This simple modification can help to share devices on an embedded 
> board and control
> suspend/resume enable from user space. I don't know if it can be usefull 
> on broken board/device too. Do you see any possible risk with this 
> change?

Yes, a (rather high) risk of abuse.

> When I write it I try to have a simple modification on linux-pm part.

So, basically, you'd like to introduce an interface allowing the user space to
tell the kernel which devices not to suspend, because there may be some
dependencies between devices that the kernel presumably doesn't know of.

Well, what about teaching these dependencies to the kernel, so that it
can take them into account by itself?

Rafael
