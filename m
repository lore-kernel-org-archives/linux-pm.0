From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
	ahci_start_engine compliant to AHCI spec"
Date: Wed, 18 May 2011 21:44:37 +0200
Message-ID: <201105182144.37713.rjw__9543.23679111457$1305747956$gmane$org@sisk.pl>
References: <201105120025.34531.rjw@sisk.pl> <20633.1305565337@localhost>
	<BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jian Peng <jipeng2005@gmail.com>
Cc: Valdis.Kletnieks@vt.edu, Michael Leun <lkml20100708@newton.leun.net>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 18, 2011, Jian Peng wrote:
> Hi, Valdis/Rafael/Michael,
> 
> Could you help me test the following change?
> 
> After reverting 81ca7e4, add 5ms delay as follow since that seems also
> fixing the issue on my SATA host controller that requires 81ca7e4.
> 
> In drivers/ata/libahci.c, inside ahci_hardreset() function,
> 
> 
> 1333 <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1333>
> ahci_start_engine
> <http://lxr.linux.no/linux+*/+code=ahci_start_engine>(ap
> <http://lxr.linux.no/linux+*/+code=ap>);
> 
>             msleep(5);1334
> <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1334>1335
> <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1335>        if
> (online <http://lxr.linux.no/linux+*/+code=online>)1336
> <http://lxr.linux.no/linux+*/drivers/ata/libahci.c#L1336>
>   *class <http://lxr.linux.no/linux+*/+code=class> = ahci_dev_classify
> <http://lxr.linux.no/linux+*/+code=ahci_dev_classify>(ap
> <http://lxr.linux.no/linux+*/+code=ap>);
> 
> Since my host controller requires time to switch internal state to be ready.
> Please let me know your testing result.

Could you simply post a patch?

Rafael
