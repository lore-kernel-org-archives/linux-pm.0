From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] PCI / PM: Make PCIe PME interrupts wake up from "freeze"
 sleep state
Date: Thu, 24 Jul 2014 19:13:20 +0200
Message-ID: <20140724171320.GL3935@laptop>
References: <12684812.i3F8JrYCl0@vostro.rjw.lan>
 <20140724134241.GZ6758@twins.programming.kicks-ass.net>
 <3655886.Ih7L6voqVK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3655886.Ih7L6voqVK@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 24, 2014 at 05:36:28PM +0200, Rafael J. Wysocki wrote:

> OK, so can you please test the updated patch below?

Rejoyce, it works! ;-)
