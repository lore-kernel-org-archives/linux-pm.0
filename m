From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH v2 2/2] ACPI / Sleep: Check low power idle constraints for
 debug only
Date: Thu, 10 Aug 2017 22:07:15 +0000
Message-ID: <146e121b5db84fb8a8aa692cee01cb7b@ausx13mpc120.AMER.DELL.COM>
References: <1502232075-23832-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1502232075-23832-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1502232075-23832-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukas@wunner.de
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Srinivas Pandruvada [mailto:srinivas.pandruvada@linux.intel.com]
> Sent: Tuesday, August 8, 2017 5:41 PM
> To: rjw@rjwysocki.net; lenb@kernel.org
> Cc: linux-pm@vger.kernel.org; Limonciello, Mario <Mario_Limonciello@Dell.=
com>;
> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; lukas@wunner.de=
;
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Subject: [PATCH v2 2/2] ACPI / Sleep: Check low power idle constraints fo=
r debug
> only
>=20
> For SoC to achieve its lowest power platform idle state a set of hardware
> preconditions must be met. These preconditions or constraints can be
> obtained by issuing a device specific method (_DSM) with function "1".
> Refer to the document provided in the link below.
>=20
> Here during initialization (from attach() callback of LPS0 device), invok=
e
> function 1 to get the device constraints. Each enabled constraint is
> stored in a table.
>=20
> The devices in this table are used to check whether they were in required
> minimum state, while entering suspend. This check is done from platform
> freeze wake() callback, only when /sys/power/pm_debug_messages attribute
> is non zero.
>=20
> If any constraint is not met and device is ACPI power managed then it
> prints the device name to kernel logs.
>=20
> Also if debug is enabled in acpi/sleep.c, the constraint table and state
> of each device on wake is dumped in kernel logs.
>=20
> Link:
> http://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0=
_Idle.
> pdf
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/sleep.c | 162
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 162 insertions(+)
>=20
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 2b881de..b3ef577 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -669,6 +669,7 @@ static const struct acpi_device_id lps0_device_ids[] =
=3D {
>=20
>  #define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
>=20
> +#define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
>  #define ACPI_LPS0_SCREEN_OFF	3
>  #define ACPI_LPS0_SCREEN_ON	4
>  #define ACPI_LPS0_ENTRY		5
> @@ -680,6 +681,162 @@ static acpi_handle lps0_device_handle;
>  static guid_t lps0_dsm_guid;
>  static char lps0_dsm_func_mask;
>=20
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
> +	out_obj =3D acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
> +					  1,
> ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
> +					  NULL, ACPI_TYPE_PACKAGE);
> +
> +	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
> +			  out_obj ? "successful" : "failed");
> +
> +	if (!out_obj)
> +		return;
> +
> +	lpi_constraints_table =3D kcalloc(out_obj->package.count,
> +					sizeof(*lpi_constraints_table),
> +					GFP_KERNEL);
> +	if (!lpi_constraints_table)
> +		goto free_acpi_buffer;
> +
> +	pr_debug("LPI: constraints dump begin\n");
> +	for (i =3D 0; i < out_obj->package.count; i++) {
> +		union acpi_object *package =3D &out_obj->package.elements[i];
> +		struct lpi_device_info info =3D { };
> +		int package_count =3D 0, j;
> +
> +		if (!package)
> +			continue;
> +
> +		for (j =3D 0; j < package->package.count; ++j) {
> +			union acpi_object *element =3D
> +					&(package->package.elements[j]);
> +
> +			switch (element->type) {
> +			case ACPI_TYPE_INTEGER:
> +				info.enabled =3D element->integer.value;
> +				break;
> +			case ACPI_TYPE_STRING:
> +				info.name =3D element->string.pointer;
> +				break;
> +			case ACPI_TYPE_PACKAGE:
> +				package_count =3D element->package.count;
> +				info.package =3D element->package.elements;
> +				break;
> +			}
> +		}
> +
> +		if (!info.enabled || !info.package || !info.name)
> +			continue;
> +
> +		lpi_constraints_table[lpi_constraints_table_size].name =3D
> +						kstrdup(info.name, GFP_KERNEL);
> +		if (!lpi_constraints_table[lpi_constraints_table_size].name)
> +			goto free_constraints;
> +
> +		pr_debug("index:%d Name:%s\n", i, info.name);
> +
> +		for (j =3D 0; j < package_count; ++j) {
> +			union acpi_object *info_obj =3D &info.package[j];
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
> +				cnstr_pkg =3D info_obj->package.elements;
> +				obj =3D &cnstr_pkg[0];
> +				dev_info.uid =3D obj->integer.value;
> +				obj =3D &cnstr_pkg[1];
> +				dev_info.min_dstate =3D obj->integer.value;
> +				pr_debug("uid %d min_dstate %d\n",
> +					 dev_info.uid,
> +					 dev_info.min_dstate);
> +				lpi_constraints_table[
> +					lpi_constraints_table_size].min_dstate =3D
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
> +	for (i =3D 0; i < lpi_constraints_table_size; ++i)
> +		kfree(lpi_constraints_table[i].name);
> +	kfree(lpi_constraints_table);
> +	lpi_constraints_table_size =3D 0;
> +}
> +
> +static void lpi_check_constraints(void)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < lpi_constraints_table_size; ++i) {
> +		acpi_handle handle;
> +		struct acpi_device *adev;
> +		int state, ret;
> +
> +		if (ACPI_FAILURE(acpi_get_handle(NULL,
> +						 lpi_constraints_table[i].name,
> +						 &handle)))
> +			continue;
> +
> +		if (acpi_bus_get_device(handle, &adev))
> +			continue;
> +
> +		ret =3D acpi_device_get_power(adev, &state);
> +		if (!ret)
> +			pr_debug("LPI: %s required min power state %d, current
> power state %d, real power state %d\n",
> +				 lpi_constraints_table[i].name,
> +				 lpi_constraints_table[i].min_dstate,
> +				 adev->power.state, state);
Isn't this superfluous to be showing the state returned from acpi_device_ge=
t_power and
also probing directly at the state? You can't just rely on the information =
you got
back from apci_device_get_power?

> +
> +		if (adev->flags.power_manageable && adev->power.state <
> +					lpi_constraints_table[i].min_dstate)
> +			pr_info("LPI: Constraint [%s] not matched\n",
> +				 lpi_constraints_table[i].name);
Similarly here, can't you just compare against &state instead?

> +	}
> +}
> +
>  static void acpi_sleep_run_lps0_dsm(unsigned int func)
>  {
>  	union acpi_object *out_obj;
> @@ -729,6 +886,9 @@ static int lps0_device_attach(struct acpi_device *ade=
v,
>  				  "_DSM function 0 evaluation failed\n");
>  	}
>  	ACPI_FREE(out_obj);
> +
> +	lpi_device_get_constraints();
> +
>  	return 0;
>  }
>=20
> @@ -773,6 +933,8 @@ static void acpi_freeze_wake(void)
>  	 */
>  	if (acpi_sci_irq_valid() &&
>  	    !irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq))) {
> +		if (pm_debug_messages_enabled())
> +			lpi_check_constraints();
>  		pm_system_cancel_wakeup();
>  		s2idle_wakeup =3D true;
>  	}
> --
> 2.7.5

