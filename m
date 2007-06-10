From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Remove saved_state from
	dev_pm_info
Date: Sun, 10 Jun 2007 19:10:44 +0200
Message-ID: <200706101910.44409.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0706101018430.29131-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706101018430.29131-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sunday, 10 June 2007 16:32, Alan Stern wrote:
> On Sat, 9 Jun 2007, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The saved_state member of struct dev_pm_info, defined in include/linux/pm.h, is
> > not used anywhere, so it can be removed.
> 
> Along the same lines, feature_removal_schedule.txt says that 
> dev->power.power_state will be removed next month.  In preparation, 
> you could consider removing the prev_state member now.  As far as I 
> know, it isn't used for anything other than avoiding resume method 
> calls to devices that were already suspended when a system sleep 
> began.

Yes, I considered that too, but I decided to leave if for now in case something
depended on it.

I'll take another look. ;-)

> I suggest that suspend and resume always be called for every device
> during a system sleep transition, regardless of the device's state.

That's reasonable, I think.

> That will have to done anyway once dev->power.power_state is gone.

Besides, that would fix the issue with the current code that if
dev->class->suspend() changes dev->power.power_state.event  to 'off',
then dev->bus->suspend() is not called, but dev->bus->resume() will be called
during the subsequent resume.

> The idea is that drivers should regard these method calls as
> notifications that the system is about to go to sleep or has just woken
> up, rather than as directives to put their device into a particular
> state.
> 
> Thus, if a driver knows that its device was already in a low-power
> state before the system sleep then it need not respond to a resume
> method call by switching the device to a high-power state.  Instead the
> driver should be free to take whatever action it thinks is appropriate.
> This is already explained in Documentation/power/devices.txt.

OK

I'll prepare a patch to remove the dev->power.power_state.event checks from the
suspend core code.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
