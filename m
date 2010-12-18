From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.37-rc5, pata_atiixp,
 DVD-ROM: kernel log flooded with "rpm_resume flags 0x4",
 "rpm_resume returns 1"
Date: Sat, 18 Dec 2010 13:14:33 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012181311570.3334-100000@saphir.localdomain>
References: <20101217213034.7bf6587c@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101217213034.7bf6587c@stein>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Dec 2010, Stefan Richter wrote:

> Well right --- hald polls the card reader for media change too.
> 
> I now noticed that the two lines
> 	sd *:0:0:0: rpm_resume flags 0x4
> 	sd *:0:0:0: rpm_resume returns 1
> are logged once for each sd device (i.e. those with fixed media too)
> at the startup of hald.  Is this expected?

I don't know anything about the details of hal.  But I do know that you
can tell hal not to poll certain devices.  Look at "man
hal-disable-polling".

> Note, I have not seen anything of the sort on another PC which runs
> 2.3.37-rc6 with the same PM debug options.  The differences are that
> the other PC is an Intel 945GM based one with x86-32 kernel and 32bit
> Gentoo userland, whereas the PC with log spam is an AMD RS780 based one
> with x86-64 kernel and 64bit Gentoo userland.  Both got hal 0.5.14-r2.

Maybe CONFIG_DYNAMIC_DEBUG is set differently, or userspace enables 
dynamic debugging of different subsystems.

Alan Stern
