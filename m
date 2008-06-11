From: Andi Kleen <andi@firstfloor.org>
Subject: Re: >3G => iommu => suspend problems -- was Re: SB600
 AHCI: Hard Disk Corruption
Date: Wed, 11 Jun 2008 17:04:29 +0200
Message-ID: <484FE97D.4040805@firstfloor.org>
References: <1211717435.6038.53.camel@localhost.localdomain>
	<200806090036.32267.rjw@sisk.pl>
	<1213184587.6376.37.camel@localhost.localdomain>
	<200806111638.50933.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806111638.50933.rjw@sisk.pl>
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
Cc: Patrick <ragamuffin@datacomm.ch>, Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> Well, I was hoping to be able to get this patch into 2.6.26, as I don't really
> like the temporary hack, preventing the affected systems from resuming
> at all, that we have in there, but it seems to be too late. :-(

I agree with you that this patch would be far better than the hack.

-Andi
