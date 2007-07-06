From: Greg KH <greg@kroah.com>
Subject: Re: Power event notification patch
Date: Fri, 6 Jul 2007 11:41:53 -0700
Message-ID: <20070706184153.GA4486@kroah.com>
References: <67670A5CEA5C374B8E7B16D7DC55F953012473FF@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <67670A5CEA5C374B8E7B16D7DC55F953012473FF@bgsmsx413.gar.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 05, 2007 at 05:31:33PM +0530, V, Sankara Narayanan wrote:
> Hi Folks,
> 
>  
> 
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

As others have stated, this is not acceptable for a wide range of
reasons.

Not the least being that even if you did implement this, you would need
to be listening to the dbus notification of this message, and so, just
do it all in userspace anyway, no kernel involvement is needed.

Oh, and the names S3, S4, don't mean much for non-intel based
processors, so that's also not acceptable.

thanks,

greg k-h
