From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [lm-sensors] broken suspend [Was: 2.6.24-rc2-mm1]
Date: Mon, 26 Nov 2007 09:57:38 +0100
Message-ID: <474A8A82.6040303__34699.7747933075$1196067542$gmane$org@gmail.com>
References: <4741EB91.9080000@assembler.cz>
	<Pine.LNX.4.44L0.0711191521170.3129-100000@iolanthe.rowland.org>
	<20071120131520.GC12077@jupiter.solarsys.private>
	<200711210100.43049.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711210100.43049.rjw@sisk.pl>
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
Cc: Rudolf Marek <r.marek@assembler.cz>, Kernel development list <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 11/21/2007 01:00 AM, Rafael J. Wysocki wrote:
> On Tuesday, 20 of November 2007, Mark M. Hoffman wrote:
>> commit ce9c7b78c839a6304696d90083eac08baad524ce
>> Author: Mark M. Hoffman <mhoffman@lightlink.com>
>> Date:   Tue Nov 20 07:51:50 2007 -0500
>>
>>     hwmon: (coretemp) fix suspend/resume hang
>>     
>>     Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
> 
> I'd do it like this:
> 
>> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
>> index 5c82ec7..afe2d31 100644
>> --- a/drivers/hwmon/coretemp.c
>> +++ b/drivers/hwmon/coretemp.c
>> @@ -338,10 +338,12 @@ static int coretemp_cpu_callback(struct notifier_block *nfb,
>>  	switch (action) {
>>  	case CPU_ONLINE:
>>  	case CPU_ONLINE_FROZEN:
>> +	case CPU_DOWN_FAILED:
>>  		coretemp_device_add(cpu);
> +	case CPU_DOWN_FAILED_FROZEN: 
>>  		break;
>> -	case CPU_DEAD:
>> -	case CPU_DEAD_FROZEN:
>> +	case CPU_DOWN_PREPARE:
>>  		coretemp_device_remove(cpu);
> +	case CPU_DOWN_PREPARE_FROZEN:
>>  		break;
>>  	}

Sorry for the delay, this (trimmed version) solves the problem!

thanks,
-- 
Jiri Slaby (jirislaby@gmail.com)
Faculty of Informatics, Masaryk University
