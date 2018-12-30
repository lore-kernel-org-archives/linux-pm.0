From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] [RFC] sysfs: Add hook for checking the file
 capability of opener
Date: Sun, 30 Dec 2018 15:45:06 +0100
Message-ID: <20181230144506.GA18985@kroah.com>
References: <20181230132856.24095-1-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181230132856.24095-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, Joe Perches <joe@perches.com>, Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Chen Yu <yu.c.chen@intel.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 30, 2018 at 09:28:54PM +0800, Lee, Chun-Yi wrote:
> There have some discussion in the following mail loop about checking
> capability in sysfs write handler:
>     https://lkml.org/lkml/2018/9/13/978

A sysfs callback should not care about stuff like this.

Worst case, do a simple:
	if (!capable(CAP_FOO))
		return -EPERM

you don't care or need to worry about the file handle for that at all,
right?

> Sometimes we check the capability in sysfs implementation by using
> capable function.

Which should be fine, right?

> But the checking can be bypassed by opening sysfs
> file within an unprivileged process then writing the file within a
> privileged process. The tricking way has been exposed by Andy Lutomirski
> for CVE-2013-1959.

And who does this for a sysfs file?  And why?

> Because the sysfs_ops does not forward the file descriptor to the
> show/store callback, there doesn't have chance to check the capability
> of file's opener.

Which is by design.  If you care about open, you are using sysfs wrong.

> This patch adds the hook to sysfs_ops that allows
> different implementation in object and attribute levels for checking
> file capable before accessing sysfs interfaces.

No, please no.

> The callback function of kobject sysfs_ops is the first implementation
> of new hook. It casts attribute to kobj_attribute then calls the file
> capability callback function of attribute level. The same logic can
> be implemented in other sysfs file types, like: device, driver and
> bus type. 
> 
> The capability checking logic in wake_lock/wake_unlock sysfs interface
> is the first example for kobject. It will check the opener's capability.

Why doesn't the file permission of that sysfs file determine who can or
can not write to that file?

thanks,

greg k-h
