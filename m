From: "Yuval Dafni" <yuvald@slydetech.com>
Subject: FW: resume from suspended state with firewire
Date: Tue, 25 Sep 2007 17:07:19 +0200
Message-ID: <6954FEB9E3130645ABAFEE8D5E2C7C141FE8D0__40578.0058856637$1190732926$gmane$org@slydesvr.Slyde.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux1394-user@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org



-----Original Message-----
From: Yuval Dafni 
Sent: Tuesday, September 25, 2007 4:46 PM
To: 'Stefan Richter'
Subject: RE: resume from suspended state with firewire

Hi, 
Not a question this time, just some conclusions:
In ohci1394.c I replaced #ifdef CONFIG_PM with #if 0, thus disabling
suspend and resume. The result was immediate: the system went to sleep
 (using "echo standby > /sys/power/state")  
And woke up because of a bus reset or an  iso packet.
Apparently, this feature is already supported by the cards
firmware/hardware,  and all I had to do is let it be...

Of course my card will consume power this way, and perhaps there is a
way 
To program ohci1394.c in a smarter way, but that's beyond me for now.
Thanks,
Yuval Dafni.
 

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
