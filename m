From: "Sajjan, Vikas C" <vikas.cha.sajjan@hpe.com>
Subject: RE: [PATCH v3 1/2] acpi/x86: Fix improper handling of SCI INT for
 platforms supporting only IOAPIC mode
Date: Fri, 17 Nov 2017 14:00:14 +0000
Message-ID: <CS1PR8401MB0518E69621848A5BFB398B2CD92F0@CS1PR8401MB0518.NAMPRD84.PROD.OUTLOOK.COM>
References: <1510848825-21965-1-git-send-email-vikas.cha.sajjan@hpe.com>
 <1510848825-21965-2-git-send-email-vikas.cha.sajjan@hpe.com>
 <alpine.DEB.2.20.1711171126270.7700@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1711171126270.7700@nanos>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kkamagui@gmail.com" <kkamagui@gmail.com>, "mingo@kernel.org" <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org


On Thu, 16 Nov 2017, Vikas C Sajjan wrote:

> The platforms which support only IOAPIC mode, pass the SCI information 
> above the legacy space (0-15) via the FADT mechanism and not via MADT.
> In such cases the mp_override_legacy_irq() used by 
> acpi_sci_ioapic_setup() to register SCI interrupts fails for 
> interrupts >= 16, since it is meant to handle only legacy space and 
> throws error "Invalid bus_irq %u for legacy override". Hence add a new 
> function to handle SCI interrupts >= 16 and invoke it conditionally in 
> acpi_sci_ioapic_setup().The code duplication due to this new function will be cleaned up in a separate patch.

This reads way better, but I have a small nit pick. In the example I gave you there were multiple paragraphs on purpose to separate the different parts. So if I just split the above lump into separate paragraphs:

[1]
   The platforms which support only IOAPIC mode, pass the SCI information
   above the legacy space (0-15) via the FADT mechanism and not via MADT.

[2]
   In such cases the mp_override_legacy_irq() used by acpi_sci_ioapic_setup()
   to register SCI interrupts fails for interrupts >= 16, since it is meant to
   handle only legacy space and throws error "Invalid bus_irq %u for legacy
   override".

[3]
   Hence add a new function to handle SCI interrupts >= 16 and
   invoke it conditionally in acpi_sci_ioapic_setup().

[4]
   The code duplication due to this new function will be cleaned up in a
   separate patch.

then this is clearly structured:

[1] describes the context.

[2] describes the failure

[3] describes the solution

[4] is an extra note to tell the reviewer/reader that you are aware of the
    code duplication and this is addressed later. 

No need to resend. I can do that when picking it up.
Thanks.

> Co-developed-by: Sunil V L <sunil.vl@hpe.com>

I had a discussion with Greg about this tag which resulted in a patch so it should be soon part of the official documentation:

 https://lkml.kernel.org/r/20171116132309.GA8449@kroah.com

Great. Good to know that.

We agreed that both authors should add their Signed-off-by to document that the work conforms with the Developer Certificate of Origin. I'll add that if that's ok for you.

I am OK with that. Please go ahead.

Thanks for following up!

Thank you for the review.

       tglx
