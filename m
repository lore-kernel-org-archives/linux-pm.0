From: Patrick <ragamuffin@datacomm.ch>
Subject: Re: >3G => iommu => suspend problems -- was Re: SB600
	AHCI: Hard	Disk Corruption
Date: Thu, 03 Jul 2008 19:35:47 +0200
Message-ID: <1215106548.5194.22.camel@localhost.localdomain>
References: <1211717435.6038.53.camel@localhost.localdomain>
	<200806090036.32267.rjw@sisk.pl>
	<1213184587.6376.37.camel@localhost.localdomain>
	<200806111638.50933.rjw@sisk.pl>  <484FE97D.4040805@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <484FE97D.4040805@firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

*bump*

Why "too late" ??? It (2.6.26) is still not out! Please (;-) oh please!)
reconsider / push it a bit! It's tested and working perfectly here ever
since. But I'd like for example vmware to work again as will and it
doesn't yet even with 2.6.25... Please let this patch go into 2.6.26 so
there's a chance of having a stock kernel with working vmware, fglrx,
and such again soon!

Thx

Greets - Patrick

On Mit, 2008-06-11 at 17:04 +0200, Andi Kleen wrote:
> > Well, I was hoping to be able to get this patch into 2.6.26, as I don't really
> > like the temporary hack, preventing the affected systems from resuming
> > at all, that we have in there, but it seems to be too late. :-(
> 
> I agree with you that this patch would be far better than the hack.
> 
> -Andi
