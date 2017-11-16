From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v2 1/2] acpi/x86: Fix improper handling of SCI INT for
 platforms supporting only IOAPIC mode
Date: Thu, 16 Nov 2017 13:16:30 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711161301250.2191@nanos>
References: <1510824595-12287-1-git-send-email-vikas.cha.sajjan@hpe.com> <1510824595-12287-2-git-send-email-vikas.cha.sajjan@hpe.com> <alpine.DEB.2.20.1711161147200.2191@nanos>
 <TU4PR8401MB0525A1594F5D2E063B3A8CB2D92E0@TU4PR8401MB0525.NAMPRD84.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45666 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934661AbdKPMQ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2017 07:16:58 -0500
In-Reply-To: <TU4PR8401MB0525A1594F5D2E063B3A8CB2D92E0@TU4PR8401MB0525.NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Sajjan, Vikas C" <vikas.cha.sajjan@hpe.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kkamagui@gmail.com" <kkamagui@gmail.com>, "mingo@kernel.org" <mingo@kernel.org>, "Lakshminarasimha, Sunil Vishwanathpur" <sunil.vl@hpe.com>, "Attar, Abdul Lateef" <abdul-lateef.attar@hpe.com>

On Thu, 16 Nov 2017, Sajjan, Vikas C wrote:
> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx@linutronix.de] 
> Sent: Thursday, November 16, 2017 4:35 PM
> To: Sajjan, Vikas C <vikas.cha.sajjan@hpe.com>
> Cc: rjw@rjwysocki.net; rafael.j.wysocki@intel.com; linux-pm@vger.kernel.org; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; kkamagui@gmail.com; mingo@kernel.org; Lakshminarasimha, Sunil Vishwanathpur <sunil.vl@hpe.com>; Attar, Abdul Lateef <abdul-lateef.attar@hpe.com>
> Subject: Re: [PATCH v2 1/2] acpi/x86: Fix improper handling of SCI INT for platforms supporting only IOAPIC mode

Can you please fix your mail client to not pointlessly copy the full mail
header?

 On Thu, 16 Nov 2017, Thomas Gleixner wrote:

is enough. The rest is in the real mail headers already.

> On Thu, 16 Nov 2017, Vikas C Sajjan wrote:
> > Signed-off-by: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
> > Signed-off-by: Sunil V L <sunil.vl@hpe.com>
> > Signed-off-by: Abdul Lateef Attar <abdul-lateef.attar@hpe.com>
> 
> This Signed-off-by chain is broken. It says:
> 
>      Vikas wrote the patch and handed it to Sunil
>      Sunil handed it to Abdul
>      Abdul sent it to lkml
> 
> Which is obviously not the case.

> 3 of us worked on it, hence I had put all the 3 "Signed-off-by". Are you
> suggesting to call-out who did what.  Is that what you mean, when you say
> "Signed-off-by chain is broken".

No. As I explained above. The Signed-off-by is a chain. The first one is
from the author. The following ones are from people who handled,
transported or applied the patch.

See Documentation/process/submitting-patches.rst the chapter:

  Developer's Certificate of Origin 1.1

for further clarification.

Unfortunately we have no canonical way to express joint develoment, but we
have used non formal tags for that, like

     Co-developed-by:

which give credits to the people who were involved in the development.

Thanks,

	tglx
