From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] MAINTAINERS: Add bug tracking system location entry type
Date: Tue, 29 Nov 2016 01:29:39 +0100
Message-ID: <64389207.3gWh3pGNj9@aspire.rjw.lan>
References: <2170547.PZqCrC6KTi@vostro.rjw.lan> <20161128172708.0e69857e@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161128172708.0e69857e@lwn.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Laura Abbott <labbott@redhat.com>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, James Bottomley <jejb@kernel.org>, Theodore Tso <tytso@google.com>
List-Id: linux-pm@vger.kernel.org

On Monday, November 28, 2016 05:27:08 PM Jonathan Corbet wrote:
> On Fri, 25 Nov 2016 00:13:56 +0100
> 
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> > Following the kernel Bugzilla discussion during the Kernel Summit
> > (https://lwn.net/Articles/705245/), add bug tracking system location
> > entry type (B) to MAINTAINERS and populate it for several subsystems
> > known to be using the kernel BZ actively (and add the upstream BZ for
> > ACPICA too).
> 
> Applied to the docs tree, thanks.

Linus applied it too:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=686564434e88b67ea8dbbf9150286d04c83bd193

> (We are accumulating a pretty big mess of field types in that file,
> though; at some point we need to think about how much more stuff we want
> to try to cram in there.)

Well, I see your point, but this particular thing was agreed on before.

Thanks,
Rafael

