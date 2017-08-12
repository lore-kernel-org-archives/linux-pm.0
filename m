From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] ACPI / Sleep: Check low power idle constraints for debug only
Date: Sat, 12 Aug 2017 16:27:16 +0200
Message-ID: <18796717.B6iU8dePCh@aspire.rjw.lan>
References: <1502475835-54818-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1502475835-54818-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, mario.limonciello@dell.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, August 11, 2017 8:23:55 PM CEST Srinivas Pandruvada wrote:
> For SoC to achieve its lowest power platform idle state a set of hardware
> preconditions must be met. These preconditions or constraints can be
> obtained by issuing a device specific method (_DSM) with function "1".
> Refer to the document provided in the link below.
> 
> Here during initialization (from attach() callback of LPS0 device), invoke
> function 1 to get the device constraints. Each enabled constraint is
> stored in a table.
> 
> The devices in this table are used to check whether they were in required
> minimum state, while entering suspend. This check is done from platform
> freeze wake() callback, only when /sys/power/pm_debug_messages attribute
> is non zero.
> 
> If any constraint is not met and device is ACPI power managed then it
> prints the device name to kernel logs.
> 
> Also if debug is enabled in acpi/sleep.c, the constraint table and state
> of each device on wake is dumped in kernel logs.
> 
> Since pm_debug_messages_on setting is used as condition to check
> constraints outside kernel/power/main.c, pm_debug_messages_on is changed
> to a global variable.
> 
> Link: http://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> 
> v3
> - Removed the patch 0001 for exporting pm_debug_messages_on via a function.
> As suggested by Rafael, made the pm_debug_messages_on a global variable instead.
> - Moved the constraint check outside if() block and valid for all calls to
> acpi_freeze_wakeup()
> - Dumping irrespective of return value of acpi_device_get_power().
> - Rebased to linux-next as of today
>  
> v2
> - Changes as suggested by Lukas Wunner.
> - Using pm_debug_messages_on attribute to prevent constraints check to
> save some cycles on wake.
> 
>  drivers/acpi/sleep.c    | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/suspend.h |   2 +
>  kernel/power/main.c     |   2 +-
>  3 files changed, 172 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 0a16435..df513e7 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -669,6 +669,7 @@ static const struct acpi_device_id lps0_device_ids[] = {
>  
>  #define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
>  
> +#define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
>  #define ACPI_LPS0_SCREEN_OFF	3
>  #define ACPI_LPS0_SCREEN_ON	4
>  #define ACPI_LPS0_ENTRY		5
> @@ -680,6 +681,167 @@ static acpi_handle lps0_device_handle;
>  static guid_t lps0_dsm_guid;
>  static char lps0_dsm_func_mask;
>  
> +/* Device constraint entry structure */
> +struct lpi_device_info {
> +	char *name;
> +	int enabled;
> +	union acpi_object *package;
> +};
> +
> +/* Constraint package structure */
> +struct lpi_device_constraint {
> +	int uid;
> +	int min_dstate;
> +	int function_states;
> +};
> +
> +struct lpi_constraints {
> +	char *name;
> +	int min_dstate;

If you store the handle here as well, you won't need to
look it up every time _check_constraints() is called.

> +};
> +
> +static struct lpi_constraints *lpi_constraints_table;
> +static int lpi_constraints_table_size;
> +
> +static void lpi_device_get_constraints(void)
> +{
> +	union acpi_object *out_obj;
> +	int i;
> +
> +	out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
> +					  1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
> +					  NULL, ACPI_TYPE_PACKAGE);
> +
> +	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
> +			  out_obj ? "successful" : "failed");
> +
> +	if (!out_obj)
> +		return;
> +
> +	lpi_constraints_table = kcalloc(out_obj->package.count,
> +					sizeof(*lpi_constraints_table),
> +					GFP_KERNEL);
> +	if (!lpi_constraints_table)
> +		goto free_acpi_buffer;
> +
> +	pr_debug("LPI: constraints dump begin\n");

Please add an empty line after this.  Also something like "constraints
list begin" would sound better IMO.

> +	for (i = 0; i < out_obj->package.count; i++) {
> +		union acpi_object *package = &out_obj->package.elements[i];
> +		struct lpi_device_info info = { };
> +		int package_count = 0, j;
> +
> +		if (!package)
> +			continue;
> +
> +		for (j = 0; j < package->package.count; ++j) {
> +			union acpi_object *element =
> +					&(package->package.elements[j]);
> +
> +			switch (element->type) {
> +			case ACPI_TYPE_INTEGER:
> +				info.enabled = element->integer.value;
> +				break;
> +			case ACPI_TYPE_STRING:
> +				info.name = element->string.pointer;
> +				break;
> +			case ACPI_TYPE_PACKAGE:
> +				package_count = element->package.count;
> +				info.package = element->package.elements;
> +				break;
> +			}
> +		}
> +
> +		if (!info.enabled || !info.package || !info.name)
> +			continue;
> +

I would evaluate acpi_get_handle() here and store the handle in the
constraints table (if persent).  And you can skip the entry altogether
if not present, because you won't be printing it anyway.

> +		lpi_constraints_table[lpi_constraints_table_size].name =
> +						kstrdup(info.name, GFP_KERNEL);
> +		if (!lpi_constraints_table[lpi_constraints_table_size].name)
> +			goto free_constraints;
> +
> +		pr_debug("index:%d Name:%s\n", i, info.name);
> +
> +		for (j = 0; j < package_count; ++j) {
> +			union acpi_object *info_obj = &info.package[j];
> +			union acpi_object *cnstr_pkg;
> +			union acpi_object *obj;
> +			struct lpi_device_constraint dev_info;
> +
> +			switch (info_obj->type) {
> +			case ACPI_TYPE_INTEGER:
> +				/* version */
> +				break;
> +			case ACPI_TYPE_PACKAGE:
> +				if (info_obj->package.count < 2)
> +					break;
> +
> +				cnstr_pkg = info_obj->package.elements;
> +				obj = &cnstr_pkg[0];
> +				dev_info.uid = obj->integer.value;
> +				obj = &cnstr_pkg[1];
> +				dev_info.min_dstate = obj->integer.value;
> +				pr_debug("uid %d min_dstate %d\n",
> +					 dev_info.uid,
> +					 dev_info.min_dstate);
> +				lpi_constraints_table[
> +					lpi_constraints_table_size].min_dstate =
> +						dev_info.min_dstate;
> +				break;
> +			}
> +		}
> +
> +		lpi_constraints_table_size++;
> +	}
> +
> +	pr_debug("LPI: constraints dump end\n");
> +free_acpi_buffer:
> +	ACPI_FREE(out_obj);
> +	return;
> +
> +free_constraints:
> +	ACPI_FREE(out_obj);
> +	for (i = 0; i < lpi_constraints_table_size; ++i)
> +		kfree(lpi_constraints_table[i].name);
> +	kfree(lpi_constraints_table);
> +	lpi_constraints_table_size = 0;
> +}
> +
> +static void lpi_check_constraints(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < lpi_constraints_table_size; ++i) {
> +		acpi_handle handle;
> +		struct acpi_device *adev;
> +		int state, ret;
> +
> +		if (ACPI_FAILURE(acpi_get_handle(NULL,
> +						 lpi_constraints_table[i].name,
> +						 &handle)))
> +			continue;

So if you store the handle, the above won't be necessary.

> +
> +		if (acpi_bus_get_device(handle, &adev))
> +			continue;
> +
> +		ret = acpi_device_get_power(adev, &state);
> +		if (ret)
> +			pr_debug("LPI: %s required min power state %d, current power state %d, real power state [ERROR]\n",
> +				 lpi_constraints_table[i].name,
> +				 lpi_constraints_table[i].min_dstate,
> +				 adev->power.state);
> +		else
> +			pr_debug("LPI: %s required min power state %d, current power state %d, real power state %d\n",
> +				 lpi_constraints_table[i].name,
> +				 lpi_constraints_table[i].min_dstate,
> +				 adev->power.state, state);

I'm not convinced about the value of the above TBH.

Also in theory _PSC may go and access things like PCI config spaces of devices
which isn't a good idea for devices in D3_cold, so maybe skip this?

> +
> +		if (adev->flags.power_manageable && adev->power.state <
> +					lpi_constraints_table[i].min_dstate)
> +			pr_info("LPI: Constraint [%s] not matched\n",

"Constrant [%s] not met"?

Also I'd use acpi_handle_info(adev->handle, ...) to print this.

> +				 lpi_constraints_table[i].name);

I would print a message if !flags.power_manageable, because it means we
can't get the constraint right in general.

Also I would print both power.state and min_state (possibly using
acpi_power_state_string()) in this message as that is valuable for
debugging.

Thanks,
Rafael

