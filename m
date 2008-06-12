From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.26-rc5
Date: Wed, 11 Jun 2008 17:24:48 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806111718240.3101@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806111942510.12191@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0806111942510.12191@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 11 Jun 2008, Len Brown wrote:
> 
>  27 files changed, 255 insertions(+), 180 deletions(-)

Hmm. I get very different statistics:

 27 files changed, 434 insertions(+), 359 deletions(-)

You seem to use "git diff -w" to ignore whitespace changes, which explains 
it, but please don't - it makes it harder to compare with expected 
results, and it hides some changes entirely.

I do agree that using '-w' is often useful, but especially for the purpose 
of letting people know what changed it kind of avoids the point by hiding 
many things.

		Linus
