From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git mv (was Re: [git pull] ACPI & Suspend patches for
 2.6.29-rc0)
Date: Fri, 9 Jan 2009 13:40:32 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901091339270.6528@localhost.localdomain>
References: <alpine.LFD.2.00.0901090550590.4091@localhost.localdomain> <alpine.LFD.2.00.0901091200150.6528@localhost.localdomain> <alpine.LFD.2.00.0901091537530.16697@localhost.localdomain> <alpine.LFD.2.00.0901091305160.6528@localhost.localdomain>
 <20090109212757.GA25434@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20090109212757.GA25434@uranus.ravnborg.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org



On Fri, 9 Jan 2009, Sam Ravnborg wrote:
> 
> What other ways exist so I can see what the heck davem did to
> arch/sparc64/kernel/irq.c then?

Sure, use "git log --follow".

I'm just saying that you can't expect the rest of the git powertools to 
print pretty histories.. In particular, none of the graphical tools will 
give you that nice merge history stuff - because the way "--follow" works, 
we simply don't do that.

		Linus
