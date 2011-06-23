From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][PATCH 7/8] PM / Domains: System-wide
	transitions support for generic domains (v3)
Date: Thu, 23 Jun 2011 19:41:09 +0200
Message-ID: <201106231941.09429.rjw__11221.5634821498$1308852041$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1106231106250.2033-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106231106250.2033-100000@iolanthe.rowland.org>
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
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, June 23, 2011, Alan Stern wrote:
> On Thu, 23 Jun 2011, Rafael J. Wysocki wrote:
> 
> > > It might be worthwhile to include a little warning about the difference 
> > > between suspend and hibernate.
> > 
> > Well, there already is one:
> > 
> > "* The driver's idea of the device state may not agree with the device's
> >     physical state.  This can happen during resume from hibernation."
> > 
> > (in Documentation/power/runtime_pm.txt).  Also, the new text in the patch
> > https://lkml.org/lkml/2011/6/23/200 I've just sent says literally:
> > 
> > "If that is the case and none of the situations listed above takes place, it
> >  may be more efficient to leave the devices that had been suspended before
> >  the system sleep began in the suspended state."
> > 
> > where the "situations listed above" include it.
> > 
> > Do you think that's not sufficient?
> 
> The preceding text in your new patch says:
> 
> +On some systems, however, system sleep is not entered through a global firmware
> +or hardware operation.  Instead, all hardware components are put into low-power
> +states directly by the kernel in a coordinated way.  Then, the system sleep
> +state effectively follows from the states the hardware components end up in
> +and the system is woken up from that state by a hardware interrupt or a similar
> +mechanism entirely under the kernel's control.  As a result, the kernel never
> +gives control away and the states of all devices during resume are precisely
> +known to it.
> 
> It should say "system suspend" rather than "system sleep".

It says "system sleep" to distinguish between the state of the system
("system sleep") and the operation leading to that state ("system suspend").
That terminology is used all over the document, so I don't think it's a good
idea to change it just for this specific paragraph.

I agree that "suspend" should be used where it talks about starting, stopping
etc.

> Then to drive the point home, the following sentence chould say 
> something like this:
> 
> If that is the case and none of the situations listed above takes place
> (in particular, if the system is waking up from suspend and not from
> hibernation), it may be more efficient to leave the devices that had
> been suspended before the system suspend began in the suspended state.

That's fine by me, except that I'd simply say "(in particular, if the system
is not waking up from hibernation)".

Thanks,
Rafael
