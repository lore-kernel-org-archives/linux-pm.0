From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Sat, 31 Mar 2007 21:13:51 -0700
Message-ID: <200703312113.52789.david-b@pacbell.net>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<200703311232.57505.david-b@pacbell.net>
	<b6a2187b0703312013o6c305e00v829894f215812550@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <b6a2187b0703312013o6c305e00v829894f215812550@mail.gmail.com>
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
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, jgarzik@pobox.com, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Saturday 31 March 2007 8:13 pm, Jeff Chua wrote:
> On 4/1/07, David Brownell <david-b@pacbell.net> wrote:
> > for those will all get grouped together ... suspended "very late" and
> > resumed "very early", regardless of when they get registered.  Pretty
> > much the driver model parts of what Linus was suggesting; clockevent
> > bits would still be needed.
> =

> I tested your patch with CONFIG_NO_HZ=3Dy, but it still hangs while
> suspending to disk (before the percent saving).

Of course.  No clockevent updates...
