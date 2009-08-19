From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [RFC][PATCH 1/7] PM: Update kerneldoc comments in
	drivers/base/power/main.c
Date: Wed, 19 Aug 2009 15:00:47 -0700
Message-ID: <4A8C760F.9040003__23187.977114185$1250719442$gmane$org@oracle.com>
References: <200908122218.13975.rjw@sisk.pl> <200908170215.21173.rjw@sisk.pl>
	<200908170216.38401.rjw@sisk.pl> <200908192357.31358.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908192357.31358.rjw@sisk.pl>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Monday 17 August 2009, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rjw@sisk.pl>
>> Subject: PM: Update kerneldoc comments in drivers/base/power/main.c
>>
>> The kerneldoc comments in drivers/base/power/main.c are generally
>> outdated and some of them don't describe the functions very
>> accurately.  Update them and standardize the format to use spaces
>> instead of tabs.
>>
>> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Any objections to this patch from anyone?  Greg, Alan, Randy?

Nope, it's good.  Thanks.
Acked-by: Randy Dunlap <randy.dunlap@oracle.com>


> Best,
> Rafael
> 
> 
>> ---
>>  drivers/base/power/main.c |  169 ++++++++++++++++++++++------------------------
>>  1 file changed, 84 insertions(+), 85 deletions(-)
