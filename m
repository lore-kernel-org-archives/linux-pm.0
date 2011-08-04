From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] PM: add statistics sysfs file for suspend to
 ram
Date: Thu, 4 Aug 2011 12:17:28 -0700
Message-ID: <20110804121728.9280c9af.rdunlap@xenotime.net>
References: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E5741@shsmsx502.ccr.corp.intel.com>
	<alpine.LFD.2.02.1108041503440.24626@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1108041503440.24626@x980>
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
Cc: "Liu, ShuoX" <shuox.liu@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "gregkh@suse.de" <gregkh@suse.de>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 04 Aug 2011 15:05:10 -0400 (EDT) Len Brown wrote:

> > Record S3 failure time about each reason and the latest two failed
> > devices' name in S3 progress.
> > We can check it through /sys/power/suspend_stats.
> 
> these sound more like debugfs than sysfs things.

debugfs also allows more than one value per file, like I think
I saw in this patch.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
