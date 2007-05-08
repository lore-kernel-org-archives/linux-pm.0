From: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: 2.6.21 -- Forced to hard power off from attempted
	hibernation
Date: Tue, 8 May 2007 09:36:11 -0700
Message-ID: <a44ae5cd0705080936q6f17a4f0x7ca6d06a4923dcdb@mail.gmail.com>
References: <a44ae5cd0705080009l2e7bac9ayc379acdfe17e2507@mail.gmail.com>
	<200705081224.48600.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705081224.48600.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, lkml@kernel.org
List-Id: linux-pm@vger.kernel.org

Sorry, Rafael.  "Reply all" this time.

On 5/8/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> On Tuesday, 8 May 2007 09:09, Miles Lane wrote:
> > Hello,
> >
> > When I tried to hibernate my laptop (HP Pavilion dv1240us), everything
> > seemed to be working,  but the power never shut off.  I had to hold
> > down the power button for five seconds.
>
> Does the log below finish where the machine hanged?

It's odd.  I thought that the hang must have occurred down...

> > [ 2815.639718] pci 0000:00:00.1: LATE freeze
> > [ 2815.639718] agpgart-intel 0000:00:00.0: LATE freeze
> > [ 2815.639718] swsusp: critical section:
> > [ 2815.639718] swsusp: Need to copy 124696 pages
> > [ 2815.639718] swsusp: Normal pages needed: 114475 + 1024 + 24,
> > available pages: 118745

<<< HERE >>>

> > [ 2815.639718] Intel machine check architecture supported.
> > [ 2815.639718] Intel machine check reporting enabled on CPU#0.
> > [ 2815.639718] agpgart-intel 0000:00:00.0: EARLY resume
> > [ 2815.639718] PCI: Calling quirk c01be2f7 for 0000:00:00.0
> > [ 2815.639718] pci 0000:00:00.1: EARLY resume
> > [ 2815.639718] PCI: Calling quirk c01be2f7 for 0000:00:00.1
> > [ 2815.639718] pci 0000:00:00.3: EARLY resume

Since this is where the suspend process seems to complete and the
resume begins.  I waited for a bit before hitting the power button.
But the log doesn't indicate any lapse in time.  I don't know what to
make of that.  I will try to reproduce and check the time immediately
before I initiate the hibernation process.  Hopefully this will help
me interpret what is in the log.  Also, I'll make sure to let several
seconds elapse before hitting the power button and starting the resume
process.

         Miles
