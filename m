From: Len Brown <lenb@kernel.org>
Subject: Re: linux-next: Tree for May 6 (acpi: PM=n)
Date: Thu, 06 May 2010 16:26:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005061623060.15286__32967.1261054047$1273177713$gmane$org@localhost.localdomain>
References: <20100506151502.f97afe54.sfr@canb.auug.org.au>
	<20100506080538.b566f50e.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20100506080538.b566f50e.randy.dunlap@oracle.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@lists.linux-foundation.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> When CONFIG_PM is not set:
> 
> drivers/built-in.o: In function `acpi_init':
> bus.c:(.init.text+0x2d84): undefined reference to `pm_flags'
> bus.c:(.init.text+0x2d91): undefined reference to `pm_flags'

CONFIG_ACPI depends on CONFIG_PM,
so acpi/bus.c should not be compiled for CONFIG_PM=n

Hmm, is is somebody doing something strange, like "select ACPI"
without guaranteeing that all of ACPI's dependencies are satisfied?

thanks,
Len Brown, Intel Open Source Technology Center
