From: Eric Sesterhenn <snakebyte@gmx.de>
Subject: Re: Suspend regression, hang after matroxfb
Date: Sat, 31 Jan 2009 00:36:53 +0100
Message-ID: <20090130233653.GA13875__47882.3901307352$1233358781$gmane$org@alice>
References: <20090129125855.GA4597@alice> <200901302327.50887.rjw@sisk.pl>
	<20090130223144.GD13207@alice> <200901302359.18309.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200901302359.18309.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Kernel Testers <kernel-testers@vger.kernel.org>, vandrove@vc.cvut.cz
List-Id: linux-pm@vger.kernel.org

* Rafael J. Wysocki (rjw@sisk.pl) wrote:
> On Friday 30 January 2009, Eric Sesterhenn wrote:
> > * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > > On Friday 30 January 2009, Eric Sesterhenn wrote:
> > > > * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > > > > On Friday 30 January 2009, Eric Sesterhenn wrote:
> > > > > > * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > > > > > > On Thursday 29 January 2009, Eric Sesterhenn wrote:
> > > > > > > > hi,
> > > > > > > > 
> > > > > > > > on this box standby worked with 2.6.28, but is broken with 2.6.29-rc3.
> > > > > > > > 
> > > > > > > > Dmesg of startup
> > > > > > > > http://www.cccmz.de/~snakebyte/200.log
> > > > > > > > .config
> > > > > > > > http://www.cccmz.de/~snakebyte/config_200
> > > > > > > > 
> > > > > > > > When testing the devices 
> > > > > > > > 
> > > > > > > > root@computer-desktop:/sys/power# echo devices > pm_test 
> > > > > > > 
> > > > > > > What happens if you replace 'devices' with 'core' ?
> > > > > > 
> > > > > > no change, it hangs after matroxfb
> > > > > > 
> > > > > > root@computer-desktop:/sys/power# echo core > pm_test 
> > > > > > root@computer-desktop:/sys/power# echo standby > state
> > > > > > 
> > > > > [--snip--]
> > > > > > 
> > > > > > > If the same, what happens without the matroxfb driver?
> > > > > > 
> > > > > > It gets a bit further, suspend seems to complete,
> > > > > > but hangs during resume
> > > > > 
> > > > > Please check if the appended patch helps.
> > > > 
> > > > It does help in both cases (with matroxfb enabled and disabled)
> > > > thanks.
> > > 
> > > What machine is that?
> > 
> > I mean the driver enabled in .config.
> > 
> > box is one of my kernel testgrounds running ubuntu intrepid,
> > for .config and dmesg see the links above
> 
> Ah, so this is just a desktop.  OK, thanks.
> 
> I have prepared a final fix that I'd like to push for merging.  Can you please
> test it (it won't apply cleanly to the current -git, but should be easy to fix
> up)?

works for me, thanks

Eric
