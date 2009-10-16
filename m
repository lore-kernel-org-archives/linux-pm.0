From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: [PATCH] CPUidle: always return with interrupts
	enabled
Date: Fri, 16 Oct 2009 17:25:04 +0100
Message-ID: <20091016162504.GC1391__12394.1174861558$1255715523$gmane$org@deprecation.cyrius.com>
References: <1254332153-23493-1-git-send-email-khilman@deeprootsystems.com>
	<200909302321.33088.rjw@sisk.pl>
	<20091006133456.5177a32a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091006133456.5177a32a.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [2009-10-06 13:34]:
> Rigor mortis is setting in on this one.

> The patch seems correct to me.

Can someone put this patch in now?  The problem has also been reported
on Marvell's Kirkwood platform (ARM) by a number of users and the
patch fixes it.

Tested-by: Martin Michlmayr <tbm@cyrius.com>

Please CC stable when you commit the patch since it also needs to go
in for 2.6.31.

Reference with the patch: http://patchwork.kernel.org/patch/50728/
-- 
Martin Michlmayr
http://www.cyrius.com/
