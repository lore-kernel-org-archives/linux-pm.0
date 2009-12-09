From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 08:57:32 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912090851540.3560__32758.6509789855$1260378244$gmane$org@localhost.localdomain>
References: <20091209160256.GA3229@rakim.wolfsonmicro.main>
	<Pine.LNX.4.44L0.0912091117080.4120-100000@iolanthe.rowland.org>
	<20091209164653.GI9018@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091209164653.GI9018@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 9 Dec 2009, Mark Brown wrote:

> > How long does it take to bring down the entire embedded audio 
> > subsystem?  And how critical is the timing for typical systems?
> 
> Worst case is about a second for both resume and suspend which means two
> seconds total but it's very hardware dependant.  

I would seriously suggest just looking at the code itself.

Maybe the code is just plain sh*t? If we're talking embedded audio, we're 
generally talking SoC chips (maybe some external audio daughtercard), and 
quite frankly, it sounds to me like you're just wasting your own time. 
There is no way that kind of hardware really needs that much time.

We should not design the device infrastructure for crap coding. 

Now, I can easily see one-second delays in code that simply has never been 
thought about or cared about it. We used to have things like that in the 
serial code where just probing for non-existent serial ports took half a 
second per port because there was a timeout. 

But christ, using that as an argument for "we should do things 
asynchronously" sounds like a crazy idea. Why not just take a hard look at 
the driver in question, asking hard questions like "does it really need to 
do something horrible like that"?

Because bad coding is much more likely to be the real reason.

			Linus
