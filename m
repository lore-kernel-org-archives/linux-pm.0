From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.22-rc3 hibernate(?) fails totally - regression
Date: Sat, 2 Jun 2007 01:22:49 +0200
Message-ID: <200706020122.49989.rjw@sisk.pl>
References: <46608E3F.4060201@dgreaves.com> <200706012342.45657.rjw@sisk.pl>
	<46609FAD.7010203@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46609FAD.7010203@dgreaves.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Greaves <david@dgreaves.com>
Cc: netdev@oss.sgi.com, linux-pm <linux-pm@lists.osdl.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 2 June 2007 00:37, David Greaves wrote:
> Rafael J. Wysocki wrote:
> > On Friday, 1 June 2007 23:23, David Greaves wrote:
> >> Not a regression though, it does it in 2.6.21
> >>
> >> If I cause the system to save state to disk then whilst off it no longer
> >> responds to g-wol.
> > 
> > Can you please try with the hibernation and suspend patch series from
> > 
> > http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc3/patches/
> > 
> > applied?
> > 
> > Greetings,
> > Rafael
> > 
> 
> Sorry I made a mistake in the report.
> I was still booting 2.6.21.1 - very sorry :(
> 
> The real situation is worse :(

Ouch.
 
> 2.6.22-rc3 (no patches) just hangs on suspend at:
> Suspending consoles
> 
> console switching works but needs a hard reset to reboot.
> 
> 2.6.22-rc3-skge (with Rafael's patches)
> suspends to disk and powers off
> wol doesn't work incidentally
> resume resumes to the exact same place that 2.6.22-rc3 hangs at...
> ie a non-responsive system saying
> Suspending consoles
> 
> Note, in both cases I can switch VTs, the caps/numlock lights respond.

Can you set CONFIG_DISABLE_CONSOLE_SUSPEND in .config and see where exactly it
fails?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
