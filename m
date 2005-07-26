From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [PATCH 1/23] Add missing
	device_suspsend(PMSG_FREEZE) calls.
Date: Wed, 27 Jul 2005 03:54:23 +1000
Message-ID: <1122400462.4382.13.camel@localhost>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============81494615106840274=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============81494615106840274==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

Could you please send PMSG_* related patches to linux-pm at
lists.osdl.org as well?

Thanks!

Nigel

On Wed, 2005-07-27 at 03:21, Eric W. Biederman wrote:
> In the recent addition of device_suspend calls into
> sys_reboot two code paths were missed.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> 
>  kernel/sys.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> 5f0fb00783b94248b5a76c161f1c30a033fce4d3
> diff --git a/kernel/sys.c b/kernel/sys.c
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -391,6 +391,7 @@ asmlinkage long sys_reboot(int magic1, i
>  	case LINUX_REBOOT_CMD_RESTART:
>  		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
>  		system_state = SYSTEM_RESTART;
> +		device_suspend(PMSG_FREEZE);
>  		device_shutdown();
>  		printk(KERN_EMERG "Restarting system.\n");
>  		machine_restart(NULL);
> @@ -452,6 +453,7 @@ asmlinkage long sys_reboot(int magic1, i
>  		}
>  		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
>  		system_state = SYSTEM_RESTART;
> +		device_suspend(PMSG_FREEZE);
>  		device_shutdown();
>  		printk(KERN_EMERG "Starting new kernel\n");
>  		machine_shutdown();
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


--===============81494615106840274==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============81494615106840274==--
