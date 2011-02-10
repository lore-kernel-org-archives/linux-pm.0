From: Thomas Fjellstrom <thomas@fjellstrom.ca>
Subject: Re: Wake On lan and ATL1 nic
Date: Thu, 10 Feb 2011 08:59:38 -0700
Message-ID: <201102100859.39059.thomas__39028.0460859232$1297354258$gmane$org@fjellstrom.ca>
References: <201012141756.59591.thomas@fjellstrom.ca>
	<201012230832.00443.thomas@fjellstrom.ca>
	<201012232159.00654.rjw@sisk.pl>
Reply-To: thomas@fjellstrom.ca
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012232159.00654.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On December 23, 2010, Rafael J. Wysocki wrote:
> On Thursday, December 23, 2010, Thomas Fjellstrom wrote:
> > On December 22, 2010, Rafael J. Wysocki wrote:
> > > On Wednesday, December 15, 2010, Thomas Fjellstrom wrote:
> > > > I can't seem to get wol to work with my desktop, which has an
> > > > integrated ATL1 GbE nic. I can't be absolutely sure if it ever
> > > > worked, but I think it did at one point. I can use ethtool to look
> > > > at the wol status, that it supports magic-packet wol, and I can
> > > > enable it, which is done at boot using an init script. But No matter
> > > > how many times I try to send a wol packet to that machine it never
> > > > wakes up.
> > > > 
> > > > Looking around on the net seems to say it is supported, and should
> > > > work, but I'm not having any luck. Anyone have any hints?
> > > 
> > > It works for me with 2.6.37-rc7 and the appended patch applied (at
> > > least the machine is woken up from suspend to RAM).  Of course, the
> > > adapter needs to be configured for that with the help of ethtool.
> > 
> > Hi, thanks for making quick work of this. I have one slight problem, my
> > nic seems to use the atl1 driver, and not atl1c. I've tried using atl1c
> > and atl1e, both will load if I modprobe them, but neither actually bring
> > up the device. Even tried blacklisting atl1 first.
> 
> I see.
> 
> Please try the patch below, then.  It's analogous to the atl1c one, but
> it's untested (builds for me).
> 
> Thanks,
> Rafael
> 
> 

Hi, I just (finally) got around to testing this, and it all works now! thanks a 
lot. Though to be honest, it may not have had an impact. I noticed my BIOS 
settings for PCI device wakeup had been disabled (I could swear they were on, 
but after testing the patch, and wol STILL didn't work, I didn't have any 
other ideas...). And it seems WOL now works on both an unpatched 
2.6.36.1+autogroup, and a patched 2.6.37.

I haven't done any significant testing of this patch, other than the machine 
boots, the network comes up, and WOL works.

If you have any things you want me to try, to make sure the patch is correct, 
let me know.

Thanks again for working on the patches.

-- 
Thomas Fjellstrom
thomas@fjellstrom.ca
