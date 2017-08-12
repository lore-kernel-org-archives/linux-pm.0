From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v3] ACPI / Sleep: Check low power idle constraints for
 debug only
Date: Sat, 12 Aug 2017 08:59:16 -0700
Message-ID: <1502553556.20268.47.camel@linux.intel.com>
References: <1502475835-54818-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <18796717.B6iU8dePCh@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <18796717.B6iU8dePCh@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, mario.limonciello@dell.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2017-08-12 at 16:27 +0200, Rafael J. Wysocki wrote:
[...]

> > +
> > +struct lpi_constraints {
> > +	char *name;
> > +	int min_dstate;
> If you store the handle here as well, you won't need to
> look it up every time _check_constraints() is called.

The reason I didn't keep handle here, I thought handle can be stale or
change for PnP device on plug in and out. Is this not true?

> > 
> > +};
> > +
> > +static struct lpi_constraints *lpi_constraints_table;
> > +static int lpi_constraints_table_size;
> > +
> > +static void lpi_device_get_constraints(void)
> > +{
> > +	union acpi_object *out_obj;
> > +	int i;
> > +
> > +	out_obj = acpi_evaluate_dsm_typed(lps0_device_handle,
> > &lps0_dsm_guid,
> > +					  1,
> > ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
> > +					  NULL,
> > ACPI_TYPE_PACKAGE);
> > +
> > +	acpi_handle_debug(lps0_device_handle, "_DSM function 1
> > eval %s\n",
> > +			  out_obj ? "successful" : "failed");
> > +
> > +	if (!out_obj)
> > +		return;
> > +
> > +	lpi_constraints_table = kcalloc(out_obj->package.count,
> > +					sizeof(*lpi_constraints_ta
> > ble),
> > +					GFP_KERNEL);
> > +	if (!lpi_constraints_table)
> > +		goto free_acpi_buffer;
> > +
> > +	pr_debug("LPI: constraints dump begin\n");
> Please add an empty line after this.  Also something like
> "constraints
> list begin" would sound better IMO.
> 
OK.

> > 
> > +	for (i = 0; i < out_obj->package.count; i++) {
> > +		union acpi_object *package = &out_obj-
> > >package.elements[i];
> > +		struct lpi_device_info info = { };
> > +		int package_count = 0, j;
> > +
> > +		if (!package)
> > +			continue;
> > +
> > +		for (j = 0; j < package->package.count; ++j) {
> > +			union acpi_object *element =
> > +					&(package-
> > >package.elements[j]);
> > +
> > +			switch (element->type) {
> > +			case ACPI_TYPE_INTEGER:
> > +				info.enabled = element-
> > >integer.value;
> > +				break;
> > +			case ACPI_TYPE_STRING:
> > +				info.name = element-
> > >string.pointer;
> > +				break;
> > +			case ACPI_TYPE_PACKAGE:
> > +				package_count = element-
> > >package.count;
> > +				info.package = element-
> > >package.elements;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (!info.enabled || !info.package || !info.name)
> > +			continue;
> > +
> I would evaluate acpi_get_handle() here and store the handle in the
> constraints table (if persent).  And you can skip the entry
> altogether
> if not present, because you won't be printing it anyway.
> 
> > 
> > +		lpi_constraints_table[lpi_constraints_table_size].
> > name =
> > +						kstrdup(info.name,
> > GFP_KERNEL);
> > +		if
> > (!lpi_constraints_table[lpi_constraints_table_size].name)
> > +			goto free_constraints;
> > +
> > +		pr_debug("index:%d Name:%s\n", i, info.name);
> > +
> > +		for (j = 0; j < package_count; ++j) {
> > +			union acpi_object *info_obj =
> > &info.package[j];
> > +			union acpi_object *cnstr_pkg;
> > +			union acpi_object *obj;
> > +			struct lpi_device_constraint dev_info;
> > +
> > +			switch (info_obj->type) {
> > +			case ACPI_TYPE_INTEGER:
> > +				/* version */
> > +				break;
> > +			case ACPI_TYPE_PACKAGE:
> > +				if (info_obj->package.count < 2)
> > +					break;
> > +
> > +				cnstr_pkg = info_obj-
> > >package.elements;
> > +				obj = &cnstr_pkg[0];
> > +				dev_info.uid = obj->integer.value;
> > +				obj = &cnstr_pkg[1];
> > +				dev_info.min_dstate = obj-
> > >integer.value;
> > +				pr_debug("uid %d min_dstate %d\n",
> > +					 dev_info.uid,
> > +					 dev_info.min_dstate);
> > +				lpi_constraints_table[
> > +					lpi_constraints_table_size
> > ].min_dstate =
> > +						dev_info.min_dstat
> > e;
> > +				break;
> > +			}
> > +		}
> > +
> > +		lpi_constraints_table_size++;
> > +	}
> > +
> > +	pr_debug("LPI: constraints dump end\n");
> > +free_acpi_buffer:
> > +	ACPI_FREE(out_obj);
> > +	return;
> > +
> > +free_constraints:
> > +	ACPI_FREE(out_obj);
> > +	for (i = 0; i < lpi_constraints_table_size; ++i)
> > +		kfree(lpi_constraints_table[i].name);
> > +	kfree(lpi_constraints_table);
> > +	lpi_constraints_table_size = 0;
> > +}
> > +
> > +static void lpi_check_constraints(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < lpi_constraints_table_size; ++i) {
> > +		acpi_handle handle;
> > +		struct acpi_device *adev;
> > +		int state, ret;
> > +
> > +		if (ACPI_FAILURE(acpi_get_handle(NULL,
> > +						 lpi_constraints_t
> > able[i].name,
> > +						 &handle)))
> > +			continue;
> So if you store the handle, the above won't be necessary.
> 
> > 
> > +
> > +		if (acpi_bus_get_device(handle, &adev))
> > +			continue;
> > +
> > +		ret = acpi_device_get_power(adev, &state);
> > +		if (ret)
> > +			pr_debug("LPI: %s required min power state
> > %d, current power state %d, real power state [ERROR]\n",
> > +				 lpi_constraints_table[i].name,
> > +				 lpi_constraints_table[i].min_dsta
> > te,
> > +				 adev->power.state);
> > +		else
> > +			pr_debug("LPI: %s required min power state
> > %d, current power state %d, real power state %d\n",
> > +				 lpi_constraints_table[i].name,
> > +				 lpi_constraints_table[i].min_dsta
> > te,
> > +				 adev->power.state, state);
> I'm not convinced about the value of the above TBH.
> 
> Also in theory _PSC may go and access things like PCI config spaces
> of devices
> which isn't a good idea for devices in D3_cold, so maybe skip this?
OK.

> 
> > 
> > +
> > +		if (adev->flags.power_manageable && adev-
> > >power.state <
> > +					lpi_constraints_table[i].m
> > in_dstate)
> > +			pr_info("LPI: Constraint [%s] not
> > matched\n",
> "Constrant [%s] not met"?
> 
> Also I'd use acpi_handle_info(adev->handle, ...) to print this.
> 
> > 
> > +				 lpi_constraints_table[i].name);
> I would print a message if !flags.power_manageable, because it means
> we
> can't get the constraint right in general.
> 
> Also I would print both power.state and min_state (possibly using
> acpi_power_state_string()) in this message as that is valuable for
> debugging.
OK.

Thanks,
Srinivas

