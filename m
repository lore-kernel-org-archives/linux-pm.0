From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 0/2] [RFC] sysfs: Add hook for checking the file
 capability of opener
Date: Mon, 31 Dec 2018 17:41:05 +0800
Message-ID: <20181231094105.GO3506@linux-l9pv.suse>
References: <20181230132856.24095-1-jlee@suse.com>
 <20181230144506.GA18985@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181230144506.GA18985@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, Joe Perches <joe@perches.com>, Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Greg, 

Thanks for your review!

On Sun, Dec 30, 2018 at 03:45:06PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Dec 30, 2018 at 09:28:54PM +0800, Lee, Chun-Yi wrote:
> > There have some discussion in the following mail loop about checking
> > capability in sysfs write handler:
> >     https://lkml.org/lkml/2018/9/13/978
> 
> A sysfs callback should not care about stuff like this.
> 
> Worst case, do a simple:
> 	if (!capable(CAP_FOO))
> 		return -EPERM
> 
> you don't care or need to worry about the file handle for that at all,
> right?
>

The capable() can be bypassed. Unprivileged process may reads or writes
those sysfs if file permission be relaxed by root for non-root user.
 
> > Sometimes we check the capability in sysfs implementation by using
> > capable function.
> 
> Which should be fine, right?
>

If file permission is enough to restrict sysfs that can only be used
by root. Why do some sysfs interfaces use capable()? It's not
redundancy? 
 
> > But the checking can be bypassed by opening sysfs
> > file within an unprivileged process then writing the file within a
> > privileged process. The tricking way has been exposed by Andy Lutomirski
> > for CVE-2013-1959.
> 
> And who does this for a sysfs file?  And why?
>

Just want to bypass the capable() checking. 
 
> > Because the sysfs_ops does not forward the file descriptor to the
> > show/store callback, there doesn't have chance to check the capability
> > of file's opener.
> 
> Which is by design.  If you care about open, you are using sysfs wrong.
>

OK~ So the sysfs doesn't care opener's capability.
 
> > This patch adds the hook to sysfs_ops that allows
> > different implementation in object and attribute levels for checking
> > file capable before accessing sysfs interfaces.
> 
> No, please no.
>
> > The callback function of kobject sysfs_ops is the first implementation
> > of new hook. It casts attribute to kobj_attribute then calls the file
> > capability callback function of attribute level. The same logic can
> > be implemented in other sysfs file types, like: device, driver and
> > bus type. 
> > 
> > The capability checking logic in wake_lock/wake_unlock sysfs interface
> > is the first example for kobject. It will check the opener's capability.
> 
> Why doesn't the file permission of that sysfs file determine who can or
> can not write to that file?
>

I agree that the file permission can restrict the writer of sysfs. But,
I still confused for why do some sysfs interface use capable()?

Thanks a lot!
Joey Lee 
