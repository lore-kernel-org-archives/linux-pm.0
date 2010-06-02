From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 22:13:09 +0200
Message-ID: <20100602221309.6da754e7__16272.6923976608$1275509796$gmane$org@schatten.dmk.lab>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005302202.39511.rjw@sisk.pl>
	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
	<201005312347.24251.rjw@sisk.pl>
	<AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
	<alpine.LFD.2.00.1006011411200.2933@localhost.localdomain>
	<AANLkTikZHmF6baP7dEXEGFE8YsbEteRjlhb5wqZX8ll1@mail.gmail.com>
	<alpine.LFD.2.00.1006020905410.2933@localhost.localdomain>
	<AANLkTinDm3FIrbS1jqEzW15THmr1hdd7ox0Mllm1VLjZ@mail.gmail.com>
	<1275471561.27810.30865.camel@twins>
	<AANLkTilLmAb2c9fQwuguzWtjcHfuTZvPUTbUx7vuwFI6@mail.gmail.com>
	<1275474088.27810.31000.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275474088.27810.31000.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, 02 Jun 2010 12:21:28 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, 2010-06-02 at 03:00 -0700, Arve Hj=F8nnev=E5g wrote:
> > 2010/6/2 Peter Zijlstra <peterz@infradead.org>:
> > > On Wed, 2010-06-02 at 01:54 -0700, Arve Hj=F8nnev=E5g wrote:
> > >> No I want you to stop confusing low power idle modes with suspend.
> > >
> > > I think it is you who is confused. For power management purposes susp=
end
> > > is nothing more but a deep idle state.
> > =

> > No, idle is transparent, suspend is not.
> =

> Which is where the problem is, it should be.
> =

> > Why would I add suspend blockers to the code I want to prevent running?
> =

> Because what you want might not be what others want. Suppose you're fine
> with your torrent client/irc client/etc.. to loose their network
> connection when you're not behind your desktop so you don't add suspend
> blockers there.
> =

> Me, I'd be ready to administer physical violence if either of those lost
> their connections when I wasn't around to keep the screen-saver from
> kicking in.

Do you switch your pc on and off manually? Sometimes? Really?
(if not, you are probably a kernel hacker *g*) =


I assume, in general, there are only a few reasons to shut down a
machine: =


1. One has to do maintainance on the hardware or somehow needs to
interrupt the power supply.

2. One wants to save power. =


3. One wants to go easy on the hardware. =


4. ...?

Obviously, for reason 1 we need to maintain the shutdown-paths
indefinitely.  =


But the rest are usecases that are similar to the suspend-blocker
usecases. You know that you are not using the machine and going
through the pain to shut down your machine. You have to do it manually.
Why? =


> This leads to having to sprinkle magic dust (and lots of config options)
> all over userspace. Something that gets esp interesting with only a
> boolean interface.

A userspace daemon could keep track of what applications can be
ignored. The wordprocessor probably should not keep the system busy. As
well as a running firefox. =


It is a hard problem. But we have _no way of deciding any of this in
the kernel_!


> =

> In the example above, having an active net connection would prevent my
> desktop from suspending, but what if another platform can maintain net
> connections while suspended? Do we then end up with arch specific code
> in the net-stack? I'm sure DaveM would love that.
> =

If it is driver knowledge, then it goes into the driver.
If it is platform knowledge, then it goes into the platform code.
I think that is a clear requirement to keeping sanity. =


The problem is there independently of suspend blockers. If the system
can suspend with network up, then you shure as hell want to suspend
even if the network is up. So it would actually be a reason for any
kind of "suspend blockers" scheme. Wouldn't it?

Cheers,
Flo
