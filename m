From: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Subject: RE: Power event notification patch
Date: Thu, 5 Jul 2007 17:47:45 +0530
Message-ID: <67670A5CEA5C374B8E7B16D7DC55F95301247414@bgsmsx413.gar.corp.intel.com>
References: <200707051408.02756.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <200707051408.02756.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

1. Isn't it the kernel which is finally initiating a low power sleep
state? So, I added it in kernel/power/main.c where the kernel does all
the suspend related activities.

2. To answer your second question, we really can't guarantee. But even
if you take Windows Vista (sorry linux enthusiasts for referring windows
here) or any other non-UNIX operating systems (which has this power
event notification), they really do not guarantee it. But, it is an
era-of-tera and the user space applications can do some minimal work
like saving the app's last state in a .tmp file or so (like firefox if
closed in an unclean way) to restore their state.

I have tested it over some applications of my own and they seem to
execute a significant piece of code-like writing to a file when they go
to low power state.

Really appreciate your comment. Thanks.
 
Thanks,
Sankara Narayanan V.

-----Original Message-----
From: Oliver Neukum [mailto:oliver@neukum.org] 
Sent: Thursday, July 05, 2007 5:38 PM
To: linux-pm@lists.linux-foundation.org
Cc: V, Sankara Narayanan
Subject: Re: [linux-pm] Power event notification patch

Am Donnerstag, 5. Juli 2007 schrieb V, Sankara Narayanan:
> Here is a simple patch for power event notification to user-space
> applications. Basically, what it does is notify the user-space
> applications that the system is going to a low power state
> (Suspend-to-RAM and Suspend-to-Disk) and resume from that state. This
is
> useful for the user-space applications to do some significant action
> when the system goes to the low power state (like saving an unsaved
> file). The user-space objects can form a netlink socket and listen to
> these events. It is done through a kobject-netlink socket. For this I
> have used the kobject_uevent system call, posting the notification to
> user space with standby, hibernate and resume in the action parameter
of
> the kobject_uevent call (mapped to KOBJ_S3, KOBJ_S4 and KOBJ_RESUME
> enums). Appreciate your comments on the patch.

Why does this need to be done in kernel space?
How do you want to make sure user space has enough time to act on a
notification?

	Regards
		Oliver
