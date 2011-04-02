From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 16/18] 2.6.40: x86 idle APM: remove
 deprecated apm_cpu_idle()
Date: Sat, 2 Apr 2011 22:00:21 +0100
Message-ID: <20110402220021.74ecdb5b__13128.0798269019$1301778054$gmane$org@lxorguk.ukuu.org.uk>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
	<5d9716021b20302ece48fd486bbad9bcb2502353.1301724243.git.len.brown@intel.com>
	<20110402124054.49c3a3f4@lxorguk.ukuu.org.uk>
	<alpine.LFD.2.02.1104021529580.18682@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1104021529580.18682@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> This patch series was posted in reply to a table of contents
> 
> https://lkml.org/lkml/2011/4/2/8
> 
> "By the end of this series, pm_idle is removed as a public
>  x86 idle-loop registration mechanism.  A few other things are
>  cleaned up in the process."

Ok so lets rewind a bit - why do we want to remove pm_idle rather than
just fix up the way registration occurs. It's just a symbol, one trivial
interface that is exported and perhaps wants the export method tidying up.

> Trinabh also replied to you, pointing one of the previous
> LKML discussions about the mis-use of pm_idle.

And there are misuses of just about every kernel symbol - kmalloc for
example causes some people a lot of trouble !

> We'll create a new APM cpuidle driver in Linux (Trinabh prototyped one),
> and at the same time, schedule it for removal in a year.  Personally,
> I think it is make-work, and in real-life it is more likely to do
> more harm than removing apm_idle, but I don't want to stand in the
> way of process.

So you could just leave it alone - that's less work, less disruption and
doesn't do any harm at all.

As I read this the plan at the moment otherwise is

	- churn up all the code
	- remove PM idle hook
	- rewrite the APM code
	- replace the APM code

whereas you could just leave the symbol exported or even just a hook to
make people to do it right using:

	int register_pm_idle(function);

Simples yes ?

and then wait a year

For that matter instead of writing a new driver you could just stuff APM
into same hooks we have for virtualisation !

This whole patch series appears to be a giant piece of pointless makework.

Alan
