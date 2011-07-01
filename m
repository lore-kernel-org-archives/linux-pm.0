From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: runtime PM usage_count during driver_probe_device()?
Date: Fri, 1 Jul 2011 10:54:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107011045160.1988-100000__48236.8376026445$1309532093$gmane$org@iolanthe.rowland.org>
References: <87vcvmaml6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87vcvmaml6.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 30 Jun 2011, Kevin Hilman wrote:

> I'm still confused about the usage_count increment around ->probe
> though.

As a few people have already pointed out, some subsystems do perform 
runtime PM on driverless devices.

The basic idea is simple: We don't want any PM callbacks to race with
each other or with other driver-core callbacks.  Incrementing the
usage_count prevents runtime_suspend callbacks while the probe callback
is running.

This does leave open the possibility of runtime_resume occurring 
concurrently with probe.  For the most part this should be okay 
because without a driver, no part of the kernel will try to resume the 
device.

Hmmm, but a resume could occur as a result of userspace writing to a 
sysfs attribute.  It looks like we need to add some lock_device() calls 
to control_store() and autosuspend_delay_ms_store().

Alan Stern
