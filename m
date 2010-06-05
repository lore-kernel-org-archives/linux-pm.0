From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 5 Jun 2010 22:01:43 +0200
Message-ID: <20100605220143.08774900__35860.4103829295$1275768223$gmane$org@schatten.dmk.lab>
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
	<AANLkTikna-Vs_phy2VrJs0I8gIsdSmwuxTJ67gQ_2oTt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikna-Vs_phy2VrJs0I8gIsdSmwuxTJ67gQ_2oTt@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Linux@smtp1.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sat, 5 Jun 2010 20:44:24 +0300
Felipe Contreras <felipe.contreras@gmail.com> wrote:

> 2010/6/2 Arve Hj=F8nnev=E5g <arve@android.com>:
> > 2010/6/2 Peter Zijlstra <peterz@infradead.org>:
> >> (and please don't mention @#$@ up x86 ACPI again, Intel knows, they're
> >> fixing it, get over it already).
> >>
> >
> > I don't think it is realistic to drop support for all existing hardware.
> =

> We are talking about mainline here, there's no support for suspend
> blockers, so nothing is dropped.
> =

> In the mind of everybody, suspend blockers is for opportunistic
> suspend, which only makes sense on sensible hw (not current x86). So
> in the mind of everybody, x86 should be out of scope for the analysis
> of suspend blockers.
> =

> Are you seriously suggesting that one of the strong arguments in favor
> of suspend blockers is x86 usage (nobody agrees)? If not, then drop
> it.

I think they have an advantage over the
30-minute-screensaver-then-suspend that current desktops do. Because
you can define what keeps the system up. I.e. the
screensaver/powermanager is not limited to keyboard- and
mouse-inactivity.

> If I enable suspend blockers on my laptop, I have to modify my
> user-space. Otherwise my system will behave horribly.
> =


In the simplest case you have a shell script which takes a suspend
blocker and reads from stdinput. When you write "mem" to it, it
releases the suspend blocker and acquires it back again. Voila, forced
suspend reimplemented on top of opportunistic suspend.

That wasn't hard, was it? =


Cheers,
Flo
 =
