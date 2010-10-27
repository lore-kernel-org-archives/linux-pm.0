From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] apds9802als: add runtime PM support
Date: Wed, 27 Oct 2010 10:13:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010271010170.1650-100000__39933.407927356$1288188900$gmane$org@iolanthe.rowland.org>
References: <1288139961.19329.401.camel@hongdev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1288139961.19329.401.camel@hongdev>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hong Liu <hong.liu@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 27 Oct 2010, Hong Liu wrote:

> In apds9802als_resume, I just want to power up the device, do some
> configuration, and then runtime_suspend the device.

Then you should change the function the way I suggested.  The PM core
will automatically do a runtime suspend after the system has fully
woken up.

> We don't have runtime_idle() implemented, the driver exported sysfs
> entries to user space for data reading, and we do runtime_resume,
> measaure data, runtime_suspend in the read/write funciton of those sysfs
> entries. This is why I want to put the device into runtime suspend
> manually whenever possible.

Your approach will not work.  You _must_ define runtime_idle() if you 
want your driver to suspend correctly.  It doesn't have to be 
complicated; just make it call pm_runtime_suspend().

...

> We don't have runtime_idle() implemented, so I have to manually put the
> device into runtime suspend.

The problem is that the device can be runtime-resumed by code other 
than your own, and that other code will not always do a runtime-suspend 
afterward -- it will do a runtime-idle.  That's why you need to define 
a runtime_idle() callback.

Alan Stern
