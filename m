From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] OMAP: omap_device: fix !CONFIG_SUSPEND case
	in _noirq handlers
Date: Thu, 01 Sep 2011 20:22:01 +0200
Message-ID: <1876183.c78P8V3ZbL__47348.3730726459$1314925476$gmane$org@wuerfel>
References: <1314900722-10252-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314900722-10252-1-git-send-email-khilman@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 01 September 2011 11:12:02 Kevin Hilman wrote:
> The suspend/resume _noirq handlers were #ifdef'd out in the
> !CONFIG_SUSPEND case, but were still assigned to the dev_pm_ops
> struct.  Fix by defining them to NULL in the !CONFIG_SUSPEND case.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thansk for the fast response!
