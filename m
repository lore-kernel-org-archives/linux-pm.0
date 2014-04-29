From: Mascha Kurpicz <mascha.kurpicz@unine.ch>
Subject: Re: time_in_state on Ubuntu 13.10
Date: Tue, 29 Apr 2014 10:38:32 +0200
Message-ID: <535F6508.5020202@unine.ch>
References: <535E6906.2090201@unine.ch>	<CAOh2x==Q_oDn9v4S5ggh_e-3_=vSU_5Ko_89LfWM9ARBS9i=Rg@mail.gmail.com>	<535F51F7.5090804@unine.ch> <CAKohponpGMMRUvDivaxj_qz5dQvhxZHiHW4Z19GzpaEJHGStRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponpGMMRUvDivaxj_qz5dQvhxZHiHW4Z19GzpaEJHGStRQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Maxime Colmant <maxime.colmant@inria.fr>
List-Id: linux-pm@vger.kernel.org

On 04/29/2014 10:26 AM, Viresh Kumar wrote:
> On 29 April 2014 12:47, Mascha Kurpicz <mascha.kurpicz@unine.ch> wrote:
>> Sorry for the imprecision.
>>
>> Works correctly with
>> Ubuntu 12.04.3 LTS - kernel 3.2.0-29-generic
>> Ubuntu 12.04.3 LTS -  kernel 3.8.0-29
>> Ubuntu 13.10 - kernel 3.8.0-29-generic
>>
>> 0 or very small (e.g. 6) values with
>> Ubuntu 13.10 - kernel 3.11.0-20-generic
> Can you provide cpufreq-info 's output for the last two cases please?
>
> i.e.
>> Ubuntu 13.10 - kernel 3.8.0-29-generic
user@ubuntu1310:~$ cpufreq-info
cpufrequtils 008: cpufreq-info (C) Dominik Brodowski 2004-2009
Report errors and bugs to cpufreq@vger.kernel.org, please.
analyzing CPU 0:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 0 1 2 3
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency: 10.0 us.
  hardware limits: 1.60 GHz - 3.10 GHz
  available frequency steps: 3.10 GHz, 2.80 GHz, 2.60 GHz, 2.40 GHz,
2.20 GHz, 2.00 GHz, 1.80 GHz, 1.60 GHz
  available cpufreq governors: conservative, ondemand, userspace,
powersave, performance
  current policy: frequency should be within 1.60 GHz and 3.10 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1.60 GHz.
  cpufreq stats: 3.10 GHz:26.39%, 2.80 GHz:0.13%, 2.60 GHz:0.23%, 2.40
GHz:0.20%, 2.20 GHz:0.20%, 2.00 GHz:0.30%, 1.80 GHz:0.26%, 1.60
GHz:72.28%  (1742)
analyzing CPU 1:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 0 1 2 3
  CPUs which need to have their frequency coordinated by software: 1
  maximum transition latency: 10.0 us.
  hardware limits: 1.60 GHz - 3.10 GHz
  available frequency steps: 3.10 GHz, 2.80 GHz, 2.60 GHz, 2.40 GHz,
2.20 GHz, 2.00 GHz, 1.80 GHz, 1.60 GHz
  available cpufreq governors: conservative, ondemand, userspace,
powersave, performance
  current policy: frequency should be within 1.60 GHz and 3.10 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1.60 GHz.
  cpufreq stats: 3.10 GHz:2.17%, 2.80 GHz:0.04%, 2.60 GHz:0.07%, 2.40
GHz:0.09%, 2.20 GHz:1.06%, 2.00 GHz:0.31%, 1.80 GHz:0.42%, 1.60
GHz:95.84%  (2752)
analyzing CPU 2:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 0 1 2 3
  CPUs which need to have their frequency coordinated by software: 2
  maximum transition latency: 10.0 us.
  hardware limits: 1.60 GHz - 3.10 GHz
  available frequency steps: 3.10 GHz, 2.80 GHz, 2.60 GHz, 2.40 GHz,
2.20 GHz, 2.00 GHz, 1.80 GHz, 1.60 GHz
  available cpufreq governors: conservative, ondemand, userspace,
powersave, performance
  current policy: frequency should be within 1.60 GHz and 3.10 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1.60 GHz.
  cpufreq stats: 3.10 GHz:2.24%, 2.80 GHz:0.00%, 2.60 GHz:0.02%, 2.40
GHz:0.01%, 2.20 GHz:0.01%, 2.00 GHz:0.09%, 1.80 GHz:0.00%, 1.60
GHz:97.63%  (431)
analyzing CPU 3:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 0 1 2 3
  CPUs which need to have their frequency coordinated by software: 3
  maximum transition latency: 10.0 us.
  hardware limits: 1.60 GHz - 3.10 GHz
  available frequency steps: 3.10 GHz, 2.80 GHz, 2.60 GHz, 2.40 GHz,
2.20 GHz, 2.00 GHz, 1.80 GHz, 1.60 GHz
  available cpufreq governors: conservative, ondemand, userspace,
powersave, performance
  current policy: frequency should be within 1.60 GHz and 3.10 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1.60 GHz.
  cpufreq stats: 3.10 GHz:1.49%, 2.80 GHz:0.00%, 2.60 GHz:0.03%, 2.40
GHz:0.03%, 2.20 GHz:0.01%, 2.00 GHz:0.01%, 1.80 GHz:0.01%, 1.60
GHz:98.43%  (560)

>> Ubuntu 13.10 - kernel 3.11.0-20-generic
user@ubuntu1310:~$ cpufreq-info
cpufrequtils 008: cpufreq-info (C) Dominik Brodowski 2004-2009
Report errors and bugs to cpufreq@vger.kernel.org, please.
analyzing CPU 0:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency: 10.0 us.
  hardware limits: 1.60 GHz - 3.10 GHz
  available frequency steps: 3.10 GHz, 2.80 GHz, 2.60 GHz, 2.40 GHz,
2.20 GHz, 2.00 GHz, 1.80 GHz, 1.60 GHz
  available cpufreq governors: conservative, ondemand, userspace,
powersave, performance
  current policy: frequency should be within 1.60 GHz and 3.10 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1.60 GHz.
  cpufreq stats: 3.10 GHz:-nan%, 2.80 GHz:-nan%, 2.60 GHz:-nan%, 2.40
GHz:-nan%, 2.20 GHz:-nan%, 2.00 GHz:-nan%, 1.80 GHz:-nan%, 1.60
GHz:-nan%  (75)
analyzing CPU 1:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 1
  CPUs which need to have their frequency coordinated by software: 1
  maximum transition latency: 10.0 us.
  hardware limits: 1.60 GHz - 3.10 GHz
  available frequency steps: 3.10 GHz, 2.80 GHz, 2.60 GHz, 2.40 GHz,
2.20 GHz, 2.00 GHz, 1.80 GHz, 1.60 GHz
  available cpufreq governors: conservative, ondemand, userspace,
powersave, performance
  current policy: frequency should be within 1.60 GHz and 3.10 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1.60 GHz.
  cpufreq stats: 3.10 GHz:-nan%, 2.80 GHz:-nan%, 2.60 GHz:-nan%, 2.40
GHz:-nan%, 2.20 GHz:-nan%, 2.00 GHz:-nan%, 1.80 GHz:-nan%, 1.60
GHz:-nan%  (71)
analyzing CPU 2:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 2
  CPUs which need to have their frequency coordinated by software: 2
  maximum transition latency: 10.0 us.
  hardware limits: 1.60 GHz - 3.10 GHz
  available frequency steps: 3.10 GHz, 2.80 GHz, 2.60 GHz, 2.40 GHz,
2.20 GHz, 2.00 GHz, 1.80 GHz, 1.60 GHz
  available cpufreq governors: conservative, ondemand, userspace,
powersave, performance
  current policy: frequency should be within 1.60 GHz and 3.10 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1.60 GHz.
  cpufreq stats: 3.10 GHz:-nan%, 2.80 GHz:-nan%, 2.60 GHz:-nan%, 2.40
GHz:-nan%, 2.20 GHz:-nan%, 2.00 GHz:-nan%, 1.80 GHz:-nan%, 1.60
GHz:-nan%  (16)
analyzing CPU 3:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 3
  CPUs which need to have their frequency coordinated by software: 3
  maximum transition latency: 10.0 us.
  hardware limits: 1.60 GHz - 3.10 GHz
  available frequency steps: 3.10 GHz, 2.80 GHz, 2.60 GHz, 2.40 GHz,
2.20 GHz, 2.00 GHz, 1.80 GHz, 1.60 GHz
  available cpufreq governors: conservative, ondemand, userspace,
powersave, performance
  current policy: frequency should be within 1.60 GHz and 3.10 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 1.60 GHz.
  cpufreq stats: 3.10 GHz:-nan%, 2.80 GHz:-nan%, 2.60 GHz:-nan%, 2.40
GHz:-nan%, 2.20 GHz:-nan%, 2.00 GHz:-nan%, 1.80 GHz:-nan%, 1.60
GHz:-nan%  (6)


