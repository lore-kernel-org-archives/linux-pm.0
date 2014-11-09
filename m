From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 33/48] staging: nvec: Register with kernel power-off
 handler
Date: Sun, 09 Nov 2014 15:54:53 -0800
Message-ID: <545FFECD.9050600@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
 <1415292213-28652-34-git-send-email-linux@roeck-us.net>
 <5008744.rVN94atT9b@ax5200p>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <5008744.rVN94atT9b@ax5200p>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>, devel@driverdev.osuosl.org
Cc: linux-tegra@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/09/2014 01:41 PM, Marc Dietrich wrote:
> Am Donnerstag 06 November 2014, 08:43:17 schrieb Guenter Roeck:
>> Register with kernel power-off handler instead of setting pm_power_off
>> directly. Register with default priority since we don't know any better.
>>
>> Cc: Julian Andres Klode <jak@jak-linux.org>
>> Cc: Marc Dietrich <marvin24@gmx.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net
>
> ok, this version (V5) actually switches the device off in contrast to the
> first implementation. Somehow I have to find out why it works at all without
> irqs.
>
> Acked-by: Marc Dietrich <mavin24@gmx.de>
>

Hi Marc,

The most recent version does not turn off interrupts as long as the
infrastructure (architecture code, ie machine_power_off) doesn't
turn it off.

Thanks a lot for (re-)testing.

Guenter
