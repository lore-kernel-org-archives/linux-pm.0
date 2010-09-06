From: Thomas Renninger <trenn@suse.de>
Subject: Re: Speedstep on Celeron SU2300 - 20% more battery
	lifetime on Windows
Date: Mon, 6 Sep 2010 10:35:03 +0200
Message-ID: <201009061035.03727.trenn__2068.85952870852$1283762260$gmane$org@suse.de>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com>
	<201009020152.37466.trenn@suse.de>
	<AANLkTi=WDEA+prG26g5R9oG1uZ7cNgaMrYDtug_LM7bY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=WDEA+prG26g5R9oG1uZ7cNgaMrYDtug_LM7bY@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tiago Marques <tiagomnm@gmail.com>
Cc: discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

I am adding lesswatts.org and linux-pm list.
I expect you found out why you do not get frequency/P- states and it
seem to be correct. On these lists, people can help you further
to find out Linux vs Windows battery drain differences.

If you have the same backlight settings, I expect C-state or graphics
card must be the reason. There is nothing else than CPU or GPU
that drains so much energy for being the reason of
20% more battery life time.
Which graphics card and driver do you use (for nvidia/ati, trying the
binary one for comparison, might show a big difference on a recent
card)?
Which C-state driver do you use (there is an acpi and intel_idle one
with latest kernels):
cat /sys/devices/system/cpu/cpuidle/current_driver
I hope to be able to provide a c-state tool soon, for now you have to
go through:
cat /sys/devices/system/cpu/cpu*/cpuidle/state*
to check which and how often/efficient C-states are used.

Some background (and a comment in the end):

On Saturday 04 September 2010 13:33:26 Tiago Marques wrote:
> On Thu, Sep 2, 2010 at 12:52 AM, Thomas Renninger <trenn@suse.de> wrote:
> > On Thursday 02 September 2010 01:17:14 Tiago Marques wrote:
> >> Hi Thomas. Thanks for the message.
> >>
> >> On Wed, Sep 1, 2010 at 11:40 PM, Thomas Renninger <trenn@suse.de> wrote:
> >> > On Sunday 29 August 2010 06:54:44 Tiago Marques wrote:
> >> >> Hi,
> >> >> I'm having a problem with this processor not having frequency steps
> >> >> and apparently only voltage steps. I find it very strange but that's
> >> >> what Intel's documentation suggests. I can't load acpi-cpufreq because
> >> >> it doesn't find any device and battery life in linux is suffering
> >> >> around 20% less due to this.
> >> > Where do you have the 20% info from, I doubt you verified it?
> >>
> >> Yes. Since it seems no one can't return Windows licenses for refunds
> >> anymore, I have went ahead and booted windows on it, without any
> >> driver installed and just configured it to have frequency scaling
> >> working, which in this case is only voltage scaling.
> >> I measured almost 6 hours of battery life and the processor & chipset
> >> frequently had the fan stop when idling.
> >>
> >> In linux, in the same conditions, I got less than 4 hours and the fan
> >> never stops. I configured a PCI-express power saving feature on the
> >> kernel and it seems to have dropped noise a bit. Battery life is still
> >> not great and the fan still never stops. I'm trying to find something
> >> with which I can measure the actual power going through the AC adapter
> >> but for now battery life tests is pretty much all I can do.
> > There is current battery power drain somehwere in
> > /proc/acpi/battery/*/*
> > It normally updates not that often, but may be better and accurate enough if you
> > take several values, than waiting for the battery got drained.
> 
> Thanks, I'll look into that for kernel tuning. I just can't use to
> compare with windows because I don't think I have similar information
> there.
Best is you get or buy a cheap measure device, in which you can plug
your AC adapter in and remove the battery.
Some electricity company borrow one for free, at least in Germany.
It needs not to be very accurate, you are hunting far above 1Watt drain
differences... Could cost about 10-20 Euro and you can measure your
fridge and other things as well for your overall monthly electricity bill.

... <cut out frequency discussion, see below> ...
> >> I can't seem to find the lowest multiplier available on these
> >> platforms, CrystalCPUID lists mine as 6x, hence 1200MHz. I thought
> >> Core 2's could idle at something like 800MHz and I find it strange
> >> that this one can't also.
> > Interesting. Possibly you have luck finding a document from Intel about
> > this CPU describing this a bit. I'd be interested in the outcome, but don't
> > have to time to dig for it.
> 
> http://www.intel.com/design/mobile/datashts/321111.pdf
> 
> Please have a look at this document, page 30, note 10, at the top of the page.
> 
> Do you have any experience with SU processors?
Not really, but other reports of SU processors without P-states and this info
from the paper you point to:
"The Highest Frequency Mode (HFM) and Lowest Frequency Mode (LFM) refer to the highest
and lowest core operating frequencies supported on the Genuine Intel Processor."
...
"10. SU2300 processor operates at same core frequency in HFM and LFM."

explain the lack of P-states.
> I have no idea of idle
> clock of the Core 2 SU CPUs, perhaps it is also 1200MHz, hence the
> limitation on idle clock? Could be the lowest multiplier available.
I expect lowering power on this kind of CPU is all about C-states.
Possibly these need some special treatment, no idea.
Hopefully one of the Intel guys jump into this thread...

        Thomas
