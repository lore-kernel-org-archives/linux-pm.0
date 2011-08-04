From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] PM: add statistics sysfs file for suspend to
	ram
Date: Thu, 04 Aug 2011 15:05:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1108041503440.24626@x980>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E5741@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E5741@shsmsx502.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Liu, ShuoX" <shuox.liu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "gregkh@suse.de" <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org

> Record S3 failure time about each reason and the latest two failed
> devices' name in S3 progress.
> We can check it through /sys/power/suspend_stats.

these sound more like debugfs than sysfs things.

-Len Brown
Intel Open Source Technlogy Center
