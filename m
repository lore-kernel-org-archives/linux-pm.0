From: Jan Dittmer <jdi@l4x.org>
Subject: Re: [linux-pm] Suspend to RAM, Sony Vaio PCG-SRX51P, lcd stays off
Date: Fri, 16 Feb 2007 08:10:14 +0100
Message-ID: <45D558D6.3050303@l4x.org>
References: <45D43489.3060409@l4x.org> <20070215103639.GB27338@elf.ucw.cz> <37556.85.47.20.193.1171540572.squirrel@picard.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <37556.85.47.20.193.1171540572.squirrel@picard.linux.it>
Sender: linux-acpi-owner@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Pavel Machek <pavel@ucw.cz>, stelian@popies.net, linux-acpi@vger.kernel.org, linux-pm@osdl.org, adaplas@pol.net, dawes@xfree86.org, Linux kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Mattia Dongili wrote:
> On Thu, February 15, 2007 11:36 am, Pavel Machek said:

>>>     sys_vendor   = "Sony Corporation    "
>>>     sys_product  = "PCG-SRX51P(DE)      "
>>>     sys_version  = "01                  "
>>>     bios_version = "R0232U2"
>>>

> (unrelated to your suspend problems) does the sony-laptop (formerly
> sony_acpi) module helps controlling brightness?
> (should appear soon or you can eventually grab it from the linux-acpi tree)

No, I use the sonypi driver. But I can test the sony-laptop one as
soon as it is in -mm again if it would be of any help.

>>> Latest kernel I tested is 2.6.20-git11 from today.
> 
> I read reports of successful suspends on that laptop, eg:
> http://freenet-homepage.de/obauer/index.html

Ok, now I feel totally dumb. 's2ram -s -f' actually works iff you disable
fb support completely in the kernel. It works even from X. Don't know how
many combinations I tried but that one somehow slipped through. Anyway
thanks for your help. So could this machine be added to the s2ram
database?

Thanks,

Jan
