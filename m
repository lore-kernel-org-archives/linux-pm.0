From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Power event notification patch
Date: Thu, 5 Jul 2007 14:08:02 +0200
Message-ID: <200707051408.02756.oliver@neukum.org>
References: <67670A5CEA5C374B8E7B16D7DC55F953012473FF@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <67670A5CEA5C374B8E7B16D7DC55F953012473FF@bgsmsx413.gar.corp.intel.com>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 5. Juli 2007 schrieb V, Sankara Narayanan:
> Here is a simple patch for power event notification to user-space
> applications. Basically, what it does is notify the user-space
> applications that the system is going to a low power state
> (Suspend-to-RAM and Suspend-to-Disk) and resume from that state. This is
> useful for the user-space applications to do some significant action
> when the system goes to the low power state (like saving an unsaved
> file). The user-space objects can form a netlink socket and listen to
> these events. It is done through a kobject-netlink socket. For this I
> have used the kobject_uevent system call, posting the notification to
> user space with standby, hibernate and resume in the action parameter of
> the kobject_uevent call (mapped to KOBJ_S3, KOBJ_S4 and KOBJ_RESUME
> enums). Appreciate your comments on the patch.

Why does this need to be done in kernel space?
How do you want to make sure user space has enough time to act on a
notification?

	Regards
		Oliver
