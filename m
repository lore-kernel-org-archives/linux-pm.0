From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: resume from suspended state with firewire
Date: Thu, 20 Sep 2007 17:32:31 +0200
Message-ID: <46F2928F.1000104__34930.9456687935$1190302433$gmane$org@s5r6.in-berlin.de>
References: <465F5EBCEEBD4DC7BE325B4E55B88E20.MAI@mail.livedns.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <465F5EBCEEBD4DC7BE325B4E55B88E20.MAI@mail.livedns.co.il>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Yuval Dafni <yuval.d@slyde-tech.com>
Cc: linux-pm@lists.linux-foundation.org, linux1394-user@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

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
