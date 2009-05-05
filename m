From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/9] Input: Block suspend while event queue
	is not	empty.
Date: Tue, 5 May 2009 22:02:30 +0200
Message-ID: <20090505200230.GF1379@ucw.cz>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-2-git-send-email-arve@android.com>
	<1241583529-5092-3-git-send-email-arve@android.com>
	<1241583529-5092-4-git-send-email-arve@android.com>
	<1241583529-5092-5-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1241583529-5092-5-git-send-email-arve@android.com>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocker that will block
> suspend while the event queue is not empty. This allows userspace code to
> process input events while the device appears to be asleep.
> 
> Signed-off-by: Arve Hj??nnev??g <arve@android.com>

Looks ok to  me, but I guess you should cc input maintainers.

> @@ -582,6 +591,19 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>  		else
>  			return evdev_ungrab(evdev, client);
>  
> +	case EVIOCGSUSPENDBLOCK:
> +		return put_user(client->use_suspend_blocker, ip);
> +
> +	case EVIOCSSUSPENDBLOCK:
> +		spin_lock_irq(&client->buffer_lock);
> +		if (!client->use_suspend_blocker && p)
> +			suspend_blocker_init(&client->suspend_blocker, "evdev");
> +		else if (client->use_suspend_blocker && !p)
> +			suspend_blocker_destroy(&client->suspend_blocker);
> +		client->use_suspend_blocker = !!p;
> +		spin_unlock_irq(&client->buffer_lock);
> +		return 0;

This returns 0 even when you destroy already destroyed blocker
(etc). Is that ok?



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
