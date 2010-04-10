From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.31 regression: programs crashing after a couple
	of days of uptime with hibernation
Date: Sat, 10 Apr 2010 21:58:17 +0200
Message-ID: <201004102158.17454.rjw__45554.9331418753$1270929348$gmane$org@sisk.pl>
References: <201004012332.49454.linux@rainbow-software.org>
	<201004021858.28611.rjw@sisk.pl>
	<201004101103.21380.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004101103.21380.linux@rainbow-software.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday 10 April 2010, Ondrej Zary wrote:
> On Friday 02 April 2010 18:58:28 Rafael J. Wysocki wrote:
> > On Friday 02 April 2010, Ondrej Zary wrote:
> > > On Friday 02 April 2010 00:33:55 Rafael J. Wysocki wrote:
> > > > On Friday 02 April 2010, Ondrej Zary wrote:
> > > > > On Thursday 01 April 2010 23:45:33 you wrote:
> > > > > > On Thursday 01 April 2010, Ondrej Zary wrote:
> > > > > > > Hello,
> > > > > > > with kernel 2.6.30, I can have uptime of more than a month on my
> > > > > > > desktop PC (with hibernation). It's impossible with 2.6.31. After
> > > > > > > 1 to 3 days, processes that were running during hibernation (e.g.
> > > > > > > konsole, kwin, kicker, xorg) start to crash randomly in very
> > > > > > > weird ways. The kernel itself does not seem to crash. When I run
> > > > > > > the crashed program again, it seems to work. Looks like some
> > > > > > > memory corruption.
> > > > > > >
> > > > > > > This bug is also present in 2.6.32 and 2.6.33.
> > > > > >
> > > > > > Is the kernel 32-bit or 64-bit?  What kind of CPU is there in the
> > > > > > box?
> > > > >
> > > > > It's old 32-bit i686 CPU - Cyrix MII.
> > > >
> > > > Please try with this patch applied:
> > > > http://git.kernel.org/?p=linux/kernel/git/mingo/linux-2.6-x86.git;a=pat
> > > >ch;h =8ae06d223f8203c72104e5c0c4ee49a000aedb42
> > >
> > > Thanks, I'll try it. But I doubt that it will fix the problem. There were
> > > no changes in hibernate_asm_32.S between 2.6.30 and 2.6.31.
> >
> > The change that exposed this issue was elsewhere in the x86 arch code.  I
> > don't know where exactly, but we surely didn't need the above patch before.
> 
> It did not help. It started crashing with 2.6.32 and this patch applied after 
> two days.

Well, no idea, then.

Rafael
