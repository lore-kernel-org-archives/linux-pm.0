From: David Brownell <david-b@pacbell.net>
Subject: Re: [3/6] 2.6.21-rc4: known regressions
Date: Wed, 28 Mar 2007 12:38:55 -0700
Message-ID: <200703281238.57811.david-b@pacbell.net>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<200703281701.23876.maximlevitsky@gmail.com>
	<Pine.LNX.4.64.0703280931520.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0703280931520.6730@woody.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Maxim <maximlevitsky@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-acpi@vger.kernel.org, jgarzik@pobox.com, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Adrian Bunk <bunk@stusta.de>, linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-pci@atrey.karlin.mff.cuni.cz, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wednesday 28 March 2007 9:38 am, Linus Torvalds wrote:

> It's a *device*, dammit. It should save and resume like one (probably as =
a =

> system device). The "set_mode()" etc stuff is at a completely different =

> (higher) conceptual level.

Agreed, except about "probably as a system device".

Last I checked, there was no good reason to use sysdev suspend()/resume()
rather than platform_device suspend_late()/early_resume().  Which more
or less means no good reason to use sysdev in new code...


Also, making HPET use the legacy mode seems like a step backwards.

- Dave
