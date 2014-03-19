From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH v2 2/2] intel_pstate: Set core to min P state during core
 offline
Date: Wed, 19 Mar 2014 08:32:03 -0700
Message-ID: <5329B873.7070100@intel.com>
References: <16035918.jZXKnQ3yiq@vostro.rjw.lan>	<1394831037-15553-1-git-send-email-dirk.j.brandewie@intel.com>	<1394831037-15553-3-git-send-email-dirk.j.brandewie@intel.com>	<CAOh2x=kFC5cwdYVgFCwNgqZAwWaE-CFQoyYizBuv1W6MOnQ9DA@mail.gmail.com>	<53285FDB.40102@gmail.com>	<532895DF.2090100@linux.vnet.ibm.com>	<5328A21C.3010909@intel.com> <CAKohpomM5s0v+442Pyg2HFguJs3tXKTNWFnHCfJmRJpTPvY=3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpomM5s0v+442Pyg2HFguJs3tXKTNWFnHCfJmRJpTPvY=3A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: dirk.j.brandewie@intel.com, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Patrick Marlier <patrick.marlier@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 03/18/2014 10:20 PM, Viresh Kumar wrote:
> On 19 March 2014 01:14, Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
>> There was no problem per se.  In stop() all I really needed to do is stop
>> the
>> timer and set the P state to MIN.
>>
>> At init time I need to allocate memory and start timer.  If stopping the
>> timer
>> and deallocating memory are separated then I need code in init() to detect
>> this case.
>
> Sorry, I didn't understood what exactly is special here :(
>
> If we return failure from CPU_POST_DEAD for some reason without
> calling exit() then you will have memory leak in your init() as we are
> allocating memory without checking if we already have that (nothing wrong
> in it though as other parts of kernel should handle things properly here).

No.  If you got the CPU_POST_DEAD callback CPU_DOWN_PREPARE has already
succeeded.  init() is called on the CPU_ONLINE and CPU_DOWN_FAILED path.

The issue is there is a two part teardown that can fail and the teardown
fail will be followed by a call to init().

If the timer is not running (stopped in stop()) then there is no reason to
have the memory around. If CPU_DOWN_PREPARE happens followed by CPU_DOWN_FAILED
then intel_pstate is ready for init() to be called with no special case
code.  This maintains the semantics the core expects.


>
> Probably the situation would be exactly same if we divide the exit path into
> stop and exit routines, which I still feel is the right way forward. Because
> ideally cpufreq shouldn't call init() if it hasn't called exit() (If
> it is doing that
> right now then its wrong and can be fixed). And so you must do the cleanup
> in exit()..
>

The core *is* doing this on the CPU_DOWN_FAILED path ATM.

On the CPU_DOWN_FAILED path the core should be undoing the work it did in the
CPU_DOWN_PREPARE path this would require another callback to drivers to let
them "restart" after a call to stop() as well.

I don't think it is worth that level of effort IMHO.

--Dirk
