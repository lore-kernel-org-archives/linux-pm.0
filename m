From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC][PATCH] uli526x: Add suspend and resume
	routines (updated)
Date: Fri, 31 Aug 2007 08:52:09 -0400
Message-ID: <46D80EF9.7000300__7844.56506739861$1188564796$gmane$org@garzik.org>
References: <200708052114.01790.rjw@sisk.pl> <200708080056.41651.rjw@sisk.pl>
	<46C14479.1080206@garzik.org> <200708142009.03272.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708142009.03272.rjw@sisk.pl>
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
Cc: Kyle McMartin <kyle@mcmartin.ca>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Grant Grundler <grundler@parisc-linux.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Tuesday, 14 August 2007 07:58, Jeff Garzik wrote:
>> Rafael J. Wysocki wrote:
>>> On Wednesday, 8 August 2007 00:26, Jeff Garzik wrote:
>>>> Rafael J. Wysocki wrote:
>>>>> On Tuesday, 7 August 2007 23:40, Jeff Garzik wrote:
>>>>>> I'll let our new tulip maintainer see what he thinks about the 
>>>>>> implementation.  Seems fairly sane to me, but should at least get an "it 
>>>>>> works" test.
>>>>> It has been tested, as stated in the changelog, and works (on my test system).
> [--snip--]
>  
>> Two comments:
>>
>> 1) Like akpm, the CONFIG_PM_SLEEP is out of place.  All other drivers 
>> use CONFIG_PM
> 
> OK
> 
>> 2) just remove the !dev checks, that is an impossible condition
> 
> OK
> 
> Updated patch follows.
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Add suspend/resume support to the uli526x network driver (tested on x86_64,
> with 'Ethernet controller: ALi Corporation M5263 Ethernet Controller, rev 40').
> 
> This patch is based on the suspend/resume code in the tg3 driver.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/net/tulip/uli526x.c |  108 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 102 insertions(+), 6 deletions(-)

applied
