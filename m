From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: Re: [PATCH] x86, acpi: Handle xapic/x2apic entries in MADT
Date: Thu, 30 Jul 2015 19:43:38 +0200
Message-ID: <1438278219-26487-1-git-send-email-lukasz.anaczkowski@intel.com>
References: <alpine.DEB.2.11.1507211017590.18576 () nanos>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1507211017590.18576 () nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> Please add proper explanations why the array parser is required and
> why the parse order needs to be reverse.

Thanks for comments.
I'm sending patch with reworked commit message. I hope that at least
some of the doubts are cleaner now.

Cheers,
Lukasz
