From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.21-rc1
Date: Tue, 1 Jan 2019 15:15:31 -0800
Message-ID: <20190101231526.GA7944@localhost.localdomain>
References: <20190101160503.GA3306@localhost.localdomain>
 <CAHk-=whXWWXSMMPpm3eGV=PL12=K5LFM3didLBuGy1Y7vUbXVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=whXWWXSMMPpm3eGV=PL12=K5LFM3didLBuGy1Y7vUbXVg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rui Zhang <rui.zhang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 01, 2019 at 01:35:36PM -0800, Linus Torvalds wrote:
> On Tue, Jan 1, 2019 at 8:05 AM Eduardo Valentin <edubezval@gmail.com> wrote:
> >
> > Please consider pulling from
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus
> 
> No.
> 
> I pulled and immediately unpulled again.
> 

hmm... ok I am double checking.

> It doesn't even build cleanly.
> 

Do you still have have a copy of the build error? 

The local tests I did were not enough to see this error,
neither were the kernel CI builds. Only failed build was
on something completely unrelated (ARC) to these
changes:
Full Build Summary:
https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.20-rc5-42-g055ddb633a35/



>                 Linus
