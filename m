From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Sat, 31 Mar 2007 19:02:45 +0200
Message-ID: <20070331170245.GA9244@elte.hu>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<460BBD1B.4040308@ru.mvista.com>
	<200703291531.18253.maximlevitsky@gmail.com>
	<200703291546.48996.maximlevitsky@gmail.com>
	<1175356272.28263.27.camel@localhost.localdomain>
	<Pine.LNX.4.64.0703310908160.6730@woody.linux-foundation.org>
	<1175358800.28263.36.camel@localhost.localdomain>
	<Pine.LNX.4.64.0703310943190.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703310943190.6730@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 31 Mar 2007, Thomas Gleixner wrote:
> > =

> > Right, but clock - sources/events need to be extremly late suspended and
> > early resumed. How can we ensure this ?

[...]
> So the only thing that needs to be done is to make sure that we add =

> the timer devices early during bootup - something we have to do =

> *anyway*. If a device is added early in bootup, that automatically =

> means that it will be suspended late, and resumed early - because we =

> maintain that order all the way through..

IIRC hpet is particularly hard to initialize early on in the bootup =

sequence. So the way the clockevents code works is that it will always =

try to make the best out of all available devices, and dynamically =

adapts things as devices 'arrive' or 'depart' - no matter how late that =

happens. (That way there's no dependency on how late a device gets =

registered - it will only delay the switch to high-res mode for =

example.) A given time device might 'depart' because for example the =

watchdog mechanism finds that its quality is not good enough, or because =

someone initiated cpufreq which breaks the TSC clocksource.

i dont think there's any particular problem here because suspend/resume =

wont be done during bootup - but we might need a way to move a device to =

earlier spots in the device tree, even if they got registered later on - =

instead of forcing the time devices to be registered very early?

	Ingo
