From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 02/14] dt/bindings: update binding for PM domain idle
 states
Date: Thu, 4 Aug 2016 13:02:05 -0600
Message-ID: <20160804190205.GE1207@linaro.org>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
 <20160804152453.GB1732@brendan-thinkstation>
 <20160804162844.GC1207@linaro.org>
 <20160804181500.GE1732@brendan-thinkstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160804181500.GE1732@brendan-thinkstation>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Brendan Jackman <brendan.jackman@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, khilman@kernel.org, rjw@rjwysocki.net, Axel Haslam <ahaslam+renesas@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 04 2016 at 12:15 -0600, Brendan Jackman wrote:
>On Thu, Aug 04, 2016 at 10:28:44AM -0600, Lina Iyer wrote:
>> Hi Brenden,
>>
>> On Thu, Aug 04 2016 at 09:24 -0600, Brendan Jackman wrote:

[...]

>> >Then old kernels which don't have CPU PM Domains will lose the ability to
>> >suspend clusters. I've phrased this as a question because I'm not clear on what
>> >we require in terms of backwards/forwards compatibility with DTs - excuse my
>> >ignorance. What are your thoughts on this?
>> >
>> So, if the DT has only support for cluster modes in cpu-idle-states and
>> not the OSI specific representation, then it would continue to use only
>> PC mode to power down the cluster, even though the firmware may have
>> been updated to support OSI.
>>
>> That means, all the existing platforms will continue to work the way
>> they do even with these patches in place.
>>
>> Moreover, the way the PSCI state ids are for PC and OS intiated fall in
>> line with how we represent in the DT. PC cluster states are represented
>> in the original format and the OSI follow the extended state format. The
>> composite is made by an OR of the CPU state and the cluster idle state.
>>
>
>OK, this makes sense - I understand that these patches will not affect the
>behaviour if the DT stays the same. My question, though is what happens when a
>new DT with the new OSI structure is given to an older kernel without these
>patches applied.
>
>Example: right now we support PC cluster suspend on the Juno platform (see
>juno*.dts). Let's say Juno's firmware comes to support OSI suspend and we want
>to use that in Linux. We apply these patches then update the .dts, adding a CPU
>power domain tree, removing CLUSTER_SLEEP_0 from cpu-idle-states and adding it
>to the relevant power domain node's idle-states. Now we have OSI suspend on
>Juno. But then if we take our new DTB and feed it to a v4.7 kernel it will not
>be able to enter CLUSTER_SLEEP_0 because it is not in cpu-idle-states. Before we
>modified the DTB, v4.7 kernels were capable of entering CLUSTER_SLEEP_0 in PC
>mode.
>
>Does that make sense - do we expect newer DTBs to be compatible with older
>kernels, and if so how can we add OSI support to existing platforms without
>breaking older kernels?
>
I don't think it is a fair requirement to have newer DTB's run on older
kernels. But hypothetically, if you were to run the newer DTB with OSI
domains on a 4.7 kernel, it would NOT do cluster low power states, but
it would not fail because of OSI nodes. They will just be ignored.
Cluster low modes will not also happen, since you wouldn't have the
cpu-idle-states appending cluster modes after the CPU's modes.

Thanks,
Lina
