From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 1/2] ACPICA: adapt buffer length for Field Attrib Raw
 Process in Ops Region
Date: Mon, 1 Aug 2016 05:58:05 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC0844E@SHSMSX101.ccr.corp.intel.com>
References: <1469807366-24642-1-git-send-email-benjamin.tissoires@redhat.com>
 <1469807366-24642-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1469807366-24642-2-git-send-email-benjamin.tissoires@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Stephen Just <stephenjust@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

> From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> Subject: [PATCH 1/2] ACPICA: adapt buffer length for Field Attrib Raw
> Process in Ops Region
> 
> Detected on the Surface 3:
> The MSHW0011 driver uses Field Attrib Raw Process to return information
> for the ACPI Battery. The DSDT declares a parameter of 2 though
> functions like _BST or _BIX require a much bigger out buffer.
> 
> It looks like the incoming buffer has the requested size and we can
> work around the issue by using this input size as the output and
> parameters size.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=106231
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/acpi/acpica/exfield.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
> index d7d3ee3..a1bd041 100644
> --- a/drivers/acpi/acpica/exfield.c
> +++ b/drivers/acpi/acpica/exfield.c
> @@ -413,6 +413,17 @@ acpi_ex_write_data_to_field(union
> acpi_operand_object *source_desc,
>  			 *     Data[x-1]: (Bytes 2-x of the arbitrary length
> data buffer)
>  			 */
>  			length += 2;
> +
> +			/*
> +			 * When using Field Attrib Raw Process, it looks like
> +			 * the parameter access_length can be wrong and
> the
> +			 * required output buffer can be much bigger.
> +			 * So just take the incoming buffer length as the
> +			 * reference.
> +			 */
> +			if (accessor_type ==
> AML_FIELD_ATTRIB_RAW_PROCESS)
> +				length = source_desc->buffer.length;
> +
[Lv Zheng] 
I think the related code is:

            OperationRegion (OR02, GenericSerialBus, Zero, 0x0100)
            Field (OR02, BufferAcc, NoLock, Preserve)
            {
                Connection (BX00), 
                AccessAs (BufferAcc, AttribRawProcessBytes (0x02)), 
                BB00,   8
            }
            Name (SPB0, Buffer (0x80) {})
            CreateByteField (SPB0, Zero, STA2)
            CreateByteField (SPB0, One, LEN0)
            CreateByteField (SPB0, 0x02, CMD0)
            CreateByteField (SPB0, 0x03, DAT0)
            CreateByteField (SPB0, 0x04, DAT1)
            CreateDWordField (SPB0, 0x05, DAT2)
            CreateField (SPB0, 0x10, 0x0320, DAT3)
            Method (RSPB, 3, NotSerialized)
            {
                CMD0 = One
                LEN0 = 0x08
                DAT0 = Arg0
                DAT1 = Arg1
                DAT2 = Arg2
                SPB0 = ^^I2Z1.BB00 = SPB0 /* \_SB_.BAT0.SPB0 */
                ...
            }
And we have confirmed that the iASL disassembly result is correct.

Then this issue is not a parser issue, but looks like an issue either in interpreter or in BIOS as:

1. The following line triggers i2c operation region handlers:
    SPB0 = ^^I2Z1.BB00 = SPB0
    Where:
    SPB0 is sized as 0x80, BB00 is sized as 0x02.
    And in spec 19.6.1 AccessAs (Change Field Unit Access), it is said that AttribRawProcessBytes(AccessLength) requires an AccessLength parameter.
    However in this case, the length of the output buffer is not correct, much smaller than the container buffer.
    So this firstly looks like a BIOS issue. And then needn't be fixed in OS.
2. If this is not a BIOS bug but an interpreter bug, then SPB0 should be a buffer passing to the i2c region handler.
    The bug should be something related to "data type conversion".
    Please refer to:
    19.2.5.4 Implicit Source Operand Conversion
    19.2.5.5 Implicit Result Object Conversion
    It looks like that we have troubles in either 1st Store or 2nd Store.
    If so, it seems we shouldn't fix this issue here. And thus this fix also looks invalid.

IMO (may be wrong), this bug finally may cause dissension among different parties (BIOS, Windows, ACPICA, spec).

However, for the time being, is that possible to work this issue around in the i2c operation region driver?

Thanks and best regards
-Lv


>  			function = ACPI_WRITE | (accessor_type << 16);
>  		} else {	/* IPMI */
> 
> --
> 2.5.5

