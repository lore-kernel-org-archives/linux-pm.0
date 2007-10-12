From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 0/2 -mm] kexec based hibernation -v5
Date: Fri, 12 Oct 2007 11:19:32 +0800
Message-ID: <1192159172.17539.26.camel__3255.87680931694$1192159297$gmane$org@caritas-dev.intel.com>
References: <1192068833.27482.13.camel@caritas-dev.intel.com>
	<200710111217.58473.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710111217.58473.rjw@sisk.pl>
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

On Thu, 2007-10-11 at 12:17 +0200, Rafael J. Wysocki wrote:
> On Thursday, 11 October 2007 04:13, Huang, Ying wrote:
> > Kexec base hibernation has some potential advantages over uswsusp and
> > TuxOnIce (suspend2). Some most obvious advantages are:
> 
> Well, I have some doubts as far as the obviousness is concerned.

OK, I will remove the "obvious".

> > 1. The hibernation image size can exceed half of memory size easily.
> 
> This is also possible with TuxOnIce.

I will add detail description about this. It is possible with TuxOnIce,
and hard with u/swsusp.

> 
> > 2. The hibernation image can be written to and read from almost
> >    anywhere, such as USB disk, NFS.
> 
> This is possible with uswsusp, at least in theory, probably with TuxOnIce too.

I will remove this.

> > 3. It is possible to eliminate freezer from kexec based hibernation
> >    implementation.
> 
> This isn't true as long as we have not changed the handling of devices
> (which is in the works, but will take time).

I know it has not been implemented yet. I just say that it is possible
for khibernation and it is almost impossible for u/swsusp and TuxOnIce.

> > 4. Based on kexec/kdump implementation, the kernel code needed is
> >    less.
> 
> Well, maybe.
> 

Best Regards,
Huang Ying
