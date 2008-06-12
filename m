From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.26-rc5
Date: Thu, 12 Jun 2008 07:31:47 +0200
Message-ID: <19f34abd0806112231m69bd521fgbce3c5f8dd413423@mail.gmail.com>
References: <alpine.LFD.1.10.0806111942510.12191@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0806111942510.12191@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linux Power Management List <linux-pm@lists.osdl.org>, Lin Ming <ming.m.lin@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Jun 12, 2008 at 1:44 AM, Len Brown <lenb@kernel.org> wrote:
> please pull from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
>
> This will update the files shown below.

What about the "ACPICA: Fixes for Unload and DDBHandles" patch?

http://bugzilla.kernel.org/show_bug.cgi?id=10669

The patch was reverted in mainline, but is now fixed, shouldn't it be
brought back at some point? It's (still) listed as a regression,
anyway.


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
