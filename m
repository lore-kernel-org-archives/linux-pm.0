From: "huang ying" <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 4/4 -mm] kexec based hibernation -v7 :
	kimgcore
Date: Fri, 7 Dec 2007 21:56:18 +0800
Message-ID: <851fc09e0712070556g13741a0vc56348ffbbb57a1d__44137.069831095$1197035857$gmane$org@mail.gmail.com>
References: <1197042824.24045.64.camel@caritas-dev.intel.com>
	<200712071333.06836.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712071333.06836.rjw@sisk.pl>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Dec 7, 2007 8:33 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, 7 of December 2007, Huang, Ying wrote:
> > This patch adds a file in proc file system to access the loaded
> > kexec_image, which may contains the memory image of kexeced
> > system. This can be used by kexec based hibernation to create a file
> > image of hibernating kernel, so that a kernel booting process is not
> > needed for each hibernating.
>
> Hm, I'm not sure what you mean.
>
> Can you explain a bit, please?

The normal kexec based hibernation procedure is as follow:

1. kexec_load the kernel image and initramfs
2. jump to hibernating kernel
3. the normal boot process of kexeced kernel
4. jump back to hibernated kernel
5. execute ACPI methods
6. jump to hibernating kernel
7. write memory image of hibernated kernel
8. go to ACPI S4 state

With kimgcore:

A. Prepare a memory image of hibernation kernel:

A.1 kexec_load the kernel image and initramfs
A.2 jump to hibernating kernel
A.3 the normal boot process of kexeced kernel
A.4 jump back to hibernated kernel
A.5 save the memory image of hibernating kernel via kimgcore

The normal hibernate process is as follow:

1. kexec load the kimgcore of hibernatin kernel
2. jump to the hibernating kernel
3. execute ACPI methods
4. jump to hibernating kernel
5. write memory image of hibernated kernel
6. go to ACPI S4 state

So the boot process of hibernating kernel needs only once unless the
hardware configuration is changed.

Best Regards,
Huang Ying
