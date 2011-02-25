From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2 2/3] sdhci-pci : Enable runtime PM support
Date: Fri, 25 Feb 2011 14:54:40 +0000
Message-ID: <20110225145440.GA31620__47027.2803366699$1298646009$gmane$org@srcf.ucam.org>
References: <cover.1297014479.git.pierre.tardy@intel.com>
	<6722fa7986194808f4d69a1e5ba6d3f163b77da9.1297014479.git.pierre.tardy@intel.com>
	<20110210043718.GA7585@void.printf.net>
	<AANLkTi=iZ3dzAoRuRdpvQ=uBp4u8O8LtMuu2XdSWeZwr@mail.gmail.com>
	<20110221204523.GA28419@void.printf.net>
	<8250E4885F9967469CAC3FB5CBA2CE69935212DEA0@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8250E4885F9967469CAC3FB5CBA2CE69935212DEA0@irsmsx501.ger.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Tardy, Pierre" <pierre.tardy@intel.com>
Cc: Pierre Tardy <tardyp@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Chris Ball <cjb@laptop.org>, "Gao,
	Yunpeng" <yunpeng.gao@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 25, 2011 at 07:33:12AM +0000, Tardy, Pierre wrote:

> My understanding is the pci driver is not supposed to do any set_power_state/pci_save_state/wake_enable.
> Everything is supposed to be generically handle by pci frameworks's runtime_pm impl.
> Need confirmation from Rafael.

The core can only enable PME generation, it can't configure what 
generates PMEs. There's a register in sdhci that needs to be programmed 
to enable wakeups on card insert/removal/interrupt. If you don't then 
you won't get a PME no matter what the core does.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
