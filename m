From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 3/8] arm, dts: add TC2 cpu capacity-dmips-mhz
 information
Date: Wed, 10 Aug 2016 16:52:08 +0100
Message-ID: <08d9e2ff-3c66-5129-1c82-df314e2204db@arm.com>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com>
 <1468932048-31635-4-git-send-email-juri.lelli@arm.com>
 <7ac935dc-9f8b-8af0-e67b-ef1c469d76f1@arm.com>
 <20160810154324.GJ3540@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160810154324.GJ3540@e106622-lin>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, vincent.guittot@linaro.org, Pawel Moll <pawel.moll@arm.com>, linux-pm@vger.kernel.org, peterz@infradead.org, catalin.marinas@arm.com, broonie@kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, will.deacon@arm.com, linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com, robh+dt@kernel.org, Sudeep Holla <sudeep.holla@arm.com>, linux@arm.linux.org.uk, Liviu Dudau <liviu.dudau@arm.com>, Kumar Gala <galak@codeaurora.org>, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 10/08/16 16:43, Juri Lelli wrote:
> Hi,
>
> On 10/08/16 16:33, Sudeep Holla wrote:
>> Hi Juri,
>>
>> On 19/07/16 13:40, Juri Lelli wrote:
>>> Add TC2 cpu capacity binding information.
>>>
>>
>> If you repost it,
>>
>> s/binding//
>>
>
> Yes, I think I'll need to repost, squashing the arm64 fix in the
> appropriate patch. Thanks.
>
>>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Thanks!
>
>> (assuming you take it via some other tree, let us know if it's
>>  OK to merge the DTS separately and you want us to pick them)
>>
>
> As per off-line discussion with Russell, binding doc and arm bits should
> go via his patch system. While arm64 bits could go separately via aarch64.
>
> Does this make sense?

Yes, we can pick up the juno and tc2 dts changes and send it via
arm-soc. I have already acked them, so you can take it via other tree if
required.

-- 
Regards,
Sudeep
