From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 0/4] cpufreq: powernv: Redesign the presentation of
 throttle notification
Date: Tue, 12 Jan 2016 08:02:23 +0530
Message-ID: <20160112023223.GF1084@ubuntu>
References: <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1452545680-11976-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160111222312.GA3967@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160111222312.GA3967@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11-01-16, 14:23, Greg KH wrote:
> On Mon, Jan 11, 2016 at 02:54:36PM -0600, Shilpasri G Bhat wrote:
> > In POWER8, OCC(On-Chip-Controller) can throttle the frequency of the
> > CPU when the chip crosses its thermal and power limits. Currently,
> > powernv-cpufreq driver detects and reports this event as a console
> > message. Some machines may not sustain the max turbo frequency in all
> > conditions and can be throttled frequently. This can lead to the
> > flooding of console with throttle messages. So this patchset aims to
> > redesign the presentation of this event via sysfs counters and
> > tracepoints. 
> > 
> > Patches [2] to [4] will add a perf trace point "power:powernv_throttle" and
> > sysfs throttle counter stats in /sys/devices/system/cpu/cpufreq/chipN.
> > Patch [1] solves a bug in powernv_cpufreq_throttle_check(), which calls in to
> > cpu_to_chip_id() in hot path which reads DT every time to find the chip id.
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 
> </formletter>

Also you shouldn't use --in-reply-to for the new versions of a
multiple patch series. Just use a new thread.

-- 
viresh
