From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: BUG: using smp_processor_id() in preemptible code:
	s2disk
Date: Mon, 14 Jun 2010 01:36:18 +0200
Message-ID: <201006140136.18652.rjw__7576.2705332183$1276472444$gmane$org@sisk.pl>
References: <20100613203352.GA3577@swordfish>
	<1276461183.2659.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276461183.2659.4.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday, June 13, 2010, Maxim Levitsky wrote:
> On Sun, 2010-06-13 at 23:33 +0300, Sergey Senozhatsky wrote: 
> > Hello,
> > 
> > .35-rc3, x86
> > 
> > Hit the following error today:
> 
> I confirm the same issue. Sorry for not reporting it earlier.

It looks like a cpufreq issue to me, but it may be related to CPU hotplug as
well.  I'm not sure who's been messing up with that recently, though.

Rafael
