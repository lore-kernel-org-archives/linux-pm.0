From: "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>
Subject: RE: [PATCH 0/4] Fix how CPUs are enumerated when there's more than
 255 CPUs
Date: Wed, 9 Sep 2015 07:01:19 +0000
Message-ID: <C1C2579D7BE026428F81F41198ADB172378AACE4@irsmsx110.ger.corp.intel.com>
References: <20150827093738.GA21134@red-moon>
 <1441710480-17622-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1441710480-17622-2-git-send-email-lukasz.anaczkowski@intel.com>
 <55EF0C7A.7070105@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <55EF0C7A.7070105@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "tomasz.nowicki@linaro.org" <tomasz.nowicki@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "jason@lakedaemon.net" <jason@lakedaemon.net>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Marc Zyngier [mailto:marc.zyngier@arm.com] 
Sent: Tuesday, September 8, 2015 6:28 PM

> In my view, this makes the change a lot more palatable, and it can fit in exactly two patches:
>
> 1) add the acpi_subtable_proc stuff with the compatibility helpers
> 2) change arch/x86/kernel/acpi/boot.c to do whatever you want it
>   to do

> It will be a lot easier to review and to verify.

Thanks, Marc.
Sounds you're right, I'll try to follow KISS rule better next time. Will send updated patches.

Cheers,
Lukasz
