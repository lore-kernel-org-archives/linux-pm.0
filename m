From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 084/123] USB: fix up suspend and resume for
 PCI host controllers
Date: Sat, 17 Jan 2009 09:28:02 +1100
Message-ID: <1232144882.23611.2.camel__10232.0249229253$1232145044$gmane$org@pasglop>
References: <Pine.LNX.4.44L0.0901161039530.2417-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0901161039530.2417-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


> Ben, we need to check with you on this also.  These patches we have
> been throwing around move the code to disable and enable the PPC_PMAC
> ASIC clocks for USB.  Can that code execute safely at any time while
> the host controller isn't running?  Is it okay to execute the code
> with interrupts disabled?

Wow, that's digging old stuff I haven't touched for some time :-)

So I think running the pmac hooks with IRQs off might be ok. They have
delays but they use mdelay() not msleep().

As to when it is safe to run that code, it isn't a trivial answer. I'd
say any time after it's been suspended and before it's resumed sounds
about right, but my experience with those earlier Apple built-in OHCIs
is that they are -very- sensitive to random environmental conditions
when suspending/resuming and if -anything- goes wrong, they start
happily scribbling all over system memory when suspended :-(

So I think it's going to boil down to testing. Might be useful to find
somebody with one of the really old powerbooks, I see if I can find that
around the lab here, mine is dead.

Do you have a git tree I can pull to test your stuff ?

Cheers,
Ben.
