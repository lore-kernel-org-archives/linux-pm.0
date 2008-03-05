From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Wed, 5 Mar 2008 07:04:54 +0100
Message-ID: <20080305070454.3df78593__17142.6626657651$1204697397$gmane$org@mjolnir.drzeus.cx>
References: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
	<Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080303231033.GB15255@one.firstfloor.org>
	<20080304040048.GA31562@codemonkey.org.uk>
	<20080304071423.0e6b71c1@mjolnir.drzeus.cx>
	<20080304181924.70aaf8c1@mjolnir.drzeus.cx>
	<20080304172918.GA27332@one.firstfloor.org>
	<20080304183032.17084e39@mjolnir.drzeus.cx>
	<20080304174315.GB27332@one.firstfloor.org>
	<20080304190446.775165e3@mjolnir.drzeus.cx>
	<20080304183406.GC27332@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080304183406.GC27332@one.firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 4 Mar 2008 19:34:06 +0100
Andi Kleen <andi@firstfloor.org> wrote:

> On Tue, Mar 04, 2008 at 07:04:46PM +0100, Pierre Ossman wrote:
> > 
> > I don't think I quite see the point. If we can't force an update, then
> > it doesn't really help us knowing if the jiffies value is stale or not.
> 
> What do you mean with force an update? The system always does an 
> jiffies update automatically after idle wakeup. It's just that if you add 
> code to the code path that uses jiffies you have to make sure it is after the 
> standard update, otherwise you'll see a stale value.
> 

I still don't follow. Perhaps you can express it in pseudo code? If I have a stale value that I cannot refresh, knowing that it is stale doesn't change anything.


-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
