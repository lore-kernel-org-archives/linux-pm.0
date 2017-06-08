From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
        <jerome.debretagne@gmail.com>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Fri, 9 Jun 2017 01:44:29 +0200
Message-ID: <CA+kEDGFUuSC1CpCEgOT+HMTrDa-r1y59kM9-CYn0PSgtuKaG5Q@mail.gmail.com>
References: <CA+kEDGHNOQboMy34=EmH6zVSgtdVz1afOz5hwx5HBKshWhackA@mail.gmail.com>
 <31f516ad46d74225a5d6324c5fd24751@ausx13mpc124.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <31f516ad46d74225a5d6324c5fd24751@ausx13mpc124.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Mario,

>> Here is some feedback for Dell Latitude 7275, as suggested by Srinivas
>> in https://bugzilla.kernel.org/show_bug.cgi?id=3D195897#c15 .
>>
>> For some context on that model, suspend-to-RAM is not safe as the
>> system hangs (raised in the above bug report). I'm wondering if this
>> is expected somehow, due to S3 not being supported on that model, as
>> discussed for the XPS 13 9365. Maybe Mario or someone else from Dell
>> would be able to confirm this point.
>>
> The Latitude 7275 was not a machine that was tested with Linux during
> development.
> This machine shipped with Windows 8, right?

I've read that this machine shipped at first with the option to have it eit=
her
with Windows 10 or Windows 8.1. Mine came with Windows 10.

> I believe this machine also supports Connected Standby (the precursor
> to Modern Standby that behaves very similarly).

I've in fact found some WinHEC slides stating that it was among the first
systems to support Modern Standby, here for reference:
https://f.ch9.ms/public/WinHEC/06_WinHECDec2016-DesigningPowerEfficient_v02=
.pptx

> I have an ask out to someone who can confirm that.

Thanks. I'm hoping there's a chance to make it work with suspend-to-RAM
on Linux still, in addition to suspend-to-idle, by fixing the current hang.

Thanks,
J=C3=A9rome
