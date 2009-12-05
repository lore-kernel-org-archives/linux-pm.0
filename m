From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sat, 5 Dec 2009 13:43:43 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912051334461.3649__49434.516268275$1260049479$gmane$org@localhost.localdomain>
References: <200912052216.19540.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912052216.19540.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On Sat, 5 Dec 2009, Rafael J. Wysocki wrote:
> 
> * Asynchronous suspend and resume infrastructure.  For now, PCI, ACPI and
>   serio devices are enabled to suspend and resume asynchronously.

I really think this is totally and utterly broken. Both from an 
implementation standpoint _and_ from a pure conceptual one.

Why isn't the suspend/resume async stuff just done like the init async 
stuff?

We don't need that crazy per-device flag for initialization, neither do we 
need drivers "enabling" any async code at all. They just do some things 
asynchronously, and then at the end of init time we wait for all those 
async events.

So why does suspend/resume need to do crazy sh*t instead?

It all looks terminally broken: you force async suspend for all PCI 
drivers, even when it makes no sense. Rather than let the drivers that 
already know how to do things like disk spinup asynchronously just do it 
that way.

The "timing" routines are also just crazy. What is the excuse for 
dpm_show_time() taking both start and stop times, since there is never any 
valid situation when it shouldn't have that do_gettimgofday(&stop) just 
before it? IOW - the whole end-time thing should be _inside_ 
dpm_show_time, rather than being done by the caller. No?

In other words - I'm not pulling this crazy thing. You'd better explain 
why it was done that way, when we already have done the same things better 
before in different ways.

				Linus
