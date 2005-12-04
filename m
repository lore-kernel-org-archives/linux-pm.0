From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [RFC] change suspend_finish order slightly
Date: Sun, 04 Dec 2005 23:55:41 +1000
Message-ID: <1133704474.5993.14.camel@laptop.cunninghams>
References: <1133579748.7835.6.camel@linux.site>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6886281741847996=="
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
To: Li Shaohua <shaohua.li@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============6886281741847996==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Sat, 2005-12-03 at 13:15, Shaohua Li wrote:
> The BIOS guys here require ACPI _WAK method which is called in
> pm_ops->finish is invoked after all CPUs are resumed. Detail info can be
> found at http://bugzilla.kernel.org/show_bug.cgi?id=5651. To do this,
> this patch tries to change the order slightly. Does this break other
> platforms?

Is it needed even if you call the prepare after hot unplugging other
cpus? (If so, I need to modify suspend2, too).

Regards,

Nigel

> Thanks,
> Shaohua
> ---
> 
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
> 
> 
> 
> ______________________________________________________________________
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
-- 



--===============6886281741847996==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============6886281741847996==--
