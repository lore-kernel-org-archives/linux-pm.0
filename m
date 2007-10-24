From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6 patch] make kernel_shutdown_prepare() static
Date: Wed, 24 Oct 2007 20:22:26 +0200
Message-ID: <20071024182226.GC5093@elf.ucw.cz>
References: <20071024162345.GV30533@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071024162345.GV30533@stusta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed 2007-10-24 18:23:45, Adrian Bunk wrote:
> kernel_shutdown_prepare() can now become static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

ACK.

> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index 85ea63f..b93b541 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -59,8 +59,6 @@ extern void machine_crash_shutdown(struct pt_regs *);
>   * Architecture independent implemenations of sys_reboot commands.
>   */
>  
> -extern void kernel_shutdown_prepare(enum system_states state);
> -
>  extern void kernel_restart(char *cmd);
>  extern void kernel_halt(void);
>  extern void kernel_power_off(void);
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 304b541..4c77ed2 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -315,7 +315,7 @@ static void kernel_kexec(void)
>  #endif
>  }
>  
> -void kernel_shutdown_prepare(enum system_states state)
> +static void kernel_shutdown_prepare(enum system_states state)
>  {
>  	blocking_notifier_call_chain(&reboot_notifier_list,
>  		(state == SYSTEM_HALT)?SYS_HALT:SYS_POWER_OFF, NULL);
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
