From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 04:01:26 +0100
Message-ID: <20061101030126.GE27968@stusta.de>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061030135625.GB1601@mellanox.co.il>
Sender: linux-acpi-owner@vger.kernel.org
To: Hugh Dickins <hugh@veritas.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org, Martin Lorenz <martin@lorenz.eu.org>
List-Id: linux-pm@vger.kernel.org

FYI:

Subject    : Thinkpad R50p: boot fail with (lapic && on_battery)
References : http://lkml.org/lkml/2006/10/31/333
Submitter  : Ernst Herzberg <earny@net4u.de>
Status     : submitter was asked to bisect

It seems to be completely unrelated (except that it's also a ThinkPad), 
but it might be worth a try whether a (non-SMP) kernel without APIC 
support fixes the issues after resume.

Hugh, your laptop seems to be a non-SMP laptop.
Do you have APIC enabled, and if yes does disabling help?

cu
Adrian


VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 19
EXTRAVERSION = -rc4
NAME=ThinkPad Killer

