From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH V3 4/4] cpuidle: Single/Global
 registration of idle states
Date: Thu, 21 Apr 2011 10:23:27 +0530
Message-ID: <4DAFB847.50404__34013.8437379666$1303361667$gmane$org@linux.vnet.ibm.com>
References: <20110420065445.332.13688.stgit@tringupt.in.ibm.com>
	<20110420065608.332.30043.stgit@tringupt.in.ibm.com>
	<87k4eo6d5m.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87k4eo6d5m.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: venki@google.com, davinci-linux-open-source@linux.davincidsp.com, ak@linux.intel.com, len.brown@intel.com, peterz@infradead.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 04/20/2011 11:03 PM, Kevin Hilman wrote:
> Trinabh Gupta<trinabh@linux.vnet.ibm.com>  writes:
>
>> With this patch there is single copy of cpuidle_states structure
>> instead of per-cpu. The statistics needed on per-cpu basis
>> by the governor are kept per-cpu. This simplifies the cpuidle
>> subsystem as state registration is done by single cpu only.
>> Having single copy of cpuidle_states saves memory. Rare case
>> of asymmetric C-states can be handled within the cpuidle driverand
>> architectures such as POWER do not have asymmetric C-states.
>
> I haven't actually tested this series on OMAP yet, but it currently
> doesn't compile.

Hi Kevin,

Yes, I tested it only for x86 (as I had mentioned in the description
of the patch series). I just wanted to get comments on the design
and understand how it affects various architectures in question. It
looks to me as if the design should be okay and infact better for
architectures like ARM since they do not have different idle
states for different cpus and thus do not require per-cpu registration.
Global registration would work and be simpler; please correct me if I am
wrong.

>
> The patch below (on top of your series) is required to compile on OMAP,
> I think it's doing what you intended, but please confirm.

Thanks for helping with this.

-Trinabh
