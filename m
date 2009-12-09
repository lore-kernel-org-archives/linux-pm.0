From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 09:19:46 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912090914330.3560__39094.6217267357$1260379256$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091204550.4120-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912091204550.4120-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 9 Dec 2009, Alan Stern wrote:
> 
> If audio _is_ being played when a suspend occurs, users probably don't 
> mind audible artifacts.  In fact, they probably expect some.

I'd say it's physically impossible not to get them. If you're really 
suspending your audio hardware, it _will_ be quiet ;)

I suspect somebody is draining existing queues or something, or just 
probing for an external analog part. Neither of which is really sensible 
or absolutely required in an embedded suspend/resume kind of situation.

Especially for STR, just "leave all the data structures around, and just 
stop the DMA engine" is often a perfectly fine solution - but drivers 
don't do it, exactly because we've often had the mentality that you 
re-initialize everything under the sun.

I can see _why_ a driver would do that ("we re-use the same code that we 
use on close/open or module unload/reload"), but it doesn't change the 
fact that it's stupid to do if you worry about latency. 

And yeah, turning it async might hide the problem. But the code word there 
is "hide" rather than "fix".

			Linus
