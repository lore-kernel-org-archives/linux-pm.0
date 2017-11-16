From: "Sajjan, Vikas C" <vikas.cha.sajjan@hpe.com>
Subject: RE: [PATCH v2 2/2] acpi/x86: Reuse the mp_register_ioapic_irq() in
 the function mp_override_legacy_irq()
Date: Thu, 16 Nov 2017 11:37:02 +0000
Message-ID: <TU4PR8401MB0525D194D8A3A2DAEB8A3C95D92E0@TU4PR8401MB0525.NAMPRD84.PROD.OUTLOOK.COM>
References: <1510824595-12287-1-git-send-email-vikas.cha.sajjan@hpe.com>
 <1510824595-12287-3-git-send-email-vikas.cha.sajjan@hpe.com>
 <alpine.DEB.2.20.1711161205020.2191@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1711161205020.2191@nanos>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kkamagui@gmail.com" <kkamagui@gmail.com>, "mingo@kernel.org" <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org



-----Original Message-----
From: Thomas Gleixner [mailto:tglx@linutronix.de] 
Sent: Thursday, November 16, 2017 4:35 PM
To: Sajjan, Vikas C <vikas.cha.sajjan@hpe.com>
Cc: rjw@rjwysocki.net; rafael.j.wysocki@intel.com; linux-pm@vger.kernel.org; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; kkamagui@gmail.com; mingo@kernel.org
Subject: Re: [PATCH v2 2/2] acpi/x86: Reuse the mp_register_ioapic_irq() in the function mp_override_legacy_irq()

On Thu, 16 Nov 2017, Vikas C Sajjan wrote:

> Modify the function mp_override_legacy_irq() to reuse the newly 
> introduced function mp_register_ioapic_irq().

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks.
