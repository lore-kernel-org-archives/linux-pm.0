From: Don Zickus <dzickus@redhat.com>
Subject: Re: hibernation hangs with ATA errors (lockup_detector
	bug)
Date: Fri, 3 Sep 2010 09:56:13 -0400
Message-ID: <20100903135613.GV4879__16308.3364059732$1283522328$gmane$org@redhat.com>
References: <4C03C608.1040600@gmail.com> <20100601135004.GP15159@redhat.com>
	<4C051D44.7040203@gmail.com> <20100602184459.GA15159@redhat.com>
	<4C0B3E94.6020506@gmail.com> <4C80B338.6020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C80B338.6020701@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 03, 2010 at 10:35:04AM +0200, Jiri Slaby wrote:
> On 06/06/2010 08:22 AM, Jiri Slaby wrote:
> > On 06/02/2010 08:44 PM, Don Zickus wrote:
> >> --- a/kernel/watchdog.c
> >> +++ b/kernel/watchdog.c
> >> @@ -550,8 +550,7 @@ cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
> >>  		break;
> >>  	case CPU_ONLINE:
> >>  	case CPU_ONLINE_FROZEN:
> >> -		if (watchdog_enable(hotcpu))
> >> -			return NOTIFY_BAD;
> >> +		watchdog_enable(hotcpu)
> > 
> > This fixes the problem indeed.
> 
> Hi, was this fixed somehow? I still use this hunk and don't know if it
> is needed:

I have to go re-review the problem again.  I might have forgot to bring it
in.  Thanks for reminding me!

Cheers,
Don

> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -524,7 +524,7 @@ cpu_callback(struct notifier_block *nfb, unsigned
> long action, void *hcpu)
>                 break;
>         case CPU_ONLINE:
>         case CPU_ONLINE_FROZEN:
> -               err = watchdog_enable(hotcpu);
> +               watchdog_enable(hotcpu);
>                 break;
>  #ifdef CONFIG_HOTPLUG_CPU
>         case CPU_UP_CANCELED:
> 
> thanks,
> -- 
> js
