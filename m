From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [RFC PATCH 01/12] xen/manage: keep track of the on-going suspend mode
Date: Thu, 14 Jun 2018 02:42:16 +1000
Message-ID: <CAKTCnz=Lfy2vpfGs4+_N9Q9_QCxt5XjFFTEsArkCaKvAi70H_g@mail.gmail.com>
References: <20180612205619.28156-1-anchalag@amazon.com> <20180612205619.28156-2-anchalag@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612205619.28156-2-anchalag@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anchal Agarwal <anchalag@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, roger.pau@citrix.com, netdev <netdev@vger.kernel.org>, jgross@suse.com, xen-devel <xen-devel@lists.xenproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kamatam@amazon.com, Frank van der Linden <fllinden@amazon.com>, vallish@amazon.com, guruanb@amazon.com, eduval@amazon.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, cyberax@amazon.com
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 13, 2018 at 6:56 AM, Anchal Agarwal <anchalag@amazon.com> wrote:
> From: Munehisa Kamata <kamatam@amazon.com>
>
> To differentiate between Xen suspend, PM suspend and PM hibernation,
> keep track of the on-going suspend mode by mainly using a new PM
> notifier. Since Xen suspend doesn't have corresponding PM event, its
> main logic is modfied to acquire pm_mutex and set the current mode.
>

Why do we need to differentiate between them? The changelog does not
explain how Xen Suspend is different from PM suspend. The difference
could be what is injected into the guest vs what the guest decides to
do. How do we use the new suspend_mode?

> Note that we may see deadlock if PM suspend/hibernation is interrupted
> by Xen suspend. PM suspend/hibernation depends on xenwatch thread to
> process xenbus state transactions, but the thread will sleep to wait
> pm_mutex which is already held by PM suspend/hibernation context in the
> scenario. Though, acquirng pm_mutex is still right thing to do, and we
> would need to modify Xen shutdown code to avoid the issue. This will be
> fixed by a separate patch.
>
> Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
> Reviewed-by: Sebastian Biemueller <sbiemue@amazon.com>
> Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
> Reviewed-by: Eduardo Valentin <eduval@amazon.com>
> ---
>  drivers/xen/manage.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
> index 8835065..8f9ea87 100644
> --- a/drivers/xen/manage.c
> +++ b/drivers/xen/manage.c
> @@ -13,6 +13,7 @@
>  #include <linux/freezer.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/export.h>
> +#include <linux/suspend.h>
>
>  #include <xen/xen.h>
>  #include <xen/xenbus.h>
> @@ -39,6 +40,16 @@ enum shutdown_state {
>  /* Ignore multiple shutdown requests. */
>  static enum shutdown_state shutting_down = SHUTDOWN_INVALID;
>
> +enum suspend_modes {
> +       NO_SUSPEND = 0,
> +       XEN_SUSPEND,
> +       PM_SUSPEND,
> +       PM_HIBERNATION,
> +};


Why do the enums range across namespaces -- between NO, XEN and PM?
Can we please be consistent XEN_WATCH_SUSPEND, XEN_PM_SUSPEND. etc?

Balbir Singh.
