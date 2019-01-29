From: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Subject: Re: [PATCH] thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs
Date: Tue, 29 Jan 2019 09:54:18 +0000
Message-ID: <da514645-51ab-47ac-8377-dfadfd783897@raspberrypi.org>
References: <1548753048-78735-1-git-send-email-phil@raspberrypi.org>
 <dd7a1467-9252-ac13-204a-b069e5fba13a@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <dd7a1467-9252-ac13-204a-b069e5fba13a-eS4NqCHxEME@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Stefan,

On 29/01/2019 09:44, Stefan Wahren wrote:
> Hi Phil,
> 
> Am 29.01.2019 um 10:10 schrieb Phil Elwell:
>> "cat /sys/kernel/debug/bcm2835_thermal/regset" causes a NULL pointer
>> dereference in bcm2835_thermal_debugfs. The driver makes use of the
>> implementation details of the thermal framework to retrieve a pointer
>> to its private data from a struct thermal_zone_device, and gets it
>> wrong - leading to the crash. Instead, store its private data as the
>> drvdata and retrieve the thermal_zone_device pointer from it.
>>
>> Fixes: bcb7dd9ef206 ("thermal: bcm2835: add thermal driver for bcm2835 SoC")
>>
>> Signed-off-by: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
> 
> thanks for this patch.
> 
> Could you please resend this patch to the thermal maintainers Zhang Rui and Eduardo Valentin?||||
> 
> Regards
> Stefan
> 

I blame the get_maintainer script - a "Supporter" sounds less invested and less authoritative
than a "Maintainer".

A resend is imminent.

Phil
