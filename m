From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend regression, hang after matroxfb
Date: Fri, 30 Jan 2009 23:27:50 +0100
Message-ID: <200901302327.50887.rjw__27928.7338526503$1233354659$gmane$org@sisk.pl>
References: <20090129125855.GA4597@alice> <200901302215.28057.rjw@sisk.pl>
	<20090130220640.GB13207@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090130220640.GB13207@alice>
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
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-pm@lists.linux-foundation.org, Kernel Testers <kernel-testers@vger.kernel.org>, vandrove@vc.cvut.cz
List-Id: linux-pm@vger.kernel.org

On Friday 30 January 2009, Eric Sesterhenn wrote:
> * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > On Friday 30 January 2009, Eric Sesterhenn wrote:
> > > * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > > > On Thursday 29 January 2009, Eric Sesterhenn wrote:
> > > > > hi,
> > > > > 
> > > > > on this box standby worked with 2.6.28, but is broken with 2.6.29-rc3.
> > > > > 
> > > > > Dmesg of startup
> > > > > http://www.cccmz.de/~snakebyte/200.log
> > > > > .config
> > > > > http://www.cccmz.de/~snakebyte/config_200
> > > > > 
> > > > > When testing the devices 
> > > > > 
> > > > > root@computer-desktop:/sys/power# echo devices > pm_test 
> > > > 
> > > > What happens if you replace 'devices' with 'core' ?
> > > 
> > > no change, it hangs after matroxfb
> > > 
> > > root@computer-desktop:/sys/power# echo core > pm_test 
> > > root@computer-desktop:/sys/power# echo standby > state
> > > 
> > [--snip--]
> > > 
> > > > If the same, what happens without the matroxfb driver?
> > > 
> > > It gets a bit further, suspend seems to complete,
> > > but hangs during resume
> > 
> > Please check if the appended patch helps.
> 
> It does help in both cases (with matroxfb enabled and disabled)
> thanks.

What machine is that?

Rafael
