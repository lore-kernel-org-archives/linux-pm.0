From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for May 6 (acpi: PM=n)
Date: Thu, 6 May 2010 13:32:15 -0700
Message-ID: <20100506133215.f5dc579a.randy.dunlap__15340.6174191788$1273178099$gmane$org@oracle.com>
References: <20100506151502.f97afe54.sfr@canb.auug.org.au>
	<20100506080538.b566f50e.randy.dunlap@oracle.com>
	<alpine.LFD.2.00.1005061623060.15286@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1005061623060.15286@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>, James Morris <jmorris@namei.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@lists.linux-foundation.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 06 May 2010 16:26:13 -0400 (EDT) Len Brown wrote:

> > When CONFIG_PM is not set:
> > 
> > drivers/built-in.o: In function `acpi_init':
> > bus.c:(.init.text+0x2d84): undefined reference to `pm_flags'
> > bus.c:(.init.text+0x2d91): undefined reference to `pm_flags'
> 
> CONFIG_ACPI depends on CONFIG_PM,
> so acpi/bus.c should not be compiled for CONFIG_PM=n
> 
> Hmm, is is somebody doing something strange, like "select ACPI"
> without guaranteeing that all of ACPI's dependencies are satisfied?

Oh, thanks for the clue.

That would be a patch that I commented on and was ignored,
but James Morris merged it anyway.  Now it should be dropped.

http://lkml.org/lkml/2010/5/4/379

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
