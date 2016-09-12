From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH 1/3] dt: cpufreq: brcm: New binding document for brcm-avs-cpufreq
Date: Mon, 12 Sep 2016 10:05:21 -0700
Message-ID: <CAGt4E5sT28tr4bT-vknNPBoybOHsUsLPcvxN-abFhFMUhuJ=MA@mail.gmail.com>
References: <1471044331-2480-1-git-send-email-mmayer@broadcom.com>
 <1471044331-2480-2-git-send-email-mmayer@broadcom.com> <20160816131639.GA938@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160816131639.GA938@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 16 August 2016 at 06:16, Rob Herring <robh@kernel.org> wrote:
> On Fri, Aug 12, 2016 at 04:25:29PM -0700, Markus Mayer wrote:
>> Add the binding document for the new brcm-avs-cpufreq driver.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> ---
>>  .../bindings/cpufreq/brcm-avs-cpufreq.txt          | 84 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  7 ++
>>  2 files changed, 91 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/brcm-avs-cpufreq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/brcm-avs-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/brcm-avs-cpufreq.txt
>> new file mode 100644
>> index 0000000..707ebe5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/brcm-avs-cpufreq.txt
>> @@ -0,0 +1,84 @@
>> +Broadcom AVS CPUfreq driver
>> +===========================
>> +
>> +This driver provides voltage and frequency scaling on Broadcom SoCs using
>
> Bindings describe h/w (or firmware interfaces) not drivers. CPUFreq is a
> Linux term. Please re-word.

Will do.

>> +the AVS firmware with DVFS support. The AVS firmware is running on its own
>> +co-processor. The driver supports both uniprocessor (UP) and symmetric
>> +multiprocessor (SMP) systems which share clock and voltage across all CPUs.
>> +
>> +Actual voltage and frequency scaling is done solely by the AVS firmware.
>> +This driver does not change frequency or voltage itself. It provides a
>> +standard CPUfreq interface to the rest of the kernel and to userland. It
>> +interfaces with the AVS firmware to effect the requested changes and to
>> +report back the current system status in a way that is expected by existing
>> +tools.
>> +
>> +This driver requires two DT nodes. One node (brcm,avs-cpu-data-mem)
>> +references the mailbox register used to communicate with the AVS CPU. The
>> +second node (brcm,avs-cpu-l2-intr) is required to trigger an interrupt on
>> +the AVS CPU. The interrupt tells the AVS CPU that it needs to process a
>> +command sent to it by this driver. Interrupting the AVS CPU is mandatory for
>> +commands to be processed.
>
> The mailbox and interrupt to the AVS CPU are only for DVFS?

Yes, it is. -- The AVS CPU can run in DFS and DVFS mode. But I don't
think you are looking at that kind of distinction here. Linux wouldn't
even notice the difference between the two. (Linux can ask the
firmware "which mode you are in", but it doesn't have to.)

Thanks,
-Markus
