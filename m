From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/PATCH] platform_bus: allow custom extensions to
	system PM methods
Date: Thu, 18 Mar 2010 09:57:06 -0700
Message-ID: <87bpellg9p.fsf__8185.14244533635$1268931505$gmane$org@deeprootsystems.com>
References: <1268867896-7616-1-git-send-email-khilman@deeprootsystems.com>
	<20100317234414.GA23319@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100317234414.GA23319@suse.de> (Greg KH's message of "Wed\,
	17 Mar 2010 16\:44\:14 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: Eric Miao <eric.y.miao@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Magnus Damm <damm@opensource.se>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Greg KH <gregkh@suse.de> writes:

> On Wed, Mar 17, 2010 at 04:18:15PM -0700, Kevin Hilman wrote:
>> When runtime PM for platform_bus was added, it allowed for platforms
>> to customize the runtime PM methods since they are defined as weak
>> symbols.
>> 
>> This patch allows platforms to also extend the system PM methods with
>> custom hooks so runtime PM and system PM extensions can be managed
>> together by custom platform-specific code.
>
> Wow, that's scary, I didn't realize that was done for the runtime stuff.
>
> What would you be replacing these functions with for your platform that
> would require it to be in arch-specific code?

I'm basically copying the existing functions and extending them with
platform-specific code to manage device clocks and other PM HW state.
IOW, I still call the drivers PM methods, but also take care of some
platform specific PM HW management.  This is just like the runtime PM
hooks: platform-specific code + calling drivers runtime PM methods.

On my platform (TI OMAP), the code to handle device PM is common for
all devices, so for runtime PM, I'm taking care of it at the bus
level.  At the hardware level, there's really no difference between
runtime and system PM, so I want to take advantage of the same
platform specific code for system PM

Initially, rather than making the system PM methods themselves weak, I
added some weak hooks that could be overridden instead (see test patch
below).  The problem with that is that it is not as flexible if you
want to run some custom code before and/or after calling the drivers
PM methods.  To be more flexible, using this approach, we'd probably
need pre- and post- hooks to be used before and after the driver's PM
methods are called.  Rather than add all these hooks, I decided it was
cleaner to just allow override of the primary methods themselves,
which parallels the runtime PM approach.

Kevin


diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1ba9d61..a30f850 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -729,6 +729,26 @@ static void platform_pm_complete(struct device *dev)
 
 #ifdef CONFIG_SUSPEND
 
+int __weak platform_pm_suspend_hook(struct device *dev)
+{
+	return 0;
+}
+
+int __weak platform_pm_suspend_noirq_hook(struct device *dev)
+{
+	return 0;
+}
+
+int __weak platform_pm_resume_hook(struct device *dev)
+{
+	return 0;
+}
+
+int __weak platform_pm_resume_noirq_hook(struct device *dev)
+{
+	return 0;
+}
+
 static int platform_pm_suspend(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
@@ -744,6 +764,8 @@ static int platform_pm_suspend(struct device *dev)
 		ret = platform_legacy_suspend(dev, PMSG_SUSPEND);
 	}
 
+	platform_pm_suspend_hook(dev);
+
 	return ret;
 }
 
@@ -760,6 +782,8 @@ static int platform_pm_suspend_noirq(struct device *dev)
 			ret = drv->pm->suspend_noirq(dev);
 	}
 
+	platform_pm_suspend_noirq_hook(dev);
+
 	return ret;
 }
 
@@ -768,6 +792,8 @@ static int platform_pm_resume(struct device *dev)
 	struct device_driver *drv = dev->driver;
 	int ret = 0;
 
+	platform_pm_resume_hook(dev);
+
 	if (!drv)
 		return 0;
 
@@ -786,6 +812,8 @@ static int platform_pm_resume_noirq(struct device *dev)
 	struct device_driver *drv = dev->driver;
 	int ret = 0;
 
+	platform_pm_resume_noirq_hook(dev);
+
 	if (!drv)
 		return 0;
 
