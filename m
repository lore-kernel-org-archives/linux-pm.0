From: James Morris <jmorris@namei.org>
Subject: Re: linux-next: Tree for May 6 (acpi: PM=n)
Date: Fri, 7 May 2010 09:27:49 +1000 (EST)
Message-ID: <alpine.LRH.2.00.1005070910490.31779__49135.9585118063$1273247773$gmane$org@tundra.namei.org>
References: <20100506151502.f97afe54.sfr@canb.auug.org.au>
	<20100506080538.b566f50e.randy.dunlap@oracle.com>
	<alpine.LFD.2.00.1005061623060.15286@localhost.localdomain>
	<20100506133215.f5dc579a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100506133215.f5dc579a.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Rajiv Andrade <srajiv@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, linux-pm@lists.linux-foundation.org, Mimi Zohar <zohar@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 6 May 2010, Randy Dunlap wrote:

> On Thu, 06 May 2010 16:26:13 -0400 (EDT) Len Brown wrote:
> 
> > > When CONFIG_PM is not set:
> > > 
> > > drivers/built-in.o: In function `acpi_init':
> > > bus.c:(.init.text+0x2d84): undefined reference to `pm_flags'
> > > bus.c:(.init.text+0x2d91): undefined reference to `pm_flags'
> > 
> > CONFIG_ACPI depends on CONFIG_PM,
> > so acpi/bus.c should not be compiled for CONFIG_PM=n
> > 
> > Hmm, is is somebody doing something strange, like "select ACPI"
> > without guaranteeing that all of ACPI's dependencies are satisfied?
> 
> Oh, thanks for the clue.
> 
> That would be a patch that I commented on and was ignored,
> but James Morris merged it anyway.  Now it should be dropped.
> 
> http://lkml.org/lkml/2010/5/4/379

You weren't ignored.  Mimi responded and mentioned a subsequent patch, 
after which, there was no further discussion.

I've reverted:

b89e66e1e396f7b5436af154e58209320cc08aed
"TPM: ACPI/PNP dependency removal"

a674fa46c79ffa37995bd1c8e4daa2b3be5a95ae
"ima: remove ACPI dependency"


Note: any further ACPI-related changes here should have acks from 
linux-acpi folk.



- James
-- 
James Morris
<jmorris@namei.org>
