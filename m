From: Mike Galbraith <bitbucket@online.de>
Subject: Re: 50 Watt idle power regression bisected to Linux-3.10
Date: Thu, 12 Dec 2013 07:05:03 +0100
Message-ID: <1386828303.6056.40.camel@marge.simpson.net>
References: <alpine.DEB.2.02.1312111206200.28330@ionos.tec.linutronix.de>
	 <20131211113839.GF21683@pd.tnic>
	 <20131211115239.GA21999@twins.programming.kicks-ass.net>
	 <1386764955.12005.60.camel@marge.simpson.net>
	 <20131211124352.GB21999@twins.programming.kicks-ass.net>
	 <20131211134048.GH21683@pd.tnic> <20131211145655.GB4510@gmail.com>
	 <20131211164318.GA2480@laptop.programming.kicks-ass.net>
	 <20131211175036.GC12431@gmail.com> <52A8F073.9040500@zytor.com>
	 <20131211231425.GD8863@pd.tnic> <52A908DB.60902@zytor.com>
	 <1386822357.6056.12.camel@marge.simpson.net> <52A94065.1050103@zytor.com>
	 <1386826641.6056.31.camel@marge.simpson.net>
	 <6e4b858b-fcad-4231-8351-d2f473bf6ba6@email.android.com>
	 <1386827824.6056.36.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58865 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab3LLGFb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2013 01:05:31 -0500
In-Reply-To: <1386827824.6056.36.camel@marge.simpson.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Eder <jeder@redhat.com>, x86@kernel.org

On Thu, 2013-12-12 at 06:57 +0100, Mike Galbraith wrote: 
> On Wed, 2013-12-11 at 21:45 -0800, H. Peter Anvin wrote: 
> > As in it hangs at that point?
> 
> Nope, it's still going.
> 
> [1567.578340] pcc-cpufreq: (v1.10.00) driver loaded with frequency limits: 1064 MHz, 2266 MHz
> 
> Funny, continents move faster :)  Maybe missing a write or two.

When I get back it may be done booting.  I'm gonna let it try for grins
while I'm away, then take a peek, see if I can spot it.

[ 1567.578340] pcc-cpufreq: (v1.10.00) driver loaded with frequency limits: 1064 MHz, 2266 MHz
                                                                      done
Starting HAL daemon                                                   done


Setting up (localfs) network interfaces:
    lo        
    lo        IP address: 127.0.0.1/8   
              IP address: 127.0.0.2/8                                 done
    eth0      device: Broadcom Corporation NetXtreme II BCM5709 Gig
              No configuration found for eth0                         unused
    eth1      device: Broadcom Corporation NetXtreme II BCM5709 Gig
              No configuration found for eth1                         unused
    eth2      device: NetXen Incorporated NX3031 Multifunction 1/10
[ 2457.114007] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[ 2457.114455] netxen_nic: eth2 NIC Link is up
[ 2457.223582] IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
    eth2      IP address: 0.0.0.0/32

