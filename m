From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/2] acpi/x86: Reuse the mp_register_ioapic_irq() in
 the function mp_override_legacy_irq()
Date: Thu, 16 Nov 2017 12:05:18 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711161205020.2191@nanos>
References: <1510824595-12287-1-git-send-email-vikas.cha.sajjan@hpe.com> <1510824595-12287-3-git-send-email-vikas.cha.sajjan@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1510824595-12287-3-git-send-email-vikas.cha.sajjan@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Cc: rjw@rjwysocki.net, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kkamagui@gmail.com, mingo@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 16 Nov 2017, Vikas C Sajjan wrote:

> Modify the function mp_override_legacy_irq() to reuse the newly introduced
> function mp_register_ioapic_irq().

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
