From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 0/3 -mm] kexec jump -v8
Date: Fri, 21 Dec 2007 16:53:27 +0800
Message-ID: <1198227207.25346.11.camel__43959.4792006121$1198227658$gmane$org@caritas-dev.intel.com>
References: <1198222399.1965.15.camel@caritas-dev.intel.com>
	<476B7ACF.8020602@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <476B7ACF.8020602@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@nigel.suspend2.net
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2007-12-21 at 19:35 +1100, Nigel Cunningham wrote:
> Hi.
> 
> Huang, Ying wrote:
> > This patchset provides an enhancement to kexec/kdump. It implements
> > the following features:
> > 
> > - Backup/restore memory used both by the original kernel and the
> >   kexeced kernel.
> 
> Why the kexeced kernel as well?

The memory range used by kexeced kernel is also the usable memory range
in original kernel. Maybe should be: backup/restore memory used by both
the original kernel and the kexeced kernel. My English is poor.

> [...]
> 
> > The features of this patchset can be used as follow:
> > 
> > - Kernel/system debug through making system snapshot. You can make
> >   system snapshot, jump back, do some thing and make another system
> >   snapshot.
> 
> Are you somehow recording all the filesystem changes after the first
> snapshot? If not, this is pointless (you'll end up with filesystem
> corruption).

This snapshot is not used for restore/resume. It is just used for
debugging. You can check the system state with these snapshots. So I
think it is useful even without recording filesystem changes.

> [...]
> 
> > - Cooperative multi-kernel/system. With kexec jump, you can switch
> >   between several kernels/systems quickly without boot process except
> >   the first time. This appears like swap a whole kernel/system out/in.
> 
> How is this useful to the end user?

I am not sure how useful is this. Maybe I can run a Redhat and a Debian
on my machine and switch between them.

Best Regards,
Huang Ying
