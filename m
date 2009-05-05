From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/9] PM: suspend_block: Add driver to access
	suspend	blockers from user-space
Date: Tue, 5 May 2009 22:16:24 +0200
Message-ID: <20090505201624.GH1379@ucw.cz>
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

On Tue 2009-05-05 21:18:42, Arve Hj??nnev??g wrote:
> Add a misc device, "suspend_blocker", that allows user-space processes
> to block auto suspend. The device has ioctls to create a suspend_blocker,
> and to block and unblock suspend. To delete the suspend_blocker, close
> the device.
> 

> +static int create_user_suspend_blocker(struct file *file, void __user *name,
> +				 size_t name_len)
> +{
> +	struct user_suspend_blocker *bl;
> +	if (file->private_data)
> +		return -EBUSY;
> +	bl = kzalloc(sizeof(*bl) + name_len + 1, GFP_KERNEL);
...
> +static long user_suspend_blocker_ioctl(struct file *file, unsigned int cmd,
> +				unsigned long _arg)
> +{
> +	void __user *arg = (void __user *)_arg;
> +	struct user_suspend_blocker *bl;
> +	long ret;
> +
> +	mutex_lock(&ioctl_lock);
> +	if ((cmd & ~IOCSIZE_MASK) == SUSPEND_BLOCKER_IOCTL_INIT(0)) {
> +		ret = create_user_suspend_blocker(file, arg, _IOC_SIZE(cmd));
> +		goto done;
> +	}

Wait a moment, wtf is this? Not one ioctl but one ioctl per length of
string?!

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
