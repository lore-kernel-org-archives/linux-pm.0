From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
 hibernation patchset against -rc6)
Date: Wed, 19 Mar 2008 07:47:06 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803190742450.3020@woody.linux-foundation.org>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
	<20080318130642.GA1609@elf.ucw.cz>
	<20080318130710.GB1609@elf.ucw.cz>
	<alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
	<20080318225201.GA2115@elf.ucw.cz>
	<alpine.LFD.1.00.0803181736340.3020@woody.linux-foundation.org>
	<20080319114851.GB21270@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080319114851.GB21270@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org



On Wed, 19 Mar 2008, Pavel Machek wrote:
> 
> Ok, 7c0... is innocent. Reverting not only the mdelay, but also rest
> of drivers/acpi/ec.c patch fixed the
> "rc6-breaks-backlight-in-X-over-lid-close", good.

Can you clarify a bit?

Do you mean that the full revert of 2c81ce4 that already got committed is 
sufficient for you, or do you need to totally undo everything we've done 
to ec.c since -rc5, and thus also to revert the _other_ revert we did (in 
4af8e10a6c57e7292862bd1703712f0565c7e429)?

In other words, what does "rest of drivers/acpi/ec.c patch" mean? Does it 
mean just the IRQ storm patch, or does it mean everything that happened in 
drivers/acpi/ec.c since 2.6.25-rc5?

			Linus
