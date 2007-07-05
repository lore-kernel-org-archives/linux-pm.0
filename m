From: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Subject: RE: Power event notification patch
Date: Thu, 5 Jul 2007 18:14:28 +0530
Message-ID: <67670A5CEA5C374B8E7B16D7DC55F95301247436@bgsmsx413.gar.corp.intel.com>
References: <200707051434.47970.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <200707051434.47970.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Well, say I have two applications, say app1 and app2. App 1 initiates a
suspend-to-RAM. How will app2 come to know the system is going to sleep.
Only way is app1 needs to inform/broadcast that the application has
initiates the sleep or the system is going to sleep. In that case, every
application which initiates a sleep has to implement this. Quoting your
example, the user who has proper credentials (using whatever application
he uses to initiate a sleep) should tell each application when going to
sleep. Even when we use pm-utilities, please understand that the
kernel/power/main.c's enter_state executes the first call/instruction to
prepare the system for the low power state.

So, it is apt to keep it in kernel space.

Thanks,
Sankar.

-----Original Message-----
From: Oliver Neukum [mailto:oliver@neukum.org] 
Sent: Thursday, July 05, 2007 6:05 PM
To: V, Sankara Narayanan
Cc: linux-pm@lists.linux-foundation.org
Subject: Re: [linux-pm] Power event notification patch

Am Donnerstag, 5. Juli 2007 schrieb V, Sankara Narayanan:
> 1. Isn't it the kernel which is finally initiating a low power sleep
> state? So, I added it in kernel/power/main.c where the kernel does all
> the suspend related activities.

Not really. The kernel takes the system to sleep if somebody with
the proper credentials tells it to do so. The kernel doesn't take the
initiative.

So the most obvious place to do the notification is with the entity
that initiates the sleep.

> 2. To answer your second question, we really can't guarantee. But even
> if you take Windows Vista (sorry linux enthusiasts for referring
windows
> here) or any other non-UNIX operating systems (which has this power
> event notification), they really do not guarantee it. But, it is an
> era-of-tera and the user space applications can do some minimal work
> like saving the app's last state in a .tmp file or so (like firefox if
> closed in an unclean way) to restore their state.

Well, we want to better than that other OS.

If you do this in user space, eg. the pm utilities, you can easily
implement
policies like waiting x seconds for the rest of the system to respond.

	Regards
		Oliver
