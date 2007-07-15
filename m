From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [OT] low-power x86 platform with supported pm
	recommendadtion
Date: Mon, 16 Jul 2007 00:27:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0707160016560.3914@poirot.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
List-Id: linux-pm@vger.kernel.org

Hi

Could someone, please, recommend a x86 platform with a low power 
consumption and well supported under Linux power modes (str), CPU 
frequency scaling, rtc wakeup. I am thinking about a small system like a 
mini-ITX form-factor or a shuttle style barebone with a VIA / AMD Geode / 
Intel Pentium M / (other?) CPU around 1GHz, that should, when inactive, 
e.g., at night, periodically perform some action, like collect mail from a 
POP3 provider, filter and sort it, set rtc for the next wake-up time, and 
go into a lower-power mode... Also, when active, it should consume little 
power, preferrably dynamically switch CPU clock... I need USB 2.0, SATA, 
gigabit LAN (better 2 LANs, at least one of which should be 1Gb/s), PCI or 
PCIe... Just a CPU recommendation would be great, an ITX board / barebone 
suggestion would be even more welcome.

Thanks
Guennadi
---
Guennadi Liakhovetski
