From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] add a printk_init variant storing
	format	strings in	__initdata
Date: Wed, 04 Jun 2008 10:17:59 +0100
Message-ID: <1212571079.4042.66.camel__2149.07036065615$1212571357$gmane$org@shinybook.infradead.org>
References: <20080529162257.03426e48.akpm@linux-foundation.org>
	<1212485252.0@pinky>
	<20080604011607.15dec5a7.akpm@linux-foundation.org>
	<1212569949.4042.56.camel@shinybook.infradead.org>
	<1212570622.14371.19.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1212570622.14371.19.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, pavel@suse.cz, Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2008-06-04 at 11:10 +0200, Johannes Berg wrote:
> On Wed, 2008-06-04 at 09:59 +0100, David Woodhouse wrote:
> > On Wed, 2008-06-04 at 01:16 -0700, Andrew Morton wrote:
> > > We're going to want to be able to call printk_init() from modules. 
> > > Please fix and test that, if we decide to proceed.
> > 
> > Can we fix that by making it an alias for printk in the module case?
> > 
> > The only reason we need it to be __init is so that we get the section
> > warnings when you use it from non-init code, right? Won't we get the
> > warning when non-init code refers to the string in initdata anyway?
> 
> In fact, wasn't the warning Andy showed such a warning?

Hm, yes it was. Why do we need __printk_init() to be anything other than
an alias for printk, then?

-- 
dwmw2
