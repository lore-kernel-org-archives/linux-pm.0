From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 0/3] sdhci runtime_pm implementation using
	mmc clock	gating fw
Date: Sun, 6 Feb 2011 20:35:20 +0000
Message-ID: <20110206203520.GB23366__21115.4252560393$1297024586$gmane$org@void.printf.net>
References: <cover.1297014479.git.pierre.tardy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1297014479.git.pierre.tardy@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Tardy <pierre.tardy@intel.com>
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Pierre,

On Sun, Feb 06, 2011 at 07:02:47PM +0100, Pierre Tardy wrote:
> Please find a simple sdhci runtime_pm implementation
> that uses clock gating fw as a tip to know when 
> our chip is idle.
> 
> Previous version was RFC and untested,
> This version has been tested on intel medfield platform.
> 
> Pierre Tardy (2):
>   mmc: put the led blinking code after clock ungating
>   sdhci:v2:use ios->clock to know when sdhci is idle
> 
> Yunpeng Gao (1):
>   sdhci-pci : Enable runtime PM support

Thanks very much, pushed to mmc-next with Linus W's ACK.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
