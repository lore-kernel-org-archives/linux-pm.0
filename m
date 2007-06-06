From: Tejun Heo <teheo@suse.de>
Subject: Re: [PATCH] sata_promise: use TF interface for polling
	NODATA commands
Date: Wed, 06 Jun 2007 19:19:28 +0900
Message-ID: <46668A30.2040907@suse.de>
References: <46608E3F.4060201@dgreaves.com> <200706012342.45657.rjw@sisk.pl>
	<46609FAD.7010203@dgreaves.com> <200706020122.49989.rjw@sisk.pl>
	<4661EFBB.5010406@dgreaves.com>
	<alpine.LFD.0.98.0706021538360.23741@woody.linux-foundation.org>
	<4662D852.4000005@dgreaves.com> <46667160.80905@gmail.com>
	<20070606101837.GC29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070606101837.GC29122@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <htejun@gmail.com>
Cc: netdev@oss.sgi.com, mikpe@it.uu.se, Neil Brown <neilb@suse.de>, David Greaves <david@dgreaves.com>, linux-pm <linux-pm@lists.osdl.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Tejun Heo wrote:
> sata_promise uses two different command modes - packet and TF.  Packet
> mode is intelligent low-overhead mode while TF is the same old
> taskfile interface.  As with other advanced interface (ahci/sil24),
> ATA_TFLAG_POLLING has no effect in packet mode.  However, PIO commands
> are issued using TF interface in polling mode, so pdc_interrupt()
> considers interrupts spurious if ATA_TFLAG_POLLING is set.
> 
> This is broken for polling NODATA commands because command is issued
> using packet mode but the interrupt handler ignores it due to
> ATA_TFLAG_POLLING.  Fix pdc_qc_issue_prot() such that ATA/ATAPI NODATA
> commands are issued using TF interface if ATA_TFLAG_POLLING is set.
> 
> This patch fixes detection failure introduced by polling SETXFERMODE.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Eeeek... Wrong thread.  Please ignore this posting.  Will repost.  Sorry.

-- 
tejun
