From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [3/6] 2.6.21-rc4: known regressions
Date: Wed, 28 Mar 2007 20:32:26 +0200
Message-ID: <20070328183226.GA16415@elte.hu>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<b6a2187b0703261046r46782eedv64464ceddb44bc27@mail.gmail.com>
	<1175065468.4017.1.camel@chaos>
	<200703281543.47049.maximlevitsky@gmail.com>
	<20070328180457.GA4253@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070328180457.GA4253@mellanox.co.il>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Cc: Maxim <maximlevitsky@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:

> Bingo!
> =

> The patch below fixes the two problems (listed above) with resume from =

> RAM that I have observed on my T60 with 2.6.21-rc5: with this patch =

> applied, and with CONFIG_NO_HZ unset, date advances correctly, X =

> functions properly and there is no delay on first disk access.
> =

> Thanks very much.
[...]
> =

> Maxim, do you plan to send this upstream?

we'll fix this the right way tomorrow, by adding a proper suspend/resume =

sysdev handler - the lapic clockevents driver already has that. Maxim =

definitely deserves alot of kudos for having found this bug!

	Ingo
