From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/3] sdhci runtime_pm implementation using
 mmc clock gating fw
Date: Sun, 6 Feb 2011 19:54:11 +0100
Message-ID: <AANLkTinzhhZMC=dRhC5PbeK98UH8ZkOKMriEq0cU6g=q__20197.1158771359$1297097673$gmane$org@mail.gmail.com>
References: <cover.1297014479.git.pierre.tardy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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

2011/2/6 Pierre Tardy <pierre.tardy@intel.com>:

> Please find a simple sdhci runtime_pm implementation
> that uses clock gating fw as a tip to know when
> our chip is idle.

I like this approach, the gated clock hints to rpm that it's time
to idle the device. Great work.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

For all patches.

Thanks,
Linus Walleij
