From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V8 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
Date: Thu, 17 Nov 2016 07:10:22 -0800
Message-ID: <20161117151019.GA3115@localhost.localdomain>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
 <1478081906-12009-3-git-send-email-kernel@martin.sperl.org>
 <20161117021107.GA2647@localhost.localdomain>
 <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Sperl <kernel@martin.sperl.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, Will Deacon <will.deacon@arm.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hello Martin,

On Thu, Nov 17, 2016 at 10:51:33AM +0100, Martin Sperl wrote:
> 
> 
> On 17.11.2016 03:11, Eduardo Valentin wrote:
> >Hey Martin,
> >
> >Very sorry for the late feedback. Not so sure if this one got queued
> >already or not. Anyways, just minor questions as follows:
> >
> >On Wed, Nov 02, 2016 at 10:18:22AM +0000, kernel@martin.sperl.org wrote:
> >>From: Martin Sperl <kernel@martin.sperl.org>
> >>
> >>Add basic thermal driver for bcm2835 SOC.
> >>
> >>This driver currently relies on the firmware setting up the
> >>tsense HW block and does not set it up itself.
> >>
> >>Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> >>Acked-by: Eric Anholt <eric@anholt.net>
> >>Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> >>
> ...
> >>+static int bcm2835_thermal_adc2temp(
> >>+	const struct bcm2835_thermal_info *info, u32 adc)
> >>+{
> >>+	return info->offset + (adc * info->slope);
> >
> >Any specific reason we cannot use thermal_zone_params->slope and
> >thermal_zone_params->offset?
> 
> You could - the patch was just rebased to 4.9 and those slope and
> offset just got merged during this cycle.
> 
> Do we really need to modify it - the patch has been around since 4.6.
> 
> >>+
> >>+static int bcm2835_thermal_get_trip_temp(
> >>+	struct thermal_zone_device *tz, int trip, int *temp)
> >>+{
> >>+	struct bcm2835_thermal_data *data = tz->devdata;
> >>+	u32 val = readl(data->regs + BCM2835_TS_TSENSCTL);
> >>+
> >>+	/* get the THOLD bits */
> >>+	val &= BCM2835_TS_TSENSCTL_THOLD_MASK;
> >>+	val >>= BCM2835_TS_TSENSCTL_THOLD_SHIFT;
> >>+
> >>+	/* if it is zero then use the info value */
> >>+	if (val)
> >
> >Is this a read only register or is this driver supposed to program it?
> >In which scenario it would be 0? Can this be added as comments?
> 
> It is RW, but the Firmware typically sets up the thermal device with the
> correct values already - this is just a fallback.

OK, but how do you differentiate from a buggy firmware or misconfigured
hardware? How do you know if the firmware is supposed to be loaded and
ready? There is no firmware loading in this driver. Also, there is no
dependency with a driver that loads firmware, or at least, I missed it.

> 
> >>+static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz,
> >>+				    int *temp)
> >>+{
> >>+	struct bcm2835_thermal_data *data = tz->devdata;
> >>+	u32 val = readl(data->regs + BCM2835_TS_TSENSSTAT);
> >>+
> >>+	if (!(val & BCM2835_TS_TSENSSTAT_VALID))
> >
> >What cases you would get the valid bit not set? Do you need to wait for
> >the conversion to finish?
> 
> I guess: if you have just enabled the HW-block (which the FW does much
> in advance) and start to read the value immediately (before the first sample
> period has finished), then this will not be valid.
> 

Then again, how does this driver make sure the initialization procedure
is correct, and that by the time it is using the hardware, the hardware
is in a sane state?

Back to the original question, does it mean the hardware is in
some sort of continuous ADC conversion mode or reading the temperature
requires specific steps to get the conversion done, and therefore you
are checking the valid bit here?



> So do you need another version of the patchset that uses that new API?

I think the API usage is change that can be done together with
clarification for the above questions too: on hardware state,
firmware loading, maybe a master driver dependency, and the ADC
conversion sequence, which are not well clear to me on this driver. As long as
this is clarified and documented in the code (can be simple comments so
it is clear to whoever reads in the future), then I would be OK with
this driver. 

> 
> Thanks,
> 	Martin
