From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI / PM: Fix native PME handling during system suspend/resume
Date: Thu, 13 Jul 2017 01:39:06 +0200
Message-ID: <2061263.Fyvozl4yyQ@aspire.rjw.lan>
References: <2516f96e-bc32-46ac-acc9-8a5e16c44245@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2516f96e-bc32-46ac-acc9-8a5e16c44245@email.android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Solanki, Naresh" <naresh.solanki@intel.com>
Cc: "Rao Pv, Sadashiva" <sadashiva.rao.pv@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 12, 2017 11:32:17 PM Solanki, Naresh wrote:
> Hi Rafael,
> 
> We tested the patch and completed ~400cycles of s3 and s0ix. No regression observed.

Awesome, thanks!
