From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: 29 Mar 2007 22:46:46 +0200
Message-ID: <p734po33hhl.fsf@bingen.suse.de>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<460BBD1B.4040308@ru.mvista.com>
	<200703291531.18253.maximlevitsky@gmail.com>
	<200703291546.48996.maximlevitsky@gmail.com>
	<Pine.LNX.4.64.0703290949060.6730@woody.linux-foundation.org>
	<20070329175117.GA5521@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070329175117.GA5521@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-acpi@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, jgarzik@pobox.com, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Adrian Bunk <bunk@stusta.de>, linux-ide@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-pci@atrey.karlin.mff.cuni.cz, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
> =

> there's no fundamental reason. x86_64 COW-ed hpet_timer.c and =

> time_hpet.c years ago and drifted off into different areas.

Not quite -- x86-64 did HPET long before i386; the only stuff cowed
was the character driver support code. But the core HPET code
was always totally different code streams. We never did the complicated =

pluggable clock code i386 did though -- i never quite saw the point of that
because there aren't that many timers there.
Of course it is already obsolete with clocksources now.

-Andi
