From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Sat, 19 Dec 2009 15:46:04 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912191542570.3712__16549.506240017$1261266424$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912200010.19899.rjw@sisk.pl>
	<alpine.LFD.2.00.0912191521180.3712@localhost.localdomain>
	<200912200040.18944.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912200040.18944.rjw@sisk.pl>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 20 Dec 2009, Rafael J. Wysocki wrote:
> 
> OK, so this means we can just forget about suspending/resuming i8042
> asynchronously, which is a pity, because that gave us some real suspend
> speedup on my test systems.

No. What it means is that you shouldn't try to come up with these idiotic 
scenarios just trying to make trouble for yourself, and using it as an 
excuse for crap.

I suggest you try to treat the i8042 controller async, and see if it is 
problematic. If it isn't, don't do that then. But we actually have no real 
reason to believe that it would be problematic, at least on a PC where the 
actual logic is on the SB (presumably behind the LPC controller).

Why would it be?

The fact that PnP and ACPI enumerates those devices has exactly _what_ to 
do with anything?

		Linus
