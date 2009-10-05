From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 15/21] kernel/power/: use pr_<level> and add
	pr_fmt(fmt)
Date: Mon, 5 Oct 2009 21:43:37 +0200
Message-ID: <200910052143.37985.rjw@sisk.pl>
References: <cover.1254701151.git.joe@perches.com>
	<17906d40d7b002380e893d49639ba3f1e7bdb3a0.1254701151.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <17906d40d7b002380e893d49639ba3f1e7bdb3a0.1254701151.git.joe@perches.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 05 October 2009, Joe Perches wrote:
> Added #define pr_fmt(fmt) "PM: " fmt
> Converted printk(KERN_<level> to pr_<level>(
> Removed "PM: " prefix
> Added pr_fmt() to __initdata strings

Well, can you please tell me what actually is wrong with the current code?

Rafael


> Signed-off-by: Joe Perches <joe@perches.com>
> ---
