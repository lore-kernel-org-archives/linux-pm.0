From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng implementation
Date: Fri, 30 Jun 2017 17:57:06 +0200
Message-ID: <20170630155706.GL26073@mail.corp.redhat.com>
References: <20170629121009.30234-1-benjamin.tissoires@redhat.com>
 <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Andy,

Thanks for the review :)

On Jun 29 2017 or thereabouts, Andy Shevchenko wrote:
> +Cc: Hans (he might give some advice regarding to the below)
> 
> On Thu, Jun 29, 2017 at 3:10 PM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > MSHW0011 replaces the battery firmware by using ACPI operation regions.
> > The values have been obtained by reverse engineering, and are subject to
> > errors. Looks like it works on overall pretty well.
> 
> What devices (laptops, tablets) have it?
> Surface 3. What else?

So far, Surface 3 only. It's a Microsoft PNPId, so I guess they control
which device has it. Maybe the model after the Surface 3 (reduced
platform) will have such chip, but for now, it's unknown.

> 
> > I couldn't manage to get the IRQ correctly triggered, so I am using a
> > good old polling thread to check for changes.
> 
> It might be
> 
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=106231
> 
> > +config ACPI_SURFACE3_POWER_OPREGION
> > +       tristate "Surface 3 battery platform operation region support"
> 
> depends on ACPI ?

Good point

> 
> > +       help
> > +         Select this option to enable support for ACPI operation
> > +         region of the Surface 3 battery platform driver.
> 
> > +/*
> > + * Supports for the power IC on the Surface 3 tablet.
> 
> Shouldn't it go to drivers/acpi/pmic folder ?

Already answered later in the thread, so yes, I'll move it there.

> 
> And did you check if it have actual chip IP vendor name and model?
> Most likely it's a TI (based?) solution.

As mentioned, I have strictly no idea. I can not crack open the Surface
3 without breaking the warranty (I already had to return it once because
the disk crashed).

And I do not find anything brand-related under Windows either:
- it's called "Surface Platform Power Driver"
- and the driver is provided by Microsoft

> 
> > + */
> 
> > +/*
> > + * Further findings regarding the 2 chips declared in the MSHW0011 are:
> > + * - there are 2 chips declared:
> > + *   . 0x22 seems to control the ADP1 line status (and probably the charger)
> > + *   . 0x55 controls the battery directly
> > + * - the battery chip uses a SMBus protocol (using plain SMBus allows non
> > + *   destructive commands):
> > + *   . the commands/registers used are in the range 0x00..0x7F
> > + *   . if bit 8 (0x80) is set in the SMBus command, the returned value is the
> > + *     same as when it is not set. There is a high chance this bit is the
> > + *     read/write
> > + *   . the various registers semantic as been deduced by observing the register
> > + *     dumps.
> 
> All of this sounds familiar if look at what Hans discovered while was
> doing INT33FE support.
> Hans, does above ring any bell to you?
> 
> > + */
> 
> > +static bool dump_registers;
> > +module_param_named(dump_registers, dump_registers, bool, 0644);
> > +MODULE_PARM_DESC(dump_registers,
> > +                "Dump the SMBus register at probe (debugging only).");
> 
> I'm not a fan of module parameter. Why not to use debugfs?

We can probably remove this entirely actually. We used this for reverse
engineering, but now I think it's time for it to be removed.

> 
> > +#define ACPI_BATTERY_STATE_DISCHARGING 0x1
> > +#define ACPI_BATTERY_STATE_CHARGING    0x2
> > +#define ACPI_BATTERY_STATE_CRITICAL    0x4
> 
> BIT() ?

Yep.

> 
> > +#define MSHW0011_EV_2_5                        0x1ff
> 
> Is it mask? GENMASK() then.

I have strictly no idea (anymore) :)
I wrote this code too long ago, and I can't remember what this was.
Looking at the other piece of code that uses it, I am not so sure :/

> 
> > +
> > +static int mshw0011_i2c_read_block(struct i2c_client *client, u8 reg, u8 *buf,
> > +                                  int len)
> > +{
> > +       int status, i;
> > +
> > +       for (i = 0; i < len; i++) {
> > +               status = i2c_smbus_read_byte_data(client, reg + i);
> > +               if (status < 0) {
> > +                       buf[i] = 0xff;
> > +                       continue;
> > +               }
> 
> Hmm... This looks weird. Why can you read entire block at once?

Yeah, looks like the Windows driver reads up to 32 bytes at a time. So
we should be able to have the same here.

> 
> > +
> > +               buf[i] = (u8)status;
> > +       }
> > +
> > +       return 0;
> > +}
> 
> > +static int
> > +mshw0011_notify(struct mshw0011_data *cdata, u8 arg1, u8 arg2,
> > +               unsigned int *ret_value)
> > +{
> 
> > +       static const uuid_le mshw0011_guid =
> 
> guid_t, please :-)

oops :)

> 
> > +               GUID_INIT(0x3F99E367, 0x6220, 0x4955,
> > +                         0x8B, 0x0F, 0x06, 0xEF, 0x2A, 0xE7, 0x94, 0x12);
> 
> > +       *ret_value = 0;
> > +       for (i = 0; i < obj->buffer.length; i++)
> > +               *ret_value |= obj->buffer.pointer[i] << (i * 8);
> 
> 
> 
> > +
> > +       ACPI_FREE(obj);
> > +       return 0;
> > +}
> 
> > +static int mshw0011_bix(struct mshw0011_data *cdata, struct bix *bix)
> > +{
> 
> > +       memcpy(bix->serial, buf + 7, 3);
> > +       memcpy(bix->serial + 3, buf, 6);
> > +       bix->serial[9] = '\0';
> 
> snprintf()?

probably :)

> 
> > +       bix->cycle_count = le16_to_cpu(ret);
> 
> non-x86 ?

Well, nothing prevents this chip to be used on arm64 also, so I'd rather
have no-op operations but be big endian friendly.

> 
> > +       memcpy(bix->OEM, buf, 3);
> > +       bix->OEM[4] = '\0';
> 
> snprintf() ?
> 
> > +
> > +       return 0;
> > +}
> 
> > +static int mshw0011_bst(struct mshw0011_data *cdata, struct bst *bst)
> > +{
> > +       struct i2c_client *client = cdata->bat0;
> > +       int rate, capacity, voltage, state;
> > +       s16 tmp;
> > +
> > +       rate = i2c_smbus_read_word_data(client, MSHW0011_BAT0_REG_RATE);
> > +       if (rate < 0)
> > +               return rate;
> > +
> > +       capacity = i2c_smbus_read_word_data(client, MSHW0011_BAT0_REG_CAPACITY);
> > +       if (capacity < 0)
> > +               return capacity;
> > +
> > +       voltage = i2c_smbus_read_word_data(client, MSHW0011_BAT0_REG_VOLTAGE);
> > +       if (voltage < 0)
> > +               return voltage;
> > +
> 
> > +       tmp = le16_to_cpu(rate);
> 
> Do we need that on x86?
> 
> > +       bst->battery_present_rate = abs((s32)tmp);
> > +
> > +       state = 0;
> 
> > +       if ((s32) tmp > 0)
> 
> See above, perhaps using rate directly.
> 
> > +               state |= ACPI_BATTERY_STATE_CHARGING;
> > +       else if ((s32) tmp < 0)
> 
> Ditto.
> 
> > +       bst->battery_remaining_capacity = le16_to_cpu(capacity);
> > +       bst->battery_present_voltage = le16_to_cpu(voltage);
> 
> non-x86 ?

For all these, I'd rather keep the le16_to_cpu calls. Simply because
ACPI is not x86 only :)

> 
> > +}
> > +
> 
> 
> ret = 0; ?
> ...
> > +       switch (gsb->cmd.arg1) {
> > +       case MSHW0011_CMD_BAT0_STA:
> 
> > +               ret = 0;
> 
> See above.

Works too :)

> 
> > +               break;
> > +       case MSHW0011_CMD_BAT0_BIX:
> > +               ret = mshw0011_bix(cdata, &gsb->bix);
> > +               break;
> > +       case MSHW0011_CMD_BAT0_BTP:
> 
> > +               ret = 0;
> 
> Ditto.
> 
> > +               cdata->trip_point = gsb->cmd.arg2;
> > +               break;
> > +       case MSHW0011_CMD_BAT0_BST:
> > +               ret = mshw0011_bst(cdata, &gsb->bst);
> > +               break;
> > +       default:
> > +               pr_info("command(0x%02x) is not supported.\n", gsb->cmd.arg1);
> > +               ret = AE_BAD_PARAMETER;
> > +               goto err;
> > +       }
> > +
> > + out:
> > +       gsb->ret = status;
> > +       gsb->status = 0;
> > +
> > + err:
> > +       ACPI_FREE(ares);
> > +       return ret;
> > +}
> > +
> > +static int mshw0011_install_space_handler(struct i2c_client *client)
> > +{
> > +       acpi_handle handle;
> > +       struct mshw0011_handler_data *data;
> > +       acpi_status status;
> > +
> > +       handle = ACPI_HANDLE(&client->dev);
> > +
> > +       if (!handle)
> > +               return -ENODEV;
> > +
> > +       data = kzalloc(sizeof(struct mshw0011_handler_data),
> > +                           GFP_KERNEL);
> > +       if (!data)
> > +               return -ENOMEM;
> > +
> > +       data->client = client;
> > +       status = acpi_bus_attach_private_data(handle, (void *)data);
> > +       if (ACPI_FAILURE(status)) {
> > +               kfree(data);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       status = acpi_install_address_space_handler(handle,
> > +                               ACPI_ADR_SPACE_GSBUS,
> > +                               &mshw0011_space_handler,
> > +                               NULL,
> > +                               data);
> > +       if (ACPI_FAILURE(status)) {
> > +               dev_err(&client->dev, "Error installing i2c space handler\n");
> > +               acpi_bus_detach_private_data(handle);
> > +               kfree(data);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       acpi_walk_dep_device_list(handle);
> > +       return 0;
> > +}
> > +
> > +static void mshw0011_remove_space_handler(struct i2c_client *client)
> > +{
> > +       acpi_handle handle = ACPI_HANDLE(&client->dev);
> > +       struct mshw0011_handler_data *data;
> > +       acpi_status status;
> > +
> > +       if (!handle)
> > +               return;
> > +
> > +       acpi_remove_address_space_handler(handle,
> > +                               ACPI_ADR_SPACE_GSBUS,
> > +                               &mshw0011_space_handler);
> > +
> > +       status = acpi_bus_get_private_data(handle, (void **)&data);
> > +       if (ACPI_SUCCESS(status))
> > +               kfree(data);
> > +
> > +       acpi_bus_detach_private_data(handle);
> > +}
> > +
> 
> > +static int acpi_find_i2c(struct acpi_resource *ares, void *data)
> > +{
> > +       struct mshw0011_lookup *lookup = data;
> > +
> > +       if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> > +               return 1;
> > +
> > +       if (lookup->n++ == lookup->index && !lookup->addr)
> > +               lookup->addr = ares->data.i2c_serial_bus.slave_address;
> > +
> > +       return 1;
> > +}
> > +
> > +static int mshw0011_i2c_resource_lookup(struct mshw0011_data *cdata,
> > +                                       unsigned int index)
> > +{
> > +       struct i2c_client *client = cdata->adp1;
> > +       struct acpi_device *adev = ACPI_COMPANION(&client->dev);
> > +       struct mshw0011_lookup lookup = {
> > +               .cdata = cdata,
> > +               .index = index,
> > +       };
> > +       struct list_head res_list;
> > +       int ret;
> > +
> > +       INIT_LIST_HEAD(&res_list);
> > +
> > +       ret = acpi_dev_get_resources(adev, &res_list, acpi_find_i2c, &lookup);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       acpi_dev_free_resource_list(&res_list);
> > +
> > +       if (!lookup.addr)
> > +               return -ENOENT;
> > +
> > +       return lookup.addr;
> > +}
> 
> Strange you have above functions here. It's a copy paste from I2C
> core. Please, think about way of deduplicating it.

See Hans' reply and mine, I'll amend this in v3.

> 
> > +static void mshw0011_dump_registers(struct i2c_client *client,
> > +                                   struct i2c_client *bat0, u8 end_register)
> > +{
> > +       char *rd_buf;
> 
> > +       char prefix[128];
> 
> 128 is too way big for a prefix.

I know I should have used 1024 :)

Anyway, I think I'll drop the register dumps here, we don't need it
anymore (and I can now sniff the I2C communications under Windows, so we
can always doule check with those dumps).

> 
> > +       unsigned int length = end_register + 1;
> > +       int error;
> > +
> > +       snprintf(prefix, ARRAY_SIZE(prefix), "%s: ", bat0->name);
> 
> > +       prefix[127] = '\0';
> 
> Why?

Just me being paranoid in case the code doesn't follow the spec... Yeah, I'll
remove it.

> 
> > +       rd_buf = kzalloc(length, GFP_KERNEL);
> 
> > +       error = mshw0011_i2c_read_block(bat0, 0, rd_buf, length);
> > +       print_hex_dump(KERN_INFO, prefix, DUMP_PREFIX_OFFSET, 16, 1,
> > +                      rd_buf, length, true);
> 
> If you switch to debugfs it makes things a bit more easier to handle I think.
> 
> > +
> > +       kfree(rd_buf);
> > +}
> 
> > +static int mshw0011_probe(struct i2c_client *client,
> > +                         const struct i2c_device_id *id)
> > +{
> 
> > +       data->notify_version = version == MSHW0011_EV_2_5;
> 
> 0x1ff as version sounds hmm suspicious.

So after a little bit of digging, it appears those values were taken
from the DSDT:
https://bugzilla.kernel.org/attachment.cgi?id=187171 line 11694.

It appears 0x3F is EV 2.1 and before, and 0x1FF is EV 2.5 and above.
The returned value is not a version of the chip, just a flag to know
which path we are taking in the DSM.

The name is probably not the best.

> 
> > +static const struct i2c_device_id mshw0011_id[] = {
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, mshw0011_id);
> 
> ->probe_new(), please.

Correct

> 
> If I2C framework is _still_ broken we need to fix that part.

I haven't check, so let's see for v3.

> 
> > +#ifdef CONFIG_ACPI
> 
> Is it going to be non-ACPI at all? See my proposal to Kconfig as well.

Sounds good to me. I'll drop this #ifdef.

> 
> > +               .acpi_match_table = ACPI_PTR(mshw0011_acpi_match),
> 
> ACPI_PTR() might be gone


Ok.

Thanks again for the review, I'll try to get a v3 soon.

Cheers,
Benjamin
