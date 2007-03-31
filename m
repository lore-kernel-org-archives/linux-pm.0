From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Sat, 31 Mar 2007 19:17:40 +0200
Message-ID: <20070331171740.GA11750@elte.hu>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<200703291546.48996.maximlevitsky@gmail.com>
	<1175356272.28263.27.camel@localhost.localdomain>
	<200703311956.35922.maximlevitsky@gmail.com>
	<Pine.LNX.4.64.0703311004310.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703311004310.6730@woody.linux-foundation.org>
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
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, tglx@linutronix.de, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Umm.. WHy not make the device tree look like this:
> =

> 	    -- "clocksource" -- +-- HPET
> 				|
> 				+-- TSC
> 				|
> 				+-- i8259
> 				|
> 				+-- lapic timer
> 				|
> 				.. whatever else
> =

> and use the "struct device" that we *have* for this? The whole "struct =

> device" is literally designed to do this, and to be embedded into =

> whatever bigger structures you have that describes higher-level =

> behaviour. Ie you'd put a "struct device" inside the "struct =

> clocksource".

yeah. There's some practical problems that need to be sorted out: much =

of the current GTOD code is irq-driven (and all GTOD locks are =

irq-safe), while the sysfs code needs to run in process-context level. =


Clocksources 'arrive' and 'depart' in hardirq context (which is the =

primary place where we notice their breakage, determine that they are =

now verified to be usable, etc.). This came partly from legacy: the =

gradual conversion of the monolithic time code, and the need to preserve =

GTOD and non-GTOD architectures without too much duplication. It also =

came partly because there's also a fundamental need to have accurate =

time, which is better served from irq context.

i very much agree that this should and must be cleaned up, but it needs =

quite a bit more logistics than it might appear at first sight. =

Clockevents basically just followed (and had to follow) the direction of =

clocksources in this regard.

	Ingo
