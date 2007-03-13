From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [6/6] 2.6.21-rc3: known regressions
Date: Tue, 13 Mar 2007 21:46:17 +0100
Message-ID: <1173818777.13341.128.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0703062050570.5963@woody.linux-foundation.org>
	<20070313125025.GW18731@stusta.de>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070313125025.GW18731@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Emil Karlson <jkarlson@cc.hut.fi>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephane Casset <sept@logidee.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-03-13 at 13:50 +0100, Adrian Bunk wrote:
> This email lists some known regressions in Linus' tree compared to 2.6.20.
> =

> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way
> possibly involved with one or more of these issues.
> =

> Due to the huge amount of recipients, please trim the Cc when answering.
> Subject    : Clocksource tsc unstable (delta =3D -154983451 ns)
> References : http://lkml.org/lkml/2007/3/9/271
> Submitter  : Jiri Slaby <jirislaby@gmail.com>
> Status     : unknown

That's not a regression. That's an informal message, when the TSC
watchdog detects that the TSC is unreliable. =


	tglx
