From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [3/6] 2.6.21-rc4: known regressions
Date: Wed, 28 Mar 2007 09:38:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703280931520.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<200703281543.47049.maximlevitsky@gmail.com>
	<20070328144148.GA16244@elte.hu>
	<200703281701.23876.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703281701.23876.maximlevitsky@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim <maximlevitsky@gmail.com>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 28 Mar 2007, Maxim wrote:
> =

> 	Now I don't have a clue how to set those bits if only HPET is used as cl=
ock source because now clocksources
> 	don't have _any_ resume hook.

One thing that drives me wild about that "clocksource resume" thing is =

that it seems to think that clocksources are somehow different from any =

other system devices..

Why isn't the HPET considered a "device", and has it's own *device* =

"suspend" and "resume"? Why do we seem to think that only "set_mode()" =

etc should wake up clock sources?

It's a *device*, dammit. It should save and resume like one (probably as a =

system device). The "set_mode()" etc stuff is at a completely different =

(higher) conceptual level.

Thomas? It does seem like Maxim has hit the nail on the head (at least =

partly) on the HPET timer resume problems..

		Linus
