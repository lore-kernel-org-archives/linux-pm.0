From: Ernst Herzberg <earny@net4u.de>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 06:11:27 +0100
Message-ID: <200611010611.30445.earny@net4u.de>
References: <20061029231358.GI27968@stusta.de> <20061101030126.GE27968@stusta.de> <200610312215.44454.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200610312215.44454.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Adrian Bunk <bunk@stusta.de>, Hugh Dickins <hugh@veritas.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-pm@osdl.org, Martin Lorenz <martin@lorenz.eu.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 01 November 2006 04:15, Len Brown wrote:
> The BIOS disables the LAPIC for a reason.
> A couple of years ago Linux made the mistake of enabling the LAPIC
> that the BIOS disabled, and all hell broke loose.
> We fixed that bug about a year ago, but left "lapic"
> to force it on for those where forcing it to be enabled actually
> works (eg. some folks want the NMI profiling on their IOAPIC-less  laptop)
>
> But if you force the lapic to be enabled, you are running the system
> in a mode not supported by the manufacturer and you are on your own.
>
> I don't see an indication that this is a bug.
> If it used to work and it is important to you,
>  then run the old software where it used to work --
> because chances are good that it worked by accident.

Maybe. But why does it boot with AC connected and lapic enabled, bot not if AC 
is disconnected and lapic enabled? If have no problem to run this laptop 
without lapic, i don't relly need it. But i wondering that this happens only 
if the machine runs (by accident:) on battery.

still bisecting, will report the result.

<earny>
