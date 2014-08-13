From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: Fwd: [BUG] oops in cpufreq driver with AMD Kaveri CPU
Date: Wed, 13 Aug 2014 11:02:03 +0300
Message-ID: <2046251.2jAlA4AtII@spock>
References: <4708675.eITUXPv8Ih@spock> <CAOjmkp8h19de3bYaLpqmXxEynKi--gHBf6MxXuuNoDzZXw=O8Q@mail.gmail.com> <53EAA5BB.2010207@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53EAA5BB.2010207@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Cc: viresh.kumar@linaro.org, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 12 August 2014 18:39:39 Aravind Gopalakrishnan wrote:
> (btw, this is a 'Kabini' processor and not a
> 'Kaveri')

Right, sorry.

> (I think you mentioned you were able to reproduce on 3.16. So assuming
> -rc will be affected too)

At least, 3.16-rc7 was affected too.

> Are you noticing this BUG when you are running any particular load?
> I could help debug effort or test patches to fix issue(whenever
> necessary) if I have some way to reproduce this..

Well, there's no particular workload type. The machine in question is my home 
router with x2go session, torrents, i2p and tor. And the most difficult is to 
wait for the hang to occur, as it happens ~1 time per 24 hours or so (could be 
much sooner or a little bit later).

Also, I've noticed that there's no need to load CPU intentionally with some 
test scripts to trigger this bug as CPU frequencies are jumping constantly:

===
pf@defiant:~$ cat 
/sys/devices/system/cpu/cpu{0,1,2,3}/cpufreq/stats/trans_table 
   From  :    To
         :   1600000   1400000   1200000   1000000    800000 
  1600000:         0     21936     14210      9997     61789 
  1400000:     12195         0      2149      1026     20635 
  1200000:     10557       881         0      1631     21333 
  1000000:     10292      1021      1596         0     25018 
   800000:     74888     12167     16447     25273         0 
   From  :    To
         :   1600000   1400000   1200000   1000000    800000 
  1600000:         0     23610     14510      9827     61768 
  1400000:     13856         0      2445      1086     20849 
  1200000:     10925       885         0      1773     21581 
  1000000:     10206      1037      1683         0     24775 
   800000:     74727     12704     16526     25015         0 
   From  :    To
         :   1600000   1400000   1200000   1000000    800000 
  1600000:         0     26721     15016     10040     61981 
  1400000:     16249         0      2902      1150     21444 
  1200000:     11811       958         0      1939     23065 
  1000000:     11310      1159      1958         0     26525 
   800000:     74387     12907     17897     27823         0 
   From  :    To
         :   1600000   1400000   1200000   1000000    800000 
  1600000:         0     27715     13060     10143     62328 
  1400000:     18215         0      3379      1881     24753 
  1200000:     12920      1459         0      3529     27835 
  1000000:     13193      1915      3372         0     39240 
   800000:     68917     17139     25932     42167         0
===

-- 
Oleksandr post-factum Natalenko, MSc
pf-kernel community
https://natalenko.name/
