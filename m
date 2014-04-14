From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: ARM: Zynq: CPUFreq issues in setting frequencies (Was: Re: Help
 about PetaLinux)
Date: Mon, 14 Apr 2014 10:05:28 -0700
Message-ID: <671c307a-813b-41d8-9839-09265df019df@AM1EHSMHS005.ehs.local>
References: <CAOh2x=n5NzPCMiZfWhQ4tFhPE+4TA_tqsOkkeeA87Q0VqECXog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:51171
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755508AbaDNRFi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Apr 2014 13:05:38 -0400
Content-Disposition: inline
In-Reply-To: <CAOh2x=n5NzPCMiZfWhQ4tFhPE+4TA_tqsOkkeeA87Q0VqECXog@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mokhtar Bouain <mokhtar.bouain@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, michal.simek@xilinx.com

On Sat, 2014-04-12 at 02:14PM +0530, Viresh Kumar wrote:
> On Sat, Apr 12, 2014 at 3:02 AM, Mokhtar Bouain
> <mokhtar.bouain@gmail.com> wrote:
> > Hi Viresh,
> > Please, I have a problem with the PetaLinux and Zynq board.
> > I posted my probem here :
> > http://forums.xilinx.com/t5/Embedded-Linux/clk-set-rate-failed-to-s=
et-i2c0-aper-rate-zc702-board-and/td-p/438352
> > There is a member of the xilinx forum who you mentioned that you fo=
und the
> > solution.
> > Can you help me please?
>=20
> Hi Mokhtar,
>=20
> I don't have a clue what's going on here as I haven't been looking
> at platform internals at all..
>=20
> Soren/Michal are probably working on those things, they might help.
>=20

All the information is actually in the forum and referenced topics
there...
Unfortunately, Zynq has plenty inter dependencies between clocks.
That results in all kinds of limitations, because Zynq's timers are
driven by their bus clock which is derived from the CPU clock.
And also other peripherals are clocked by this clock. So, a solution
needs to take all these dependencies into account, which means that
certain operations may fail.

Also, the issue described affects (an outdated version of) our vendor
tree only. We just merged cpufreq support into mainline. We'll see
how that goes.

	S=C3=B6ren


