From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Fri, 13 Jul 2007 11:50:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707131146340.2555-100000__29634.6687515781$1184341980$gmane$org@iolanthe.rowland.org>
References: <200707131745.43055.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707131745.43055.rjw@sisk.pl>
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
Cc: david@lang.hm, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 13 Jul 2007, Rafael J. Wysocki wrote:

> Okay, I have thought it through and I think that, as an initial step, we can do
> something like this:
> 
> - preload the image-saving kernel before hibernation
> - in the hibernation code path replace device_suspend() with the shutting down of
>   all devices without unregistering them (not very nice, but should be sufficient
>   for a while)
> - when we've called device_power_down() and save_processor_state(), jump to
>   the image-saving kernel and let it run
> - make the image-saving kernel set up everything, save the image without
>   starting any user space (we may use the existing image-saving code for this
>   purpose, with some modifications) and power off the system (or make it enter
>   S4)
> - use the existing restoration code to load the image and jump to the
>   hibernated kernel
> - in the restore code patch replace device_resume() with the reprobing of all
>   devices.
> 
> Comments?

I doubt that re-probing devices will work.  The probe routine won't 
expect there to be any registered children, so it will try to 
re-register them.

On the other hand, post_restore methods could be written to expect 
something like this.

Alan Stern
