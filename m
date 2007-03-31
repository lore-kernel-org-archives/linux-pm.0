From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Sat, 31 Mar 2007 17:51:11 +0200
Message-ID: <1175356272.28263.27.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<460BBD1B.4040308@ru.mvista.com>
	<200703291531.18253.maximlevitsky@gmail.com>
	<200703291546.48996.maximlevitsky@gmail.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703291546.48996.maximlevitsky@gmail.com>
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
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, jgarzik@pobox.com, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2007-03-29 at 15:46 +0200, Maxim Levitsky wrote:
> Subject: Add suspend/resume for HPET
> This adds support of suspend/resume on i386 for HPET
> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
>
> +static struct sysdev_class hpet_class =3D {
> +	set_kset_name("hpet"),
> +	.suspend	=3D hpet_suspend,
> +	.resume		=3D hpet_resume,
> +};
> +
> +static struct sys_device hpet_device =3D {
> +	.id		=3D 0,
> +	.cls		=3D &hpet_class,
> +};

Sorry for being inresponsive. I was travelling and unexpectedly cut off
from the internet for some days.

While I agree in principle with the patch, I'm a bit uncomfortable. The
sys device suspend / resume ordering is not guaranteed and relies on the
registering order.

Jeff still seems to have problems with CONFIG_NO_HZ=3Dn and it might be
caused by time keeping / tick management resume happening before the
HPET resume.

The required resume order is:

clocksources
timekeeping
clockevents
tick management

I'm not sure how to do this properly with the sys device facilities, but
I look into it.

/me goes off to understand the sys device magic.

	tglx
