From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: Re: [PATCH] x86, acpi: Handle lapic/x2apic entries in MADT
Date: Mon,  3 Aug 2015 20:26:04 +0200
Message-ID: <1438626365-23709-1-git-send-email-lukasz.anaczkowski@intel.com>
References: <20150802134014.380415cd@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150802134014.380415cd@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Marc,

> You haven't ever tried compiling this, have you?

I *thought* I tried, but obviously I did it wrong.
This time I made sure it compiles. Thanks for poiting
this out.

Sending v2 of the patch with fixed arm64 compilation.

Cheers,
Lukasz
