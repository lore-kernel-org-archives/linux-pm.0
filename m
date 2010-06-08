From: Bryan Huntsman <bryanh@codeaurora.org>
Subject: Re: PM QoS dynamic resource manager
Date: Tue, 08 Jun 2010 16:48:27 -0700
Message-ID: <4C0ED6CB.4050709@codeaurora.org>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>	<20100525145223.GA4974@gvim.org>	<AANLkTikLgu2c1GPE3glHLlaznOM59SVeCj2NHzDjyjZR@mail.gmail.com>	<20100608033333.GA23066@gvim.org>	<AANLkTinGBvZm870CsjocsCV1SmQ-FCCbJLtKWR1juB1Q@mail.gmail.com>	<4C0ECC38.2000003@codeaurora.org>
	<AANLkTimK_RwRZHcEIxSshovgQLM6SBo2kLVoxWoEFFjx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimK_RwRZHcEIxSshovgQLM6SBo2kLVoxWoEFFjx@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Chan <mike@android.com>
Cc: linux-pm@lists.linux-foundation.org, mark gross <640e9920@gmail.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

>> Mike, one idea I'm exploring is having platform-specific busses with QoS
>> constraints specified via runtime_pm as part of the LDM.  Adding dynamic
>> class creation within pm_qos, or a type enum as you suggest, would work.
>>  However, I think this kind of behavior would fit nicely within runtime_pm.
>>
> 
> I'm not too familiar with the current work in runtime pm and LDM.
> However platform specific buses sounds like a good thing, at least
> more future proof. This works in the embedded SOC world but I'm
> wondering what happens when you have re-configurable hardware and now
> your same peripheral is sourcing a different bus?

My current thought is to have the board file enumerate the device on the 
proper bus.  This configuration is target-specific.  Each driver would 
register on as many buses as it needs to.  Some of the driver/bus 
registrations would be extraneous but the driver/device binding would 
only be possible on one bus.

> Does runtime pm hook into pm qos similar to how cpuidle uses pm qos?
> So the platform-specific buses would be aa pm rumtime or a pm qos
> addition?
> 
> -- Mike

Not to my knowledge.  I'm considering modeling the runtime_pm 
enhancements after pm_qos.  Meaning, there would be additional 
add/update/remove_requirements() callbacks added to struct dev_pm_ops 
for runtime_pm.  Instead of having a system-wide QoS sink per QoS class, 
the requirements would be passed up the LDM tree.  This way, a bus 
driver would be able to receive QoS constraints from all of it's devices 
and, combined with the active state of it's children from runtime_pm, be 
able to do some useful power management.  The entire bus could be 
throttled or idled in this manner.  This scheme would require the SW 
device topology to match the HW topology and not just have everything 
hang off the platform bus.

- Bryan
