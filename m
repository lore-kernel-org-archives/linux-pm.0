From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Fri, 23 Apr 2010 10:43:49 +0200
Message-ID: <20100423084349.GC1573__37330.6565722034$1272036743$gmane$org@ucw.cz>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1271984938-13920-3-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj??nnev??g <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Add a misc device, "suspend_blocker", that allows user-space processes
> to block auto suspend. The device has ioctls to create a suspend_blocker,
> and to block and unblock suspend. To delete the suspend_blocker, close
> the device.
> 
> Signed-off-by: Arve Hj??nnev??g <arve@android.com>

> --- a/Documentation/power/suspend-blockers.txt
> +++ b/Documentation/power/suspend-blockers.txt
> @@ -95,3 +95,20 @@ if (list_empty(&state->pending_work))
>  else
>  	suspend_block(&state->suspend_blocker);
>  
> +User-space API
> +==============
> +
> +To create a suspend_blocker from user-space, open the suspend_blocker device:
> +    fd = open("/dev/suspend_blocker", O_RDWR | O_CLOEXEC);
> +then call:
> +    ioctl(fd, SUSPEND_BLOCKER_IOCTL_INIT(strlen(name)), name);


This seems like very wrong idea -- it uses different ioctl number for
each length AFAICT.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
