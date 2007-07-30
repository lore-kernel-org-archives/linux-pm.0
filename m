From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] Introduce CONFIG_HIBERNATION and
 CONFIG_SUSPEND (updated)
Date: Sun, 29 Jul 2007 17:21:22 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707291717410.3442@woody.linux-foundation.org>
References: <200707251238.50218.lenb@kernel.org>
	<alpine.LFD.0.999.0707281130110.3442@woody.linux-foundation.org>
	<200707291220.14880.rjw@sisk.pl> <200707292323.29601.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707292323.29601.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



Ok, I took this, and modified Len's patch to re-introduce ACPI_SLEEP on 
top of it (I took the easy way out, and just made PM_SLEEP imply 
ACPI_SLEEP, which should make everything come out right. I could have 
dropped ACPI_SLEEP entirely in favour of PM_SLEEP, but that would have 
implied changing more of Len's patch than I was really comfy with).

Len, Rafael, please do check that the end result looks ok. 

I suspect ACPI could now take the PM_SLEEP/SUSPEND/HIBERNATE details into 
account, and that some of the code is not necessary when HIBERNATE is not 
selected, for example, but I'm not at all sure that it's worth it being 
very fine-grained.

		Linus
