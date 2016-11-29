From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] MAINTAINERS: Add bug tracking system location entry
 type
Date: Mon, 28 Nov 2016 17:27:08 -0700
Message-ID: <20161128172708.0e69857e@lwn.net>
References: <2170547.PZqCrC6KTi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2170547.PZqCrC6KTi@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Laura Abbott <labbott@redhat.com>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, James Bottomley <jejb@kernel.org>, Theodore Tso <tytso@google.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 25 Nov 2016 00:13:56 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> Following the kernel Bugzilla discussion during the Kernel Summit
> (https://lwn.net/Articles/705245/), add bug tracking system location
> entry type (B) to MAINTAINERS and populate it for several subsystems
> known to be using the kernel BZ actively (and add the upstream BZ for
> ACPICA too).

Applied to the docs tree, thanks.

(We are accumulating a pretty big mess of field types in that file,
though; at some point we need to think about how much more stuff we want
to try to cram in there.)

jon
