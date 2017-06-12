From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
        <jerome.debretagne@gmail.com>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Tue, 13 Jun 2017 00:50:37 +0200
Message-ID: <CA+kEDGHHVJS9vgNVdowVQ4+eACFFdqTXR04e1V5qFcs_pZ0_yA@mail.gmail.com>
References: <CA+kEDGHNOQboMy34=EmH6zVSgtdVz1afOz5hwx5HBKshWhackA@mail.gmail.com>
 <88366b425cce41358ae8f88e43f3d201@ausx13mpc120.AMER.DELL.COM>
 <CA+kEDGEXEYEV+tGnswvHsFmOX5W_GAYPTYxk0YUUt0D1pdr92A@mail.gmail.com> <1872413.KDFIRZOQLU@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1872413.KDFIRZOQLU@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mario.Limonciello@dell.com, "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

>> That was my assumption also, since my earlier 3-liner patch was doing
>> this exactly: trying to wake up on a regular 0xCE event. And it did work=
.
>
> OK
>
> Can you try the patch below, please?

Thank you for this patch proposal. I've applied it but the system with
BIOS 1.1.31 doesn't wake up on short press.

I can see the following (added) messages in the logs for info:

- short press first while suspended -> no wake-up
[  702.567912] intel-hid INT33D5:00: notify_handler with event 0xce
[  702.567913] intel-hid INT33D5:00: 0xce =3D=3D 0xc0 || !priv->array
[  702.765067] intel-hid INT33D5:00: notify_handler with event 0xcf
[  702.765072] intel-hid INT33D5:00: 0xcf =3D=3D 0xc0 || !priv->array
- long press then -> waking up the system
[  704.954703] intel-hid INT33D5:00: notify_handler with event 0xce
[  704.954704] intel-hid INT33D5:00: 0xce =3D=3D 0xc0 || !priv->array
[  711.646088] intel-hid INT33D5:00: notify_handler with event 0xcf
[  711.646092] intel-hid INT33D5:00: unknown event 0xcf

confirming that priv->array is indeed not set, even with the patch below.

With BIOS 1.1.20, I don't have such logs, notify_handler seems never called=
.

J=C3=A9rome

> ---
>  drivers/platform/x86/intel-hid.c |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/platform/x86/intel-hid.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/platform/x86/intel-hid.c
> +++ linux-pm/drivers/platform/x86/intel-hid.c
> @@ -270,12 +270,17 @@ static int intel_hid_probe(struct platfo
>         }
>
>         /* Setup 5 button array */
> -       status =3D acpi_evaluate_integer(handle, "HEBC", NULL, &event_cap=
);
> -       if (ACPI_SUCCESS(status) && (event_cap & 0x20000)) {
> -               dev_info(&device->dev, "platform supports 5 button array\=
n");
> -               err =3D intel_button_array_input_setup(device);
> -               if (err)
> -                       pr_err("Failed to setup Intel 5 button array hotk=
eys\n");
> +       if (acpi_has_method(handle, "BTNC") && acpi_has_method(handle, "B=
TNE")) {
> +               unsigned long long event_cap;
> +
> +               status =3D acpi_evaluate_integer(handle, "HEBC", NULL, &e=
vent_cap);
> +               if ((ACPI_SUCCESS(status) && (event_cap & 0x20000)) ||
> +                   status =3D=3D AE_NOT_FOUND) {
> +                       dev_info(&device->dev, "5-button array supported\=
n");
> +                       err =3D intel_button_array_input_setup(device);
> +                       if (err)
> +                               dev_dbg(&device->dev, "5-button array set=
up failure\n");
> +               }
>         }
>
>         status =3D acpi_install_notify_handler(handle,
>
