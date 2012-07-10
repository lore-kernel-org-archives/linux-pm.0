From: Rajendra Nayak <rajendra.nayak@linaro.org>
Subject: Re: [PATCH 2/4] cpuidle: define the enter function in the driver
 structure
Date: Tue, 10 Jul 2012 13:59:23 +0530
Message-ID: <4FFBE7E3.8020809@linaro.org>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>	<1341494608-16591-2-git-send-email-daniel.lezcano@linaro.org>	<201207052238.44330.rjw@sisk.pl> <4FF6C4C1.7030004@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4FF6C4C1.7030004@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On Friday 06 July 2012 04:28 PM, Daniel Lezcano wrote:
> The main purpose of all these cleanup patches are to move out all
> non-data information from the cpuidle_state structure in order to add a
> new api which could be 'cpuidle_register_cpu_latency(int cpu, struct
> cpuidle_latencies latencies)'.

So are there any technical difficulties in adding such an api with the
non-data information being part of cpuidle_state? Or its just that you
think the already duplicated non-data information (per state) is going
to be duplicated much more (per state per cpu) in most cases.

regards,
Rajendra

