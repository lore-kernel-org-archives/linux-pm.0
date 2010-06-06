From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hibernation hangs with ATA errors (lockup_detector
	bug)
Date: Sun, 06 Jun 2010 08:22:12 +0200
Message-ID: <4C0B3E94.6020506__8836.62277269668$1275805395$gmane$org@gmail.com>
References: <4C03C608.1040600@gmail.com> <20100601135004.GP15159@redhat.com>
	<4C051D44.7040203@gmail.com> <20100602184459.GA15159@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100602184459.GA15159@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Don Zickus <dzickus@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/02/2010 08:44 PM, Don Zickus wrote:
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -550,8 +550,7 @@ cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
>  		break;
>  	case CPU_ONLINE:
>  	case CPU_ONLINE_FROZEN:
> -		if (watchdog_enable(hotcpu))
> -			return NOTIFY_BAD;
> +		watchdog_enable(hotcpu)

This fixes the problem indeed.

thanks,
-- 
js
