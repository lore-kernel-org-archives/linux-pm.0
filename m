From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Sat, 31 Mar 2007 10:09:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703311004310.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<200703291546.48996.maximlevitsky@gmail.com>
	<1175356272.28263.27.camel@localhost.localdomain>
	<200703311956.35922.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703311956.35922.maximlevitsky@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, tglx@linutronix.de, jgarzik@pobox.com, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org



On Sat, 31 Mar 2007, Maxim Levitsky wrote:
> =

> So maybe I was right afrer all,
> Maybe it is better to add a suspend/resume hook to each clock source and =
call =

> it from timekeeping_resume() ?

Umm.. WHy not make the device tree look like this:

	    -- "clocksource" -- +-- HPET
				|
				+-- TSC
				|
				+-- i8259
				|
				+-- lapic timer
				|
				.. whatever else

and use the "struct device" that we *have* for this? The whole "struct =

device" is literally designed to do this, and to be embedded into whatever =

bigger structures you have that describes higher-level behaviour. Ie you'd =

put a "struct device" inside the "struct clocksource".

That thingalready *has* the suspend/resume hooks, and it will mean that =

people will see the clocks in the device tree rather than have a new =

notion.


			Linus
