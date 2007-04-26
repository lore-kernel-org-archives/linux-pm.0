From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Thu, 26 Apr 2007 12:02:37 +0100
Message-ID: <1177585357.2755.347.camel@pmac.infradead.org>
References: <1176980411.6141.83.camel@johannes.berg>
	<200704211006.58857.david-b@pacbell.net>
	<20070421214557.GB2758@elf.ucw.cz>
	<200704212010.51139.david-b@pacbell.net> <20070422130948.GC4236@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070422130948.GC4236@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-04-22 at 13:09 +0000, Pavel Machek wrote:
> Uf I thought you were going to
> s/CONFIG_SOFTWARE_SUSPEND/CONFIG/HIBERNATION/ over the kernel, 

I think that's a really good idea. The small amount of churn in the
short term will be far outweighed by the benefit in the long term.

Just do it.

-- 
dwmw2
