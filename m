From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.26-rc5
Date: Wed, 11 Jun 2008 23:08:17 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806112301570.12191@localhost.localdomain>
References: <alpine.LFD.1.10.0806111942510.12191@localhost.localdomain>
 <alpine.LFD.1.10.0806111718240.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <alpine.LFD.1.10.0806111718240.3101@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org



> >  27 files changed, 255 insertions(+), 180 deletions(-)
> 
> Hmm. I get very different statistics:
> 
>  27 files changed, 434 insertions(+), 359 deletions(-)
> 
> You seem to use "git diff -w" to ignore whitespace changes, which explains 
> it, but please don't - it makes it harder to compare with expected 
> results, and it hides some changes entirely.
> 
> I do agree that using '-w' is often useful, but especially for the purpose 
> of letting people know what changed it kind of avoids the point by hiding 
> many things.

Yes, I've been using "-b" recently:

git diff -b -M --stat linus..$RELEASE

and if I remove the "-b", we match:

 27 files changed, 434 insertions(+), 359 deletions(-)

I have a vague memory of having a good reason to cut over to "-b"
a while back and noting that in my pull request, but if you prefer
no -b, no problem.

thanks,
-Len
