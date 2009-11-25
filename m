From: Alan Stern <stern@rowland.harvard.edu>
Subject: Failure of device_add() and parent's child_count
Date: Wed, 25 Nov 2009 17:04:41 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911251646140.2812-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Rafael:

The Runtime PM interface is a little awkward concerning failure of 
device_add().  Let's consider the normal case where a newly-discovered 
device is being registered, and it is initially powered on.  Assuming 
that we want the PM core to know the device's true state while it is 
being probed, the registration code will have to look like this:

	...
	dev->parent = ...
	...
	pm_runtime_set_active(dev);
	pm_runtime_enable(dev);
	...
	rc = device_add(dev);

The assignment to dev->parent has to come first, so that 
pm_runtime_set_active() will increment the parent's child_count.  The 
child_count gets decremented again when device_del() calls 
device_pm_remove().

This means that following a failure of device_add(), the caller has to
be responsible for making sure the parent's child_count is correct.  So 
after calling device_add(), we need to do:

	if (rc < 0) {
		dev_warn(dev, ...);
		pm_runtime_disable(dev);
		pm_runtime_set_suspended(dev);
		put_device(dev);
	}

I doubt that people using the Runtime PM interface are aware of this.  
Did you do it in your new PCI runtime-PM code?

It would be good to remove this awkwardness, but I don't know what is
the best way to do it.  Perhaps __pm_runtime_set_status() shouldn't
adjust the parent's child_count unless the device is registered.  Then
device_pm_add() could adjust the child_count as needed.

Alan Stern
