From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] x86/acpi: Fix improper handling of SCI INT for platforms
 supporting only IOAPIC mode
Date: Wed, 15 Nov 2017 18:58:44 +0100
Message-ID: <CAJZ5v0jQErbC729H0JCjO-RqJRYZ8P2zHdJm0HopXNB781G_aw@mail.gmail.com>
References: <1510306686-18230-1-git-send-email-vikas.cha.sajjan@hpe.com>
 <CAJZ5v0g8d=q1TZvacBZ_EDMjAnufQdHYkfbnkhv4kSH_FNOhDg@mail.gmail.com> <CS1PR8401MB05189C5186CD6E4B6509EAD5D9290@CS1PR8401MB0518.NAMPRD84.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CS1PR8401MB05189C5186CD6E4B6509EAD5D9290@CS1PR8401MB0518.NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-acpi-owner@vger.kernel.org
To: "Sajjan, Vikas C" <vikas.cha.sajjan@hpe.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Seunghun Han <kkamagui@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "Lakshminarasimha, Sunil Vishwanathpur" <sunil.vl@hpe.com>, "Attar, Abdul Lateef" <abdul-lateef.attar@hpe.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 15, 2017 at 6:30 PM, Sajjan, Vikas C
<vikas.cha.sajjan@hpe.com> wrote:
> Hi Rafael,
>
> -----Original Message-----
> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafae=
l J. Wysocki
> Sent: Wednesday, November 15, 2017 10:51 PM
> To: Sajjan, Vikas C <vikas.cha.sajjan@hpe.com>
> Cc: Linux PM <linux-pm@vger.kernel.org>; ACPI Devel Maling List <linux-ac=
pi@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Linux Kernel Ma=
iling List <linux-kernel@vger.kernel.org>; Seunghun Han <kkamagui@gmail.com=
>; Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@kernel.org>; La=
kshminarasimha, Sunil Vishwanathpur <sunil.vl@hpe.com>; Attar, Abdul Lateef=
 <abdul-lateef.attar@hpe.com>
> Subject: Re: [PATCH] x86/acpi: Fix improper handling of SCI INT for platf=
orms supporting only IOAPIC mode
>
> On Fri, Nov 10, 2017 at 10:38 AM, Vikas C Sajjan <vikas.cha.sajjan@hpe.co=
m> wrote:
>> The platforms which support only IOAPIC mode and whose SCI INT is
>> greater than 16, passes SCI INT via FADT and not via MADT int src
>> override structure. In such cases current logic fails to handle it and
>> throws error "Invalid bus_irq %u for legacy override". This patch
>> handles the above  mentioned case. While at it, also modify function
>> mp_override_legacy_irq() to use the newly introduced function mp_registe=
r_ioapic_irq().
>
> Actually, is it necessary to make this extra change here?
>
> How complicated would it be to separate it out?
>
> I can move these extra changes into a separate patch and keep only the fi=
x in this patch.

That would be useful I think in case someone wants to backport your
fix, for example.

Thanks,
Rafael
