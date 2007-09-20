From: "Yuval Dafni" <yuvald@slydetech.com>
Subject: RE: resume from suspended state with firewire
Date: Thu, 20 Sep 2007 17:45:18 +0200
Message-ID: <6954FEB9E3130645ABAFEE8D5E2C7C141FE8CA__45313.0697868348$1190303856$gmane$org@slydesvr.Slyde.local>
References: <46F2928F.1000104@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <46F2928F.1000104@s5r6.in-berlin.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux1394-user@lists.sourceforge.net
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Thanks, 
I don't know yet, I'm new to power management.
I do know that PCI cards have a signal called PME by which they may
change the power state of the system, but I'm not sure how this is
helpful in my case. I'm also not sure yet how all this relates to the
different power states d1,d2,d3 and their implementation on PowerPc.

Since I'm not going to re-write ohci1394, I might try to keep the card
alive,  hook on to one of the data pins and make it wake my cpu when a
packet arrives. In this case, I'm wondering how many packets I'm going
to loose by the time I wake up :-) ...

Yuval.


-----Original Message-----
From: linux1394-user-bounces@lists.sourceforge.net
[mailto:linux1394-user-bounces@lists.sourceforge.net] On Behalf Of
Stefan Richter
Sent: Thursday, September 20, 2007 5:33 PM
To: Yuval Dafni
Cc: linux-pm@lists.linux-foundation.org;
linux1394-user@lists.sourceforge.net
Subject: Re: resume from suspended state with firewire

(Adding Cc: linux-pm)

Yuval Dafni wrote:
> Can I make a suspended linux machine resume because of a 1394 packet?

It's not possible, at least in the current implementation of ohci1394
and firewire-ohci.  All interrupt events are disabled and the link layer
controller is powered down when the machine enters suspended mode.  I
don't know if it is possible for PCI drivers to leave interrupts and
receive DMA contexts etc. enabled and wake the machine up when an
interrupt event occurs.

Does wake-on-LAN (Ethernet) and wake-on-USB work by means of special
hardware support?
-- 
Stefan Richter
-=====-=-=== =--= =-=--
http://arcgraph.de/sr/

------------------------------------------------------------------------
-
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
mailing list Linux1394-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux1394-user
