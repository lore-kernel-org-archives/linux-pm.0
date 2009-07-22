From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] NET / skge: Enable WoL by default if
	supported
Date: Wed, 22 Jul 2009 11:25:17 -0700 (PDT)
Message-ID: <20090722.112517.31647761.davem__12599.1957764656$1248287236$gmane$org@davemloft.net>
References: <200907221458.55616.rjw@sisk.pl> <20090722095953.0806bea2@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090722095953.0806bea2@nehalam>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: shemminger@vyatta.com
Cc: netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, mike@it-loops.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Wed, 22 Jul 2009 09:59:53 -0700

> On Wed, 22 Jul 2009 14:58:55 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
>> From: Rafael J. Wysocki <rjw@sisk.pl>
>> 
>> If skge hardware is capable of waking up the system from sleep,
>> enable magic packet WoL during driver initialisation.
>> 
>> This makes WoL work without calling 'ethtool -s ethX wol g'
>> for each adapter.
>> 
>> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>> Tested-by: Michael Guntsche <mike@it-loops.com>
>> ---
>>  drivers/net/skge.c |    4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> Index: linux-2.6/drivers/net/skge.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/net/skge.c
>> +++ linux-2.6/drivers/net/skge.c
>> @@ -3856,8 +3856,10 @@ static struct net_device *skge_devinit(s
>>  	skge->speed = -1;
>>  	skge->advertising = skge_supported_modes(hw);
>>  
>> -	if (device_may_wakeup(&hw->pdev->dev))
>> +	if (device_can_wakeup(&hw->pdev->dev)) {
>>  		skge->wol = wol_supported(hw) & WAKE_MAGIC;
>> +		device_set_wakeup_enable(&hw->pdev->dev, skge->wol);
>> +	}
>>  
>>  	hw->dev[port] = dev;
>>  
> 
> Acked-by: Stephen Hemminger <shemminger@vyatta.com>

Applied, thanks.
