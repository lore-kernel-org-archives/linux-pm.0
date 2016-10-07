From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] power: surface3_power: MSHW0011 rev-eng implementation
Date: Fri, 7 Oct 2016 21:44:08 +0300
Message-ID: <CAHp75VdXowsT=KRsRcCExdFkCzXMsvT2Yyxd5WVzxvyutxJMBw@mail.gmail.com>
References: <1469807366-24642-1-git-send-email-benjamin.tissoires@redhat.com> <1469807366-24642-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1469807366-24642-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Stephen Just <stephenjust@gmail.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 29, 2016 at 6:49 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> MSHW0011 replaces the battery firmware by using ACPI operation regions.
> The values have been obtained by reverse engineering, and are subject to
> errors. Looks like it works on overall pretty well.
>
> I couldn't manage to get the IRQ correctly triggered, so I am using a
> good old polling thread to check for changes.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=106231


> +/*
> + * This driver has been reverse-engineered by parsing the DSDT of the Surface 3
> + * and looking at the registers of the chips.
> + *
> + * The DSDT allowed to find out that:
> + * - the driver is required for the ACPI BAT0 device to communicate to the chip
> + *   through an operation region.
> + * - the various defines for the operation region functions to communicate with
> + *   this driver
> + * - the DSM 3f99e367-6220-4955-8b0f-06ef2ae79412 allows to trigger ACPI
> + *   events to BAT0 (the code is all available in the DSDT).
> + *
> + * Further findings regarding the 2 chips declared in the MSHW0011 are:
> + * - there are 2 chips declared:
> + *   . 0x22 seems to control the ADP1 line status (and probably the charger)
> + *   . 0x55 controls the battery directly
> + * - the battery chip uses a SMBus protocol (using plain SMBus allows non
> + *   destructive commands):
> + *   . the commands/registers used are in the range 0x00..0x7F
> + *   . if bit 8 (0x80) is set in the SMBus command, the returned value is the
> + *     same as when it is not set. There is a high chance this bit is the
> + *     read/write
> + *   . the various registers semantic as been deduced by observing the register
> + *     dumps.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/acpi.h>
> +#include <linux/kthread.h>
> +#include <linux/freezer.h>

Alphabetical order?

> +
> +#include <asm/unaligned.h>
> +
> +#define POLL_INTERVAL          (HZ * 2)

(2 * HZ)

> +static int
> +mshw0011_notify(struct mshw0011_data *cdata, u8 arg1, u8 arg2,
> +               unsigned int *ret_value)
> +{
> +       static const u8 mshw0011_guid[] = {
> +               0x67, 0xE3, 0x99, 0x3F, 0x20, 0x62, 0x55, 0x49,
> +               0x8b, 0x0f, 0x06, 0xef, 0x2a, 0xe7, 0x94, 0x12,
> +       };

What about uuid_le?

> +       union acpi_object *obj;
> +       struct acpi_device *adev;
> +       acpi_handle handle;
> +       unsigned int i;
> +
> +       handle = ACPI_HANDLE(&cdata->adp1->dev);
> +       if (!handle || acpi_bus_get_device(handle, &adev))
> +               return -ENODEV;
> +
> +       obj = acpi_evaluate_dsm_typed(handle, mshw0011_guid, arg1, arg2, NULL,
> +                                     ACPI_TYPE_BUFFER);
> +       if (!obj) {
> +               dev_err(&cdata->adp1->dev, "device _DSM execution failed\n");
> +               return -ENODEV;
> +       }
> +
> +       *ret_value = 0;
> +       for (i = 0; i < obj->buffer.length; i++)
> +               *ret_value |= obj->buffer.pointer[i] << (i * 8);
> +
> +       ACPI_FREE(obj);
> +       return 0;
> +}
> +

> +static const struct bix default_bix = {
> +       .revision = 0x00,
> +       .power_unit = 0x01,
> +       .design_capacity = 0x1dca,
> +       .last_full_charg_capacity = 0x1dca,
> +       .battery_technology = 0x01,
> +       .design_voltage = 0x10df,
> +       .design_capacity_of_warning = 0x8f,
> +       .design_capacity_of_low = 0x47,
> +       .cycle_count = 0xffffffff,

> +       .measurement_accuracy = 0x00015F90,
> +       .max_sampling_time = 0x03E8,
> +       .min_sampling_time = 0x03E8,
> +       .max_average_interval = 0x03E8,
> +       .min_average_interval = 0x03E8,

Capital vs. small letters for hex?

> +       .battery_capacity_granularity_1 = 0x45,
> +       .battery_capacity_granularity_2 = 0x11,
> +       .model = "P11G8M",
> +       .serial = "",
> +       .type = "LION",
> +       .OEM = "",
> +};

> +static int mshw0011_bix(struct mshw0011_data *cdata, struct bix *bix)
> +{
> +       struct i2c_client *client = cdata->bat0;

> +       int ret;
> +       char buf[10];

Exchange order?

> +static int mshw0011_poll_task(void *data)
> +{
> +       struct mshw0011_data *cdata = data;
> +       int ret = 0;
> +
> +       cdata->kthread_running = true;
> +
> +       set_freezable();
> +
> +       while (!kthread_should_stop()) {
> +               schedule_timeout_interruptible(POLL_INTERVAL);
> +               try_to_freeze();
> +               ret = mshw0011_isr(data);
> +               if (ret)
> +                       goto out;

break; ?

> +       }
> +
> +out:
> +       cdata->kthread_running = false;
> +       return ret;
> +}
> +

> +static acpi_status
> +mshw0011_space_handler(u32 function, acpi_physical_address command,
> +                       u32 bits, u64 *value64,
> +                       void *handler_context, void *region_context)
> +{
> +       int status = 1;


> +       switch (gsb->cmd.arg1) {
> +       case MSHW0011_CMD_BAT0_STA:

> +               status = 1;

Already 1?

> +               ret = 0;
> +               break;
> +       case MSHW0011_CMD_BAT0_BIX:
> +               status = 1;

Ditto.

> +               ret = mshw0011_bix(cdata, &gsb->bix);
> +               break;
> +       case MSHW0011_CMD_BAT0_BTP:
> +               status = 1;

Ditto.

> +               ret = 0;
> +               cdata->trip_point = gsb->cmd.arg2;
> +               break;
> +       case MSHW0011_CMD_BAT0_BST:
> +               status = 1;

Ditto.

> +               ret = mshw0011_bst(cdata, &gsb->bst);
> +               break;
> +       default:
> +               pr_info("command(0x%02x) is not supported.\n", gsb->cmd.arg1);
> +               ret = AE_BAD_PARAMETER;
> +               goto err;
> +       }
> +
> + out:
> +       gsb->ret = status;
> +       gsb->status = 0;
> +
> + err:
> +       ACPI_FREE(ares);
> +       return ret;
> +}

> +static void mshw0011_remove_space_handler(struct i2c_client *client)
> +{
> +       acpi_handle handle;
> +       struct mshw0011_handler_data *data;
> +       acpi_status status;
> +
> +       handle = ACPI_HANDLE(&client->dev);

> +

Redundant.

> +       if (!handle)
> +               return;

> +static void mshw0011_dump_registers(struct i2c_client *client,
> +                                   struct i2c_client *bat0, u8 max)
> +{
> +       char rd_buf[60];
> +       int error, i, c;
> +       char buff[17 * 3 * 2] = {0};
> +
> +       dev_info(&client->dev, "dumping registers 0x00 to 0x%02x:\n",
> +                (max - 1) / 0x20 * 0x20 + 0x1f);

DIV_ROUND_UP()?

> +
> +       for (i = 0; i < max; i += 0x20) {
> +               memset(rd_buf, 0, sizeof(rd_buf));
> +               error = mshw0011_i2c_read_block(bat0, i, rd_buf, 0x20);

> +               dev_info(&client->dev, " read 0x%02x: %*ph|%*ph\n",
> +                        i,
> +                        0x10, rd_buf,
> +                        0x10, rd_buf + 0x10);
> +               for (c = 0; c < 0x20; c++) {
> +                       if (rd_buf[c] >= 0x20 && rd_buf[c] <= 0x7e) {
> +                               buff[c * 3 + 0] = ' ';
> +                               buff[c * 3 + 1] = rd_buf[c];
> +                       } else {
> +                               buff[c * 3 + 0] = '-';
> +                               buff[c * 3 + 1] = '-';
> +                       }
> +                       buff[c * 3 + 2] = (c + 1) % 0x10 ? ' ' : '|';
> +               }
> +               buff[0x1f * 3 + 2] = '\0';
> +               dev_info(&client->dev, "ascii 0x%02x: %s\n", i, buff);

hex_dump_to_buffer() / print_hex_dump() ?

> +       }
> +}


-- 
With Best Regards,
Andy Shevchenko
