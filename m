From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Sun, 1 Apr 2007 11:13:31 +0800
Message-ID: <b6a2187b0703312013o6c305e00v829894f215812550@mail.gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<20070331170245.GA9244@elte.hu>
	<200703311118.55132.david-b@pacbell.net>
	<200703311232.57505.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703311232.57505.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, jgarzik@pobox.com, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 4/1/07, David Brownell <david-b@pacbell.net> wrote:
> for those will all get grouped together ... suspended "very late" and
> resumed "very early", regardless of when they get registered.  Pretty
> much the driver model parts of what Linus was suggesting; clockevent
> bits would still be needed.

I tested your patch with CONFIG_NO_HZ=3Dy, but it still hangs while
suspending to disk (before the percent saving).

But one discovery. I get tired of all these hangs, so I decided to
press some keys and the power button. Accidentally, the suspend
proceeded and successfully suspended!

I tried many more times, and discovered that to proceed with the
suspend, hit any 4 keys slowly. (e.g. "F1 F2 F3 F4", or "1 2 3 4").

My .config has CONFIG_NO_HZ=3Dy and CONFIG_HIGH_RES_TIMERS=3Dy, but I
suppose CONFIG_HIGH_RES_TIMERS=3Dy gots nothing to do with the hang.

I went back with my vanilla 2.6.21-rc5 with Maxim's patch, and with
hitting the keys, I could suspend to disk with CONFIG_NO_HZ=3Dy and
CONFIG_HIGH_RES_TIMERS=3Dy.

Jeff.
