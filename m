From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] x86/acpi: Fix improper handling of SCI INT for platforms
 supporting only IOAPIC mode
Date: Wed, 15 Nov 2017 18:20:36 +0100
Message-ID: <CAJZ5v0g8d=q1TZvacBZ_EDMjAnufQdHYkfbnkhv4kSH_FNOhDg@mail.gmail.com>
References: <1510306686-18230-1-git-send-email-vikas.cha.sajjan@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1510306686-18230-1-git-send-email-vikas.cha.sajjan@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Seunghun Han <kkamagui@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Sunil V L <sunil.vl@hpe.com>, Abdul Lateef Attar <abdul-lateef.attar@hpe.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 10, 2017 at 10:38 AM, Vikas C Sajjan
<vikas.cha.sajjan@hpe.com> wrote:
> The platforms which support only IOAPIC mode and whose SCI INT is
> greater than 16, passes SCI INT via FADT and not via MADT int src override
> structure. In such cases current logic fails to handle it and throws error
> "Invalid bus_irq %u for legacy override". This patch handles the above
>  mentioned case. While at it, also modify function mp_override_legacy_irq()
> to use the newly introduced function mp_register_ioapic_irq().

Actually, is it necessary to make this extra change here?

How complicated would it be to separate it out?

Thanks,
Rafael
