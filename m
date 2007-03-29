From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [ PATCH] Add suspend/resume for HPET was: Re: [3/6]
 2.6.21-rc4: known regressions
Date: Thu, 29 Mar 2007 17:20:27 +0400
Message-ID: <460BBD1B.4040308@ru.mvista.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<200703290641.20236.maximlevitsky@gmail.com>
	<Pine.LNX.4.64.0703282203550.6730@woody.linux-foundation.org>
	<200703290747.28929.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703290747.28929.maximlevitsky@gmail.com>
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
Cc: gregkh@suse.de, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello.

Maxim wrote:

> ---
> This adds support of suspend/resume on i386 for HPET

   The part after usually "---" gets cut off, the patch description and =

signoff should actially *precede* it.

> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>

> diff --git a/arch/i386/kernel/hpet.c b/arch/i386/kernel/hpet.c
> index 0fd9fba..7c67780 100644
> --- a/arch/i386/kernel/hpet.c
> +++ b/arch/i386/kernel/hpet.c
[...]
> +static __init int hpet_register_sysfs(void)
> +{
> +	int err;
> +
> +	if (!is_hpet_capable())
> +		return 0;
> +
> +	err =3D sysdev_class_register(&hpet_class);
> +
> +	if (!err) {
> +		sysdev_register(&hpet_device);
> +		if (err)
> +			sysdev_class_unregister(&hpet_class);

    This doesn't make sense, err will always be 0.  Perhaps you actually =

intended to check the result of sysdev_register()?

> +	}
> +
> +	return err;
> +}
> +
> +device_initcall(hpet_register_sysfs);
> +
> +#endif

WBR, Sergei
