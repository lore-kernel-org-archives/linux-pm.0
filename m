From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] add a printk_init variant storing format
	strings in	__initdata
Date: Wed, 04 Jun 2008 09:59:09 +0100
Message-ID: <1212569949.4042.56.camel__20824.9477473602$1212570069$gmane$org@shinybook.infradead.org>
References: <20080529162257.03426e48.akpm@linux-foundation.org>
	<1212485252.0@pinky>
	<20080604011607.15dec5a7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080604011607.15dec5a7.akpm@linux-foundation.org>
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
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, Andy Whitcroft <apw@shadowen.org>, mingo@elte.hu, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2008-06-04 at 01:16 -0700, Andrew Morton wrote:
> We're going to want to be able to call printk_init() from modules. 
> Please fix and test that, if we decide to proceed.

Can we fix that by making it an alias for printk in the module case?

The only reason we need it to be __init is so that we get the section
warnings when you use it from non-init code, right? Won't we get the
warning when non-init code refers to the string in initdata anyway?

-- 
dwmw2
