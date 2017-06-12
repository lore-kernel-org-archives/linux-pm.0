From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on
 recent Dell laptops
Date: Tue, 13 Jun 2017 01:52:43 +0200
Message-ID: <CAJZ5v0jHf3zDJ6K8pN3DQZa2Xq14Cz5XQMpwxqJfwH=nS8jGdA@mail.gmail.com>
References: <CA+kEDGHNOQboMy34=EmH6zVSgtdVz1afOz5hwx5HBKshWhackA@mail.gmail.com>
 <88366b425cce41358ae8f88e43f3d201@ausx13mpc120.AMER.DELL.COM>
 <CA+kEDGEXEYEV+tGnswvHsFmOX5W_GAYPTYxk0YUUt0D1pdr92A@mail.gmail.com>
 <1872413.KDFIRZOQLU@aspire.rjw.lan> <CA+kEDGHHVJS9vgNVdowVQ4+eACFFdqTXR04e1V5qFcs_pZ0_yA@mail.gmail.com>
 <CA+kEDGF57sfz+f8_9XMqGQqPt-5LmtvceO70_gOpdaZ548tT-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CA+kEDGF57sfz+f8_9XMqGQqPt-5LmtvceO70_gOpdaZ548tT-g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mario Limonciello <Mario.Limonciello@dell.com>, "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 13, 2017 at 1:29 AM, J=C3=A9r=C3=B4me de Bretagne
<jerome.debretagne@gmail.com> wrote:
>>>> That was my assumption also, since my earlier 3-liner patch was doing
>>>> this exactly: trying to wake up on a regular 0xCE event. And it did wo=
rk.
>
> One more ouput for tonight. After doing a diff of the acpidump from
> both BIOS versions, I've found explicit references to the two 0xCE and
> 0xCF values right in the delta, in the dsdt.dsl files.

Right.  That's what my last message was about. :-)

> Here is the section that seems relevant in the newer one, for v1.1.31:
>
>         If (Local1 & 0x08)
>         {
>             Local1 =3D ECBT (One, 0x04)
>             If (Local1)
>             {
>                 If (OSYS >=3D 0x07DF)
>                 {
>                     Notify (\_SB.HIDD, 0xCE) // Hardware-Specific
>                 }
>                 ElseIf (CondRefOf (\_SB.PCI0.LPCB.ECDV.VGBI))
>                 {
>                     Notify (\_SB.PCI0.LPCB.ECDV.VGBI, 0xC0) // Hardware-S=
pecific
>                 }
>             }
>             ElseIf (OSYS >=3D 0x07DF)
>             {
>                 Notify (\_SB.HIDD, 0xCF) // Hardware-Specific
>             }
>             ElseIf (CondRefOf (\_SB.PCI0.LPCB.ECDV.VGBI))
>             {
>                 Notify (\_SB.PCI0.LPCB.ECDV.VGBI, 0xC1) // Hardware-Speci=
fic
>             }
>         }
>
>         If (Local1 & 0x0100)
>         {
>             Local1 =3D ECBT (One, 0x10)
>             If (Local1)
>             {
>                 Notify (\_SB.HIDD, 0xC6) // Hardware-Specific
>             }
>             Else
>             {
>                 Notify (\_SB.HIDD, 0xC7) // Hardware-Specific
>             }
>         }
>
>
> I'm new to ACPI but could that ECBT mean "EC Button" maybe?

That's just a method name which may or may not mean the above.

\_SB.PCI0.LPCB.ECDV is the EC, so it is all related.

However, the bottom line is that there is no way for the kernel at all
to know in advance that these events are going to be generated.

Thanks,
Rafael
