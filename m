From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP: omap_device: fix !CONFIG_SUSPEND case
 in _noirq handlers
Date: Tue, 06 Sep 2011 13:20:36 -0700
Message-ID: <4E668094.40108__38243.4730222032$1315340528$gmane$org@ti.com>
References: <1314900722-10252-1-git-send-email-khilman@ti.com>
	<1876183.c78P8V3ZbL@wuerfel> <201109012357.39873.rjw@sisk.pl>
	<4E667EE1.1020808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4E667EE1.1020808@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On 09/06/2011 01:13 PM, Kevin Hilman wrote:
> On 09/01/2011 02:57 PM, Rafael J. Wysocki wrote:
>> On Thursday, September 01, 2011, Arnd Bergmann wrote:
>>> On Thursday 01 September 2011 11:12:02 Kevin Hilman wrote:
>>>> The suspend/resume _noirq handlers were #ifdef'd out in the
>>>> !CONFIG_SUSPEND case, but were still assigned to the dev_pm_ops
>>>> struct. Fix by defining them to NULL in the !CONFIG_SUSPEND case.
>>>>
>>>> Reported-by: Arnd Bergmann<arnd@arndb.de>
>>>> Signed-off-by: Kevin Hilman<khilman@ti.com>
>>>
>>> Acked-by: Arnd Bergmann<arnd@arndb.de>
>>>
>>> Thansk for the fast response!
>>
>> I'll apply the patch when kernel.org is back in order.
>>
>
> Tony,
>
> I spoke w/Rafael and due to hera being down and Rafael traveling to LPC
> he wont be able to queue this for v3.1. Can you queue up this fix? This
> needs to go in to v3.1-rc.

For convenience, this patch is in a branch in my backup gitorious repo 
with Arnd's ack added:

	git://gitorious.org/khilman/linux-omap-pm.git for_3.1/pm-fixes-2

Kevin
