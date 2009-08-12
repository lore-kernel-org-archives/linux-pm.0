From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V2 0/4] introduce device async actions
	mechanism
Date: Wed, 12 Aug 2009 16:34:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908121633220.23954-100000__29562.7376799986$1250109345$gmane$org@iolanthe.rowland.org>
References: <200908122210.35591.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908122210.35591.rjw@sisk.pl>
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
Cc: "dtor@mail.ru" <dtor@mail.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:

> > The one thing I'm not sure of is the pm_runtime_put_noidle calls in 
> > driver_probe_device and __device_release_driver.  It seems that we 
> > should always call pm_runtime_put regardless of whether the probe 
> > succeeds or not.
> 
> Did you mean pm_runtime_put_sync()?

Yes.  I haven't used the new code yet so the names don't stick in my 
mind.

> > For example, the USB stack is set up to suspend devices that don't have
> > a driver (this is handled at the bus subsystem level).  But if probing
> > failed, there wouldn't be any idle callback and so the suspend wouldn't
> > take place.
> 
> OK, I'll make this change.

Thanks.  Now I just have to figure out the best way to convert USB over 
to the new framework...

Alan Stern
