From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v2 09/21] ARM: pxa: magician: Add OV9640 camera support
Date: Fri, 21 Aug 2015 00:39:30 +0200
Message-ID: <55D65722.9030508@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D259A1.6090102@tul.cz>
 <87lhd568sb.fsf@belgarion.home> <2889798.x6xcIzdYMU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <2889798.x6xcIzdYMU@wuerfel>
Sender: linux-leds-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, linux@arm.linux.org.uk, sameo@linux.intel.com, linux-pm@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cooloney@gmail.com, sre@kernel.org, haojian.zhuang@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, philipp.zabel@gmail.com, lee.jones@linaro.org, j.anaszewski@samsung.com, daniel@zonque.org
List-Id: linux-pm@vger.kernel.org

Dne 20.8.2015 v 22:26 Arnd Bergmann napsal(a):
> On Thursday 20 August 2015 21:48:20 Robert Jarzmik wrote:
>> Petr Cvek <petr.cvek@tul.cz> writes:
>>
>>> +     mdelay(3);
>> Okay, there are several mdelay(3) in this file.
>>
>> Could you please test if removing these mdelays prevents the camera from working
>> ? If not, I'd like to have them removed.
>>
>>
> 
> FWIW, it might be possible to replace some of them with msleep() calls,
> potentially after replacing spinlocks with mutexes where necessary.
> 
> 	Arnd
> 

Datasheet says:

	tS:RESET	Setting time after software/hardware reset	1 ms

So at least one ~1 ms should be left there. Are msleep less than 20ms valid? 

(checkpatch: msleep < 20ms  can sleep for up to 20ms)

Petr
