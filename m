From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Do not create wakeup sysfs files
 for devices that cannot wakeup
Date: Wed, 19 Jan 2011 17:05:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101191704080.3655-100000__25856.3027870425$1295474892$gmane$org@iolanthe.rowland.org>
References: <201101150108.45657.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101150108.45657.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 15 Jan 2011, Rafael J. Wysocki wrote:

> OK, I think that problem is not present any more in the new version of the
> patch, which is appended.
> 
> > Apart from that, it all seems reasonable.  But you should change the
> > description of the wakeup attribute in Documentation/power/devices.txt;  
> > it says that the attribute file is present but empty if the device is
> > not wakeup-capable.
> 
> Right and not only that.  The descriptions in ABI/sysfs-device-power have to be
> updated too.
> 
> Thanks,
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Do not create wakeup sysfs files for devices that cannot wake up
> 
> Currently, wakeup sysfs attributes are created for all devices,
> regardless of whether or not they are wakeup-capable.  This is
> excessive and complicates wakeup device identification from user
> space (i.e. to identify wakeup-capable devices user space has to read
> /sys/devices/.../power/wakeup for all devices and see if they are not
> empty).
> 
> Fix this issue by avoiding to create wakeup sysfs files for devices
> that cannot wake up the system from sleep states (i.e. whose
> power.can_wakeup flags are unset during registration) and modify
> device_set_wakeup_capable() so that it adds (or removes) the relevant
> sysfs attributes if a device's wakeup capability status is changed.

Yes, this all looks okay to me.

Alan Stern
