From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor for tickless systems
Date: Mon, 5 Nov 2018 13:28:14 -0800
Message-ID: <001f01d4754e$7c353e30$749fba90$@net>
References: FyDag8LEB6DhgFyDfglTus <000301d472c2$49f28740$ddd795c0$@net> JkE8gcQXkD1yAJkEEggRQ6
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: JkE8gcQXkD1yAJkEEggRQ6
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Giovanni Gherdovich' <ggherdovich@suse.cz>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.11.05 11:12 Giovanni Gherdovich wrote:
> On Fri, 2018-11-02 at 08:39 -0700, Doug Smythies wrote:
> ...[snip]...
>> 
>> After reading Giovanni's reply the other day, I tried the
>> Phoronix dbench test: 12 clients resulted in similar performance,
>> But TEOv2 used a little less processor package power; 256 clients
>> had about -7% performance using TEOv2, but (my numbers are not
>> exact) also used less processor package power.
>
> Uhm, I see. The results I've got vary between machines; that could
> depend on the CPU type.

Agreed.

> What is your machine processor model, 
> and how many logical cores does it have?

Sorry, I had meant to include that in my original e-mail.
My test server has an older i7-2600K processor.
It has 4 cores, and 8 CPUs.

> For the record, in my previous email I wrote that my script runs dbench with
> up to NUMCPUS*8 clients, but that's misleading; indeed for the 48-cores
> machines I had runs with 1, 2, 4, 8, 16, 32 and 64 clients.
> https://lore.kernel.org/lkml/1541010981.3423.2.camel@suse.cz/
>
> The sequence is generated with
>
>    CLIENT=1
>    DBENCH_MAX_CLIENTS=$((NUMCPUS*8))
>
>    while [ $CLIENT -le $DBENCH_MAX_CLIENTS ]; do
>
>            ./bin/dbench [...] $CLIENT
>
>            if [ $CLIENT -lt $NUMCPUS ]; then
>                    CLIENT=$((CLIENT*2))
>            else
>                    CLIENT=$((CLIENT*8))
>            fi
>    done
>
> In practice the max number of clients I get is slightly below NUMCPUS*2 to
> reach saturation. I write this as I read you ran it with 256 clients but I
> never went that high.

I agree that my system is extremely overloaded and unresponsive while
running the Phoronix dbench test with 256 clients. However, I did it
because it gives a rather high number of idle state 0 entries/exits
per unit time.

>> 
>> On 2018.10.31 11:36 Giovanni Gherdovich wrote:
>> 
>>> Something I'd like to do now is verify that "teo"'s predictions
>>> are better than "menu"'s; I'll probably use systemtap to make
>>> some histograms of idle times versus what idle state was chosen
>>> -- that'd be enough to compare the two.
>> 
>> I don't know what a "systemtap" is, but I have (crude) tools to
>> post process trace data into histograms data. I did 5 minute
>> traces during the 12 client Phoronix dbench test and plotted
>> the results, [1]. Sometimes, to the right of the autoscaled
>> graph is another with fixed scaling. Better grouping of idle
>> durations with TEOv2 are clearly visible.
>> 
>> ... Doug
>> 
>> [1] http://fast.smythies.com/linux-pm/k419p/histo_compare.htm
>
> Oh, that's interesting, thanks. Can you post the break-even residency times and
> exit latencies for your CPUs? On my Skylake test machine I get this from sysfs:
>
> $ cd /sys/devices/system/cpu/cpu0/cpuidle
> $ for state in * ; do
> echo -e \
> "STATE: $state\t\
> DESC: $(cat $state/desc)\t\
> NAME: $(cat $state/name)\t\
> LATENCY: $(cat $state/latency)\t\
> RESIDENCY: $(cat $state/residency)"
> done
>
> STATE: state0   DESC: CPUIDLE CORE POLL IDLE    NAME: POLL      LATENCY: 0      RESIDENCY: 0
> STATE: state1   DESC: MWAIT 0x00        NAME: C1        LATENCY: 2      RESIDENCY: 2
> STATE: state2   DESC: MWAIT 0x01        NAME: C1E       LATENCY: 10     RESIDENCY: 20
> STATE: state3   DESC: MWAIT 0x10        NAME: C3        LATENCY: 70     RESIDENCY: 100
> STATE: state4   DESC: MWAIT 0x20        NAME: C6        LATENCY: 85     RESIDENCY: 200
> STATE: state5   DESC: MWAIT 0x33        NAME: C7s       LATENCY: 124    RESIDENCY: 800
> STATE: state6   DESC: MWAIT 0x40        NAME: C8        LATENCY: 200    RESIDENCY: 800

Sorry again, I had meant to include that in my original e-mail also.
And also that it was a 1000 Hz kernel (which should be evident from looking
at the graphs). Anyway using your above command on my system:

STATE: state0   DESC: CPUIDLE CORE POLL IDLE    NAME: POLL      LATENCY: 0      RESIDENCY: 0
STATE: state1   DESC: MWAIT 0x00        NAME: C1        LATENCY: 2      RESIDENCY: 2
STATE: state2   DESC: MWAIT 0x01        NAME: C1E       LATENCY: 10     RESIDENCY: 20
STATE: state3   DESC: MWAIT 0x10        NAME: C3        LATENCY: 80     RESIDENCY: 211
STATE: state4   DESC: MWAIT 0x20        NAME: C6        LATENCY: 104    RESIDENCY: 345

... Doug
