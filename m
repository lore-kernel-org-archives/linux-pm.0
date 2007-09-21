From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [RFC][PATCH 0/2 -mm] kexec based hibernation -v3
Date: Fri, 21 Sep 2007 16:47:11 +0800
Message-ID: <1190364431.21818.186.camel__27795.1524280526$1190364391$gmane$org@caritas-dev.intel.com>
References: <1190266440.21818.16.camel@caritas-dev.intel.com>
	<200709211043.38266.stefan@loplof.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709211043.38266.stefan@loplof.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stefan Rompf <stefan@loplof.de>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-09-21 at 10:43 +0200, Stefan Rompf wrote:
> Am Donnerstag, 20. September 2007 07:34 schrieb Huang, Ying:
> 
> > The hibernation procedure with the patch set is as follow:
> >
> > 1. Boot a kernel A
> >
> > 2. Work under kernel A
> >
> > 3. Kexec another kernel B (crash dump enabled) in kernel A.
> 
> From a short glance over current Linus' arch/i386/kernel/machine_kexec.c, 
> memory for the crash dump kernel B still needs to be reserved statically when 
> booting A.
> 
> This is one of the biggest issues with kexec based hibernation. For the 
> typical notebook user, it is totally unacceptable to reserve 16 megabytes of 
> memory just to be able to suspend to disk. And given the fact that current 
> distribution kernels are quite modular and require early module loading, even 
> more memory might be needed.
> 
> IMHO, a plan how to fix this must exist or the concept of kexec based 
> hibernation is a waste of time.

This issue has been resolved. The implementation method details in
another mail with title as follow:

[RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump

Best Regards,
Huang Ying
