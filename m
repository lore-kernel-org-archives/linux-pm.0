From: Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH v2 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Fri, 07 Feb 2014 16:28:45 +0000
Message-ID: <52F509BD.70903@arm.com>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com> <1391786342-11812-3-git-send-email-thomas.ab@samsung.com> <52F50698.4060305@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <52F50698.4060305@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 07/02/14 16:15, Sudeep Holla wrote:
> On 07/02/14 15:19, Thomas Abraham wrote:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> Add a new optional boost-frequency binding for specifying the frequencies
>> usable in boost mode.
>>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Lukasz Majewski <l.majewski@samsung.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt |   11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>> new file mode 100644
>> index 0000000..d925e38
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
>> @@ -0,0 +1,11 @@
>> +* Device tree binding for CPU boost frequency (aka over-clocking)
>> +
>> +Certain CPU's can be operated in optional 'boost' mode (or sometimes referred as
>> +overclocking) in which the CPU can operate in frequencies beyond the normal
>> +operating conditions.
>> +
>> +Optional Properties:
>> +- boost-frequency: list of frequencies in KHz to be used only in boost mode.
>> +  This list should be a subset of frequencies listed in "operating-points"
>> +  property. Refer to Documentation/devicetree/bindings/power/opp.txt for
>> +  details about "operating-points" property.
>>
> 
> Won't single entry for boost frequency suffice which would be the starting
> frequency in the boost range. IOW will there be OPP list with frequencies:
> A > B > C > D, but only B and C are boost frequency. That seems little odd,
> unless it's some configuration chosen purely on software basis rather than
> hardware. For me B marks the beginning of over-clocking.
> 
Ah, I meant A < B < C < D in the above example.

Regards,
Sudeep
