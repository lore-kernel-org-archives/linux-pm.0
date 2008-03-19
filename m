From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
 hibernation patchset against -rc6)
Date: Tue, 18 Mar 2008 17:40:38 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803181736340.3020@woody.linux-foundation.org>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
	<20080318130642.GA1609@elf.ucw.cz>
	<20080318130710.GB1609@elf.ucw.cz>
	<alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
	<20080318225201.GA2115@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080318225201.GA2115@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org



On Tue, 18 Mar 2008, Pavel Machek wrote:
> 
> It will take a while. My .git directory is 7G, and I'd like to do a
> backup before playing with git.

Ouch, what have you done? It should be about 200MB, not 7GB.

> git gc does not exist here, so I guess I need to update git, too :-(.

Well, even with old git you can just do 

	git repack -a -d

and in your case you'll probably have to leave it running overnight, 
because it's going to take hours since you've clearly not ever repacked it 
before and as a result it's going to do lots and lots of IO (all that 7GB 
and then read much of it twice).

But yeah, upgrading git first is probably a good idea regardless.

> commit 7c0ea45be4f114d85ee35caeead8e1660699c46f
> 
>     ACPI: Ignore _BQC object when registering backlight device
> 
> when did this go in? Pretty recently, right?

Yes:

	[torvalds@woody linux]$ git describe 7c0ea45be4f114d85ee35caeead8e1660699c46f
	v2.6.25-rc5-89-g7c0ea45

so it happened after -rc5.

> And that means that ACPI backlight driver is now used on machines where 
> it was not used before...?

Somebody more into ACPI needs to judge how likely this is to be an issue..

		Linus
