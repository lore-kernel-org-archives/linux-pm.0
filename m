From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] Asynchronous suspend/resume - test results
Date: Thu, 24 Dec 2009 23:10:42 +0100
Message-ID: <200912242310.42615.rjw__43498.2889834375$1261692691$gmane$org@sisk.pl>
References: <200912210140.19713.rjw@sisk.pl> <200912232146.29339.rjw@sisk.pl>
	<4B32D2D6.3030707@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B32D2D6.3030707@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: Jiri Slaby <jslaby@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 24 December 2009, Nigel Cunningham wrote:
> Hi.

Hi, 

> I built the async branch of your tree and tested it, also running
> 2.6.33-rc1 + TuxOnIce for comparison. Dmesg for both are attached. Is
> there anything I can/should be doing for you on top of this?

No, thanks a lot.

> I'll try Dmitry's patch on top of this a little later - other things to do first.

No need for that, the patchset contains an equivalent of the Dmitry's patch.

> I noticed that you were doing standard deviations in your stats - how
> many runs were you basing them on?

I usually run 10 iterations of suspend-resume for each configuration.
The raw data are at http://www.sisk.pl/kernel/data/async-suspend-updated.pdf
if you're interested.

> Not sure that I can be bothered to do too many - too much else to do!

Sure, thanks a lot anyway.  Your data confirn that there's a measurable gain
from suspending and resuming devices asynchronously.

Have a merry Christmas and happy new year,
Rafael
