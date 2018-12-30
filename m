From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] PM / Sleep: Check the file capability when writing
 wake lock interface
Date: Sun, 30 Dec 2018 15:48:35 +0100
Message-ID: <20181230144835.GB18985@kroah.com>
References: <20181230132856.24095-1-jlee@suse.com>
 <20181230132856.24095-3-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181230132856.24095-3-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, Joe Perches <joe@perches.com>, Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Chen Yu <yu.c.chen@intel.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 30, 2018 at 09:28:56PM +0800, Lee, Chun-Yi wrote:
> The wake lock/unlock sysfs interfaces check that the writer must has
> CAP_BLOCK_SUSPEND capability. But the checking logic can be bypassed
> by opening sysfs file within an unprivileged process and then writing
> the file within a privileged process. The tricking way has been exposed
> by Andy Lutomirski in CVE-2013-1959.

Don't you mean "open by privileged and then written by unprivileged?"
Or if not, exactly how is this a problem?  You check the capabilities
when you do the write and if that is not allowed then, well

And you are checking the namespace of the person trying to do the write
when the write happens, which is correct here, right?

If you really want to mess with wake locks in a namespaced environment,
then put it in a real namespaced environment, which is {HUGE HINT} not
sysfs.

So no, this patch isn't ok...

thanks,

greg k-h
