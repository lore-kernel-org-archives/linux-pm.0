From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH V9] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Fri, 20 Jan 2017 09:43:02 +0100
Message-ID: <D349C10C-C929-40A4-86BF-7F6E834DB613@martin.sperl.org>
References: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org>
 <20170120041400.GA24617@localhost.localdomain>
 <20170120042323.GA6651@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170120042323.GA6651-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


> On 20.01.2017, at 05:23, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> On Thu, Jan 19, 2017 at 08:14:02PM -0800, Eduardo Valentin wrote:
>> Hello Martin,
>> 
>> On Sat, Jan 07, 2017 at 04:55:45PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>>> 
>>> Add basic thermal driver for bcm2835 SOC.
>>> 
>>> This driver currently relies on the firmware setting up the
>>> tsense HW block and does not set it up itself.
>>> 
>>> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>>> Acked-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>>> Acked-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
>>> 
>> 
>> <cut>
> 
> 
> Also, I am getting this warn from sparse:
> drivers/thermal/bcm2835_thermal.c:110:16: warning: cast truncates bits
> from constant value (3ffffffffff00 becomes ffffff00)
> drivers/thermal/bcm2835_thermal.c:134:16: warning: cast truncates bits
> from constant value (3ffffffffff becomes ffffffff)
> 
> Have you seen this?

No, I have not checked sparse.

These values are defined via GENMASK on line 47 and 57 respectively
and should actually compute to the following values:
  for line 110 (line 47 has the define):
    GENMASK(BCM2835_TS_TSENSCTL_THOLD_BITS +     \
            BCM2835_TS_TSENSCTL_THOLD_SHIFT - 1, \
            BCM2835_TS_TSENSCTL_THOLD_SHIFT)
    = GENMASK(10 + 8 - 1, 8) 
    = GENMASK(17, 8)
    = (((~0UL) << (8)) & (~0UL >> (32 - 1 - (10 + 8 - 1))))
    = 0x3ff00
  for line 134 (line 57 has the define):
    GENMASK(BCM2835_TS_TSENSCTL_THOLD_BITS +     \
            BCM2835_TS_TSENSCTL_THOLD_SHIFT - 1, \
            BCM2835_TS_TSENSCTL_THOLD_SHIFT)
    = GENMASK(10 + 0 - 1, 0)
    = GENMASK(9, 0)
    = (((~0UL) << (0)) & (~0UL >> (32 - 1 - (10 + 0 - 1))))
    = 0x003ff

Note that the preprocessor expansions have been verified by
looking at the preprocessed driver source
(drivers/thermal/bcm2835_thermal.i)

I wonder why sparse is computing these GENMASK values as:
0x3ffffffffff00 and 0x3ffffffffff

Martin
