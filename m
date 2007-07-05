From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: Power event notification patch
Date: Thu, 05 Jul 2007 15:54:49 +0300
Message-ID: <1183640089.3619.5.camel@localhost.localdomain>
References: <67670A5CEA5C374B8E7B16D7DC55F95301247436@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <67670A5CEA5C374B8E7B16D7DC55F95301247436@bgsmsx413.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "ext V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,
On Thu, 2007-07-05 at 18:14 +0530, ext V, Sankara Narayanan wrote:
> Well, say I have two applications, say app1 and app2. App 1 initiates a
> suspend-to-RAM. How will app2 come to know the system is going to sleep.

Apparently you are not concernedd about giving a NACK, just let other
apps know that the transition is going to happen.

And you have admitted that it's not possible to have a deterministic
response (apps have "some" time to do "something").

If your system relies on such weak mechanism, it's well broken.

An application that wants to keep its state saved somewhere safe
(meaning that it can survive a powercycle) should store it asap, not
when something risky might happen.

> Only way is app1 needs to inform/broadcast that the application has
> initiates the sleep or the system is going to sleep. In that case, every
> application which initiates a sleep has to implement this. Quoting your
> example, the user who has proper credentials (using whatever application
> he uses to initiate a sleep) should tell each application when going to
> sleep. Even when we use pm-utilities, please understand that the
> kernel/power/main.c's enter_state executes the first call/instruction to
> prepare the system for the low power state.
> 
> So, it is apt to keep it in kernel space.

Not really, it belongs to userspace, and only to those apps that need
it.

Implement a library to make it in a standardized, but keep it away from
kernelspace. Actually I think you can get already something similar from
Hildon.

Have you checked that?

cheers,
igor

> Thanks,
> Sankar.
> 
> -----Original Message-----
> From: Oliver Neukum [mailto:oliver@neukum.org] 
> Sent: Thursday, July 05, 2007 6:05 PM
> To: V, Sankara Narayanan
> Cc: linux-pm@lists.linux-foundation.org
> Subject: Re: [linux-pm] Power event notification patch
> 
> Am Donnerstag, 5. Juli 2007 schrieb V, Sankara Narayanan:
> > 1. Isn't it the kernel which is finally initiating a low power sleep
> > state? So, I added it in kernel/power/main.c where the kernel does all
> > the suspend related activities.
> 
> Not really. The kernel takes the system to sleep if somebody with
> the proper credentials tells it to do so. The kernel doesn't take the
> initiative.
> 
> So the most obvious place to do the notification is with the entity
> that initiates the sleep.
> 
> > 2. To answer your second question, we really can't guarantee. But even
> > if you take Windows Vista (sorry linux enthusiasts for referring
> windows
> > here) or any other non-UNIX operating systems (which has this power
> > event notification), they really do not guarantee it. But, it is an
> > era-of-tera and the user space applications can do some minimal work
> > like saving the app's last state in a .tmp file or so (like firefox if
> > closed in an unclean way) to restore their state.
> 
> Well, we want to better than that other OS.
> 
> If you do this in user space, eg. the pm utilities, you can easily
> implement
> policies like waiting x seconds for the rest of the system to respond.
> 
> 	Regards
> 		Oliver
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
