From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
	suspend	blockers from user-space
Date: Tue, 5 May 2009 22:12:25 +0200
Message-ID: <20090505201225.GG1379@ucw.cz>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<1241583529-5092-2-git-send-email-arve@android.com>
	<1241583529-5092-3-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1241583529-5092-3-git-send-email-arve@android.com>
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

Hi!

> Add a misc device, "suspend_blocker", that allows user-space processes
> to block auto suspend. The device has ioctls to create a suspend_blocker,
> and to block and unblock suspend. To delete the suspend_blocker, close
> the device.

Rafael proposed write() interface. I don't think you answered that.


> +static int create_user_suspend_blocker(struct file *file, void __user *name,
> +				 size_t name_len)
> +{
> +	struct user_suspend_blocker *bl;
> +	if (file->private_data)
> +		return -EBUSY;
> +	bl = kzalloc(sizeof(*bl) + name_len + 1, GFP_KERNEL);
> +	if (!bl)
> +		return -ENOMEM;
> +	if (copy_from_user(bl->name, name, name_len))
> +		goto err_fault;
> +	suspend_blocker_init(&bl->blocker, bl->name);
> +	file->private_data = bl;
> +	return 0;

kzalloc on user-supplied argument. Sounds like bad idea.

Aha. And probably integer overflow in the same line. Ouch.

Plus you actually 'trust' the string from userspace. Someone passes
"evdev" there and can masquerade as a part of kernel.

> +static int user_suspend_blocker_release(struct inode *inode, struct file *file)
> +{
> +	struct user_suspend_blocker *bl = file->private_data;
> +	if (!bl)
> +		return 0;
> +	suspend_blocker_destroy(&bl->blocker);
> +	kfree(bl);
> +	return 0;
> +}

What happens if someone does dup() on such file descriptor? 


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
