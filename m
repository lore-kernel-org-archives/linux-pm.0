From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Tue, 13 Jun 2017 01:37:48 +0200
Message-ID: <CAJZ5v0hSuDWcWPrA4BWfujQeX8ah9xoJ9222UKs+ehedo0=b+g@mail.gmail.com>
References: <CA+kEDGHNOQboMy34=EmH6zVSgtdVz1afOz5hwx5HBKshWhackA@mail.gmail.com>
 <88366b425cce41358ae8f88e43f3d201@ausx13mpc120.AMER.DELL.COM>
 <CA+kEDGEXEYEV+tGnswvHsFmOX5W_GAYPTYxk0YUUt0D1pdr92A@mail.gmail.com>
 <1872413.KDFIRZOQLU@aspire.rjw.lan> <CA+kEDGHHVJS9vgNVdowVQ4+eACFFdqTXR04e1V5qFcs_pZ0_yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CA+kEDGHHVJS9vgNVdowVQ4+eACFFdqTXR04e1V5qFcs_pZ0_yA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mario Limonciello <Mario.Limonciello@dell.com>, "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 13, 2017 at 12:50 AM, J=C3=A9r=C3=B4me de Bretagne
<jerome.debretagne@gmail.com> wrote:
>>> That was my assumption also, since my earlier 3-liner patch was doing
>>> this exactly: trying to wake up on a regular 0xCE event. And it did wor=
k.
>>
>> OK
>>
>> Can you try the patch below, please?
>
> Thank you for this patch proposal. I've applied it but the system with
> BIOS 1.1.31 doesn't wake up on short press.
>
> I can see the following (added) messages in the logs for info:
>
> - short press first while suspended -> no wake-up
> [  702.567912] intel-hid INT33D5:00: notify_handler with event 0xce
> [  702.567913] intel-hid INT33D5:00: 0xce =3D=3D 0xc0 || !priv->array
> [  702.765067] intel-hid INT33D5:00: notify_handler with event 0xcf
> [  702.765072] intel-hid INT33D5:00: 0xcf =3D=3D 0xc0 || !priv->array
> - long press then -> waking up the system
> [  704.954703] intel-hid INT33D5:00: notify_handler with event 0xce
> [  704.954704] intel-hid INT33D5:00: 0xce =3D=3D 0xc0 || !priv->array
> [  711.646088] intel-hid INT33D5:00: notify_handler with event 0xcf
> [  711.646092] intel-hid INT33D5:00: unknown event 0xcf
>
> confirming that priv->array is indeed not set, even with the patch below.
>
> With BIOS 1.1.20, I don't have such logs, notify_handler seems never call=
ed.

OK

I've just had a look at the acpidump output files you attached to
https://bugzilla.kernel.org/show_bug.cgi?id=3D195897 and actually none
of them has anything like BTNC or BTNE or similar under the device
object intel-hid binds to.  In fact, the definition of that device
object on both the BIOS versions is exactly the same AFAICS.

However, BIOS 1.1.31 contains additional Notify () invocations in the
NEVT () method used for processing EC events (invoked by _Q66) with
event values corresponding to the 5-button array power button
scancodes.  That's why your first debug patch works.

Thanks,
Rafael
