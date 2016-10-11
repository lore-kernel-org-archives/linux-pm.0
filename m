From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 5/8] dt/bindings: Update binding for PM domain idle
 states
Date: Tue, 11 Oct 2016 12:29:30 +0100
Message-ID: <5a50adda-5c34-2e6c-83a0-4e2b7d15ab51@arm.com>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
 <1475879821-8035-6-git-send-email-lina.iyer@linaro.org>
 <4e55d6ad-8de7-72d7-7512-5e4ff2aabc79@arm.com>
 <20161010164342.GC44885@linaro.org>
 <ffc0b521-329a-d41f-c952-bb9c4877ea87@arm.com>
 <20161010221332.GD44885@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161010221332.GD44885@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, khilman@kernel.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, Marc Titinger <mtitinger+renesas@baylibre.com>, brendan.jackman@arm.com, Sudeep Holla <sudeep.holla@arm.com>, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 10/10/16 23:13, Lina Iyer wrote:
> On Mon, Oct 10 2016 at 11:13 -0600, Sudeep Holla wrote:

[...]

>> Either we say this binding is ARM CPU specific or generic, I can't
>> understand this mix 'n' match really. You have removed all the
>> CPUIdle stuff from this series which is good and makes it simpler,
>> but linking it to only "arm,idle-state" make be feel it's not
>> generic. OK I will have a look at the RFC as why generic compatible
>> was rejected.
>>
> I will look for the discussion around it as well. A initial look
> through didn't get me the thread I was looking for.
>

Sure

[...]

>>
>> I understand that but it's not that simple which I assume you *do*
>> agree. Hence may need bit of an explanation in the binding(not here
>> of-course as I mentioned earlier, but in the CPU Idle bindings).
>> Please consider DT bindings as any other specification. All I am
>> asking is more description in the binding.
>>
> Any ideas of what description you would like to see? It seemed fairly
> explanatory in the idle-states.txt, so I didn't go into depth here.
>

Various use cases we discussed and what takes precedence,... etc
E.g.: if the Renasas example I pointed out had cpu-idle-states and
power-domain but no domain-idle-states which is perfectly valid without
this bindings.

Basically all the important this we have discussed so far. Even the
OSC/PCC is worth mentioning so that we are explicitly clear that this
binding has no affiliation to those PSCI methods. In short it should be
able to answer any question one might get if is completely new to this
binding but is aware of old one.

[...]

>>
>> Agreed and sorry if I created any confusion. But this binding doesn't
>> clearly state how to build up the hierarchy if the leaf node is not a
>> power-domain node and I am just trying have those clarifications in the
>> binding. It would be good if those details are *explicitly* mentioned in
>> the binding, not this particularly, but in CPU Idle one when you
>> introduce the user of that.
>>
> As we have today, devices have their own way of figuring out their idle
> states, they are not represented in DT (CPU being an exception).

I understand that, and I assume this binding will provide a way to
represent that for devices too if required. No ? Otherwise I see no
point in just saying it's generic.

-- 
Regards,
Sudeep
