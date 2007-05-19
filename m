From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: (fwd) empty /sys/power/state?
Date: Sun, 20 May 2007 00:53:58 +0200
Message-ID: <200705200053.58388.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705191714070.32062-100000@netrider.rowland.org>
	<464F6E74.1040607@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <464F6E74.1040607@s5r6.in-berlin.de>
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
To: linux-pm@lists.linux-foundation.org
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
List-Id: linux-pm@vger.kernel.org

On Saturday, 19 May 2007 23:39, Stefan Richter wrote:
> Alan Stern wrote:
> > On Sat, 19 May 2007, Stefan Richter wrote:
> > 
> >> Maybe linux-pm is the more appropriate list for this question:
> >>
> >> I wrote at suspend-devel@lists.sourceforge.net:
> >>> What's wrong here?
> >>>
> >>> # cat /sys/power/state
> >>> # echo mem > /sys/power/state
> >>> -su: echo: write error: No such device
> > 
> >> Thanks for advice,
> > 
> > No doubt other people will be able to give better answers than I.  However 
> > an important first step is to provide the dmesg log showing what happened 
> > when the attempted suspend failed.
> 
> I rebuilt the kernel with PM_DEBUG.
> There is nothing in dmesg after echo mem > /sys/power/state.
> This is also true if I first unload all modular drivers.
> 
> Dmesg and .config attached.

Apparently kernel/power/main.c:valid_state() on your boxes always returns 0.

Can you please try to set CONFIG_SOFTWARE_SUSPEND and see if that helps?

Rafael
