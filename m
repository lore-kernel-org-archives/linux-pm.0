From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [GIT PULL] Power management and ACPI fixes for v3.10-rc5
Date: Fri, 7 Jun 2013 15:23:44 -0700
Message-ID: <CA+8MBb+NAHvTCc-NMz4+HqkDc=VUWJ8gDz7ji=HtFiDbcpWo4Q@mail.gmail.com>
References: <3863425.93Oeg2bhJF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3863425.93Oeg2bhJF@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 7, 2013 at 5:51 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Aaron Lu (1):
>       ACPI / scan: do not match drivers against objects having scan handlers

This patch showed up in linux-next tag next-20130605 and appears to be the
cause of a boot failure on my ia64 HP rx2600 system.  It panics with
the message:

Kernel panic - not syncing: Unable to find SBA IOMMU: Try a generic or
DIG kernel

Reverting this from next-20130605 fixes my problem and I can boot again.

So please don't pull.

-Tony
