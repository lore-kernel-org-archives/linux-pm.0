From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [Regression] firewire_ohci causes system resume to
	fail
Date: Fri, 17 Dec 2010 21:38:38 +0100
Message-ID: <20101217213838.76db3710__6230.98854343898$1292619230$gmane$org@stein>
References: <201012051542.31826.rjw@sisk.pl> <20101205161758.2d75c65d@stein>
	<20101205170947.6b4e2d09@stein> <201012170047.56309.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012170047.56309.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Dec 17 Rafael J. Wysocki wrote:
> On Sunday, December 05, 2010, Stefan Richter wrote:
> > On Dec 05 Stefan Richter wrote:
> > > On Dec 05 Rafael J. Wysocki wrote:
> > > > There is a regression I can reproduce 100% of the time on a AMD-based desktop
> > > > box that resume from hibernation (or suspend) fails because of the firewire_ohci
> > > > module.  The box just hangs when firewire_ohci resume runs, apparently, and it
> > > > is sufficient to do:
> > > > 
> > > > # echo devices > /sys/power/pm_test
> > > > # echo disk > /sys/power/state
> > > > 
> > > > to reproduce the issue.
> > > 
> > > Do you have anything attached to the FireWire bus?  What controller do
> > > you have?
> > 
> > I just now tested the above on an Intel Mac mini, running
> > unmodified 2.6.37-rc4 x86-32, without and with a camera on the FireWire
> > port, and could not reproduce the problem.  I also got an AMD based PC
> > here with an array of different FireWire controllers which I shall make
> > available to the same test...
> 
> I'm unable to reproduce the problem with 2.6.37-rc6, so presumably this was
> a temporary glitch with the particular kernel build.

Good.

I finally got around to test this on my AMD RS780 based PC with several
FireWire controllers in it.  It performs above PM test without any
apparent problem.
-- 
Stefan Richter
-=====-==-=- ==-- =---=
http://arcgraph.de/sr/
