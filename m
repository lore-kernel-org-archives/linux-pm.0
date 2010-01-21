From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO
 during	suspend/resume (was: Re: Memory allocations in .suspend	became very
 unreliable)
Date: Fri, 22 Jan 2010 07:42:25 +1100
Message-ID: <4B58BC31.1040406__47398.2975855053$1264106652$gmane$org@crca.org.au>
References: <20100120085053.405A.A69D9226@jp.fujitsu.com>	<201001202221.34804.rjw@sisk.pl>	<20100121091023.3775.A69D9226@jp.fujitsu.com>
	<201001212121.50272.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001212121.50272.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

Hi.

Rafael J. Wysocki wrote:
> On Thursday 21 January 2010, KOSAKI Motohiro wrote:
>>  - Ask all drivers how much they require memory before starting suspend and
>>    Make enough free memory at first?
> 
> That's equivalent to reworking all drivers to allocate memory before suspend
> eg. with the help of PM notifiers.  Which IMHO is unrealistic.

What's unrealistic about it? I can see that it would be a lot of work,
but unrealistic? To me, at this stage, it sounds like the ideal solution.

Regards,

Nigel
