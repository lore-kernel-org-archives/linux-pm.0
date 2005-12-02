From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [RFC] change suspend_finish order slightly
Date: Fri, 2 Dec 2005 12:33:22 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512021231290.28279-100000@monsoon.he.net>
References: <1133579748.7835.6.camel@linux.site>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36191625927762816=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1133579748.7835.6.camel@linux.site>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============36191625927762816==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 2 Dec 2005, Shaohua Li wrote:

> The BIOS guys here require ACPI _WAK method which is called in
> pm_ops->finish is invoked after all CPUs are resumed. Detail info can be
> found at http://bugzilla.kernel.org/show_bug.cgi?id=5651. To do this,
> this patch tries to change the order slightly. Does this break other
> platforms?

>  linux-2.6.14-root/kernel/power/main.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff -puN kernel/power/main.c~smp_s3_order kernel/power/main.c
> --- linux-2.6.14/kernel/power/main.c~smp_s3_order	2005-11-03 14:18:29.000000000 +0800
> +++ linux-2.6.14-root/kernel/power/main.c	2005-11-03 14:21:05.000000000 +0800
> @@ -133,10 +133,10 @@ static int suspend_enter(suspend_state_t
>  static void suspend_finish(suspend_state_t state)
>  {
>  	device_resume();
> -	if (pm_ops && pm_ops->finish)
> -		pm_ops->finish(state);
>  	thaw_processes();
>  	enable_nonboot_cpus();
> +	if (pm_ops && pm_ops->finish)
> +		pm_ops->finish(state);
>  	pm_restore_console();
>  }
>
> _

ACKed-by Patrick Mochel <mochel@linux.intel.com>

--===============36191625927762816==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============36191625927762816==--
