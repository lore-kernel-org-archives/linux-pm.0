From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 7] PM: Add a switch for disabling/enabling
	asynchronous	suspend/resume
Date: Thu, 27 Aug 2009 13:07:35 -0700
Message-ID: <20090827203948.9CD25526EC9__35850.905677262$1251403826$gmane$org@mailhub.coreip.homeip.net>
References: <200908262217.19609.rjw@sisk.pl> <200908270025.34821.rjw@sisk.pl>
	<200908272117.52931.rjw@sisk.pl> <200908272119.47053.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908272119.47053.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 27, 2009 at 09:19:46PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Add sysfs attribute kernel/power/pm_async allowing the user space to
> disable and enable async suspend/resume of devices.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/base/power/main.c  |   13 +++++++------
>  drivers/base/power/power.h |    6 +++---
>  kernel/power/main.c        |   28 +++++++++++++++++++++++++++-
>  3 files changed, 37 insertions(+), 10 deletions(-)
> 
> Index: linux-2.6/kernel/power/main.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/main.c
> +++ linux-2.6/kernel/power/main.c
> @@ -44,6 +44,29 @@ int pm_notifier_call_chain(unsigned long
>  			== NOTIFY_BAD) ? -EINVAL : 0;
>  }
>  
> +/* If set, devices may be suspended and resumed asynchronously. */
> +int pm_async_enabled = 1;
> +
> +static ssize_t pm_async_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			     char *buf)
> +{
> +	return sprintf(buf, "%d\n", pm_async_enabled);
> +}
> +
> +static ssize_t pm_async_store(struct kobject *kobj, struct kobj_attribute *attr,
> +			      const char *buf, size_t n)
> +{
> +	int val;
> +
> +	if (sscanf(buf, "%d", &val) == 1) {

I prefer more vigorous restrictions on the sysfs interfaces. Maybe:

	if (strict_strtoul(buf, 10, &val) || val > 1)
		return -EINVAL;

	pm_async_enabled = val;

?

-- 
Dmitry
