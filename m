From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Tying sysfs "wakeup" file to
	platform-level?handler
Date: Tue, 25 Nov 2008 16:07:47 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811251558360.3526-100000@iolanthe.rowland.org>
References: <20081125203837.GA5449@trantor.hsd1.or.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081125203837.GA5449@trantor.hsd1.or.comcast.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, Andres Salomon <dilinger@queued.net>
List-Id: linux-pm@vger.kernel.org

On Tue, 25 Nov 2008, Deepak Saxena wrote:

> > Suppose the same sort of WLAN interface was packaged as an independent,
> > external USB device and one of them was plugged into an OLPC.  Then how
> > would you know which device was the one attached to the embedded
> > controller and which was external?
> 
> I think in that case we couldn't really do WOL. I imagine this is the
> case on a standard laptop too.

On a standard laptop the WLAN interface would be a PCI device, so it
could use the standard PCI wakeup method (PME#).  Or the motherboard
manufacturer could use vendor-specific signalling.  But you're not
likely to find an onboard WLAN interface communicating with the CPU via
USB.

In this particular case, can't you set it up so that the EC always pays
attention to the WLAN's GPIO line, but the WLAN interface enables the
GPIO for wakeup signalling only if power/wakeup is set?

> On future XO versions, we may move to
> an SDIO based card and we will have to deal with the same situation
> where the SDIO stack has a concept of wake up on card insert/remove
> but we will need to route the WOL signal from the card to the EC.

It sounds like the same sort of problem: a device on a different bus 
that has to talk to the platform's EC.

Alan Stern
