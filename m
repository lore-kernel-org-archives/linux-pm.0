From: joeyli <jlee@suse.com>
Subject: Re: [PATCH 2/2] PM / Sleep: Check the file capability when writing
 wake lock interface
Date: Mon, 31 Dec 2018 17:38:51 +0800
Message-ID: <20181231093851.GN3506@linux-l9pv.suse>
References: <20181230132856.24095-1-jlee@suse.com>
 <20181230132856.24095-3-jlee@suse.com>
 <20181230144835.GB18985@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181230144835.GB18985@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, Joe Perches <joe@perches.com>, Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Greg,

On Sun, Dec 30, 2018 at 03:48:35PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Dec 30, 2018 at 09:28:56PM +0800, Lee, Chun-Yi wrote:
> > The wake lock/unlock sysfs interfaces check that the writer must has
> > CAP_BLOCK_SUSPEND capability. But the checking logic can be bypassed
> > by opening sysfs file within an unprivileged process and then writing
> > the file within a privileged process. The tricking way has been exposed
> > by Andy Lutomirski in CVE-2013-1959.
> 
> Don't you mean "open by privileged and then written by unprivileged?"
> Or if not, exactly how is this a problem?  You check the capabilities
> when you do the write and if that is not allowed then, well
>

Sorry for I didn't provide clear explanation.

The privileged means CAP_BLOCK_SUSPEND but not file permission. The file permission
has already relaxed for non-root user. Then the expected behavior is that non-root
process must has CAP_BLOCK_SUSPEND capability for writing wake_lock sysfs.

But, the CAP_BLOCK_SUSPEND restrict can be bypassed:

int main(int argc, char* argv[])
{
        int fd, ret = 0;

        fd = open("/sys/power/wake_lock", O_RDWR);
        if (fd < 0)
                err(1, "open wake_lock");

        if (dup2(fd, 1) != 1)	// overwrite the stdout with wake_lock
                err(1, "dup2");
        sleep(1);
        execl("./string", "string");	//string has capability

        return ret;
}

This program is an unpriviledged process (has no CAP_BLOCK_SUSPEND), it opened
wake_lock sysfs and overwrited stdout. Then it executes the "string" program
that has CAP_BLOCK_SUSPEND. The string program writes to stdout, which means
that it writes to wake_lock. So an unpriviledged opener can trick an priviledged
writer for writing sysfs.  
 
> And you are checking the namespace of the person trying to do the write
> when the write happens, which is correct here, right?
> 
> If you really want to mess with wake locks in a namespaced environment,
> then put it in a real namespaced environment, which is {HUGE HINT} not
> sysfs.
>

I don't want to mess with wake locks in namespace.
 
> So no, this patch isn't ok...
>

Thanks a lot!
Joey Lee 
