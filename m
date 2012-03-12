From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/3] cpuidle: Add a debugfs entry to disable
 specific C state for debug purpose.
Date: Mon, 12 Mar 2012 20:46:30 +0000
Message-ID: <20120312204629.GA22929@srcf.ucam.org>
References: <20120305101827.GA19408@khazad-dum.debian.net>
	<CAGF5oy_BUytjeDa8Oc62pRabaEqwqKCFuVJuzLd-XNZg34ne2w@mail.gmail.com>
	<1330998885.1916.89.camel@ymzhang>
	<20120306052236.GA19416@kroah.com>
	<1331013078.1916.103.camel@ymzhang>
	<20120306143935.GA23346@kroah.com>
	<1331082051.1916.124.camel@ymzhang>
	<20120308180106.GD26516@kroah.com> <4F5DBFA8.3080300@intel.com>
	<4F5DC01D.7040006@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4F5DC01D.7040006@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ShuoX Liu <shuox.liu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "H. Peter Anvin" <hpa@zytor.com>, "Kleen, Andi" <andi.kleen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 12, 2012 at 05:21:33PM +0800, ShuoX Liu wrote:

> In addition, C state might have much impact on performance tuning,
> as it takes
> much time to enter/exit C states, which might delay interrupt
> processing. With
> the new debug option, developers could check if a deep C state could impact
> performance and how much impact it could cause.

Would anyone doing performance tuning not be using the cpu_dma_latency 
interface?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
