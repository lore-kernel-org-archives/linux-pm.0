From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3] cpuidle: Add a sysfs entry to disable
 specific C state for debug purpose.
Date: Mon, 12 Mar 2012 18:11:51 +0000
Message-ID: <20120312181151.GE14020@sirena.org.uk>
References: <20120302142303.648285a7.akpm@linux-foundation.org>
	<C6CB66606345BC4B80CBE69D22ABFBB10220E1@SHSMSX101.ccr.corp.intel.com>
	<4F545A4E.8010801@linux.vnet.ibm.com> <4F5466C4.2090808@intel.com>
	<20120305101827.GA19408@khazad-dum.debian.net>
	<CAGF5oy_BUytjeDa8Oc62pRabaEqwqKCFuVJuzLd-XNZg34ne2w@mail.gmail.com>
	<1330998885.1916.89.camel@ymzhang>
	<20120306052236.GA19416@kroah.com>
	<1331013078.1916.103.camel@ymzhang>
	<20120306143935.GA23346@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120306143935.GA23346@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Brown, Len" <len.brown@intel.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, ShuoX Liu <shuox.liu@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "H. Peter Anvin" <hpa@zytor.com>, andi.kleen@intel.com, Ingo Molnar <mingo@elte.hu>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 06, 2012 at 06:39:35AM -0800, Greg KH wrote:

> Do you know of any tools using these files?  I have never heard of them,
> and I was told we should move these files years ago.  So I don't think
> there should be any api issues.

powertop uses them.
