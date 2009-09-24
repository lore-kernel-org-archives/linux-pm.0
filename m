From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] 3c59x: Get rid of "Trying to free
	already-free IRQ"
Date: Thu, 24 Sep 2009 15:26:19 -0700 (PDT)
Message-ID: <20090924.152619.260814858.davem__36716.2970979281$1253831481$gmane$org@davemloft.net>
References: <20090924183152.GA30254@oksana.dev.rtsoft.ru>
	<200909242230.33881.rjw@sisk.pl>
	<20090924213039.GA15904@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090924213039.GA15904@oksana.dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: avorontsov@ru.mvista.com
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Fri, 25 Sep 2009 01:30:39 +0400

> On Thu, Sep 24, 2009 at 10:30:33PM +0200, Rafael J. Wysocki wrote:
>> On Thursday 24 September 2009, Anton Vorontsov wrote:
>> > Following trace pops up if we try to suspend with 3c59x ethernet NIC
>> > brought down:
>> 
>> Patch looks good, but IMO it'd be a little effort to convert the driver to
>> dev_pm_ops while you're at it (please see r8169 for a working example).
> 
> I'd like to avoid putting irrelevant stuff into bugfixes.

Agreed.
