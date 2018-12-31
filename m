From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] PM / Sleep: Check the file capability when writing
 wake lock interface
Date: Mon, 31 Dec 2018 13:33:10 +0100
Message-ID: <20181231123310.GA3038@kroah.com>
References: <20181230132856.24095-1-jlee@suse.com>
 <20181230132856.24095-3-jlee@suse.com>
 <20181230144835.GB18985@kroah.com>
 <20181231093851.GN3506@linux-l9pv.suse>
 <20181231104055.GB27420@kroah.com>
 <CAG48ez3-YEVsyuk1H6hjGy9Ogm-z46bmdnqy0JbW9YL297FsTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAG48ez3-YEVsyuk1H6hjGy9Ogm-z46bmdnqy0JbW9YL297FsTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jann Horn <jannh@google.com>
Cc: joeyli <jlee@suse.com>, Andy Lutomirski <luto@kernel.org>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, Joe Perches <joe@perches.com>, Bart Van Assche <bvanassche@acm.org>, kernel list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Giovanni Gherdovich <ggherdovich@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 31, 2018 at 01:02:35PM +0100, Jann Horn wrote:
> On Mon, Dec 31, 2018 at 11:41 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Dec 31, 2018 at 05:38:51PM +0800, joeyli wrote:
> > > Hi Greg,
> > >
> > > On Sun, Dec 30, 2018 at 03:48:35PM +0100, Greg Kroah-Hartman wrote:
> > > > On Sun, Dec 30, 2018 at 09:28:56PM +0800, Lee, Chun-Yi wrote:
> > > > > The wake lock/unlock sysfs interfaces check that the writer must has
> > > > > CAP_BLOCK_SUSPEND capability. But the checking logic can be bypassed
> > > > > by opening sysfs file within an unprivileged process and then writing
> > > > > the file within a privileged process. The tricking way has been exposed
> > > > > by Andy Lutomirski in CVE-2013-1959.
> > > >
> > > > Don't you mean "open by privileged and then written by unprivileged?"
> > > > Or if not, exactly how is this a problem?  You check the capabilities
> > > > when you do the write and if that is not allowed then, well
> > > >
> > >
> > > Sorry for I didn't provide clear explanation.
> > >
> > > The privileged means CAP_BLOCK_SUSPEND but not file permission. The file permission
> > > has already relaxed for non-root user. Then the expected behavior is that non-root
> > > process must has CAP_BLOCK_SUSPEND capability for writing wake_lock sysfs.
> > >
> > > But, the CAP_BLOCK_SUSPEND restrict can be bypassed:
> > >
> > > int main(int argc, char* argv[])
> > > {
> > >         int fd, ret = 0;
> > >
> > >         fd = open("/sys/power/wake_lock", O_RDWR);
> > >         if (fd < 0)
> > >                 err(1, "open wake_lock");
> > >
> > >         if (dup2(fd, 1) != 1) // overwrite the stdout with wake_lock
> > >                 err(1, "dup2");
> > >         sleep(1);
> > >         execl("./string", "string");  //string has capability
> > >
> > >         return ret;
> > > }
> > >
> > > This program is an unpriviledged process (has no CAP_BLOCK_SUSPEND), it opened
> > > wake_lock sysfs and overwrited stdout. Then it executes the "string" program
> > > that has CAP_BLOCK_SUSPEND.
> >
> > That's the problem right there, do not give CAP_BLOCK_SUSPEND rights to
> > "string".  If any user can run that program, there's nothing the kernel
> > can do about this, right?  Just don't allow that program on the system :)
> >
> > > The string program writes to stdout, which means that it writes to
> > > wake_lock. So an unpriviledged opener can trick an priviledged writer
> > > for writing sysfs.
> >
> > That sounds like a userspace program that was somehow given incorrect
> > rights by the admin, and a user is taking advantage of it.  That's not
> > the kernel's fault.
> 
> Isn't it? Pretty much any setuid program will write to stdout or
> stderr; even the glibc linker code does so if you set LD_DEBUG.
> (Normally the output isn't entirely attacker-controlled, but it is in
> the case of stuff like "procmail", which I think Debian still ships as
> setuid root.) setuid programs should always be able to safely call
> read() and write() on caller-provided file descriptors. Also, you're
> supposed to be able to receive file descriptors over unix domain
> sockets and then write to them without trusting the sender. Basically,
> the ->read and ->write VFS handlers should never look at the caller's
> credentials, only the opener's (with the exception of LSMs, which tend
> to do weird things to the system's security model).

So a root program gets the file handle to the sysfs file and then passes
it off to a setuid program and the kernel should somehow protect from
this?

I think that any sysfs file that is relying on the capable() check
should just set their permissions properly first, and then it should be
ok.

thanks,

greg k-h
