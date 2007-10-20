From: "huang ying" <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 0/2 -mm] kexec based hibernation -v5
Date: Sat, 20 Oct 2007 13:50:10 +0800
Message-ID: <851fc09e0710192250k7c2d5269rf6bf1ec604a23603__8116.85499870709$1192859493$gmane$org@mail.gmail.com>
References: <1192068833.27482.13.camel@caritas-dev.intel.com>
	<47190B28.6070405@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47190B28.6070405@cfl.rr.com>
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
To: Phillip Susi <psusi@cfl.rr.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On 10/20/07, Phillip Susi <psusi@cfl.rr.com> wrote:
> Huang, Ying wrote:
> > The hibernation procedure with the patch set is as follow:
> >
> > 1. Boot a kernel A
> >
> > 2. Work under kernel A
> >
> > 3. Kexec another kernel B (crash dump enabled) in kernel A.
> >
> > 4. Save the memory image of kernel A through crash dump (such as "cp
> >    /proc/vmcore ~"). Save the "jump back entry".
>
> Doesn't this also save the memory of kernel B?

The memory area of kernel B is excluded from the elf header of
/proc/vmcore. This is done in kexec-tools (/sbin/kexec) patches.

> > 5. Shutdown or reboot
> >
> >
> > The restore process with the patch set is as follow:
> >
> > 1. Boot a kernel C (crash dump enabled), the memory area used by
> >    kernel C must be a subset of memory area used by kernel B.
>
> Why is a third kernel needed?  Why can't kernel B be used for this as
> well?  In fact, if kernel A has been compiled to be relocatable and
> crash dump enabled, why wouldn't it suffice for all 3 instances?

One kernel can be used for three situation. In fact, I use just one
kernel for testing.

Best Regards,
Huang Ying
