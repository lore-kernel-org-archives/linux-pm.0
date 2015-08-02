From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86, acpi: Handle lapic/x2apic entries in MADT
Date: Sun, 2 Aug 2015 11:57:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508021154170.3825@nanos>
References: <alpine.DEB.2.11.1507211017590.18576 () nanos> <1438278219-26487-1-git-send-email-lukasz.anaczkowski@intel.com> <1438278219-26487-2-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1438278219-26487-2-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Cc: mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jason Cooper <jason@lakedaemon.net>, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 30 Jul 2015, Lukasz Anaczkowski wrote:
> Also, order in which MADT LAPIC/X2APIC handlers are passed is
> reversed to achieve correct CPU enumeration.

Ok. That is an understandable changelog and the patch itself looks
about correct, but I leave that judgement to the ACPI experts.

This also wants an ack/review from Marc for the GIC part.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
