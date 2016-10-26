From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/4] dt-bindings: Update domain-idle-state binding to use
 correct compatibles
Date: Wed, 26 Oct 2016 09:57:35 +0100
Message-ID: <68dc67d1-b443-f7b1-6229-0ac54e403d61@arm.com>
References: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
 <1477409199-52182-4-git-send-email-lina.iyer@linaro.org>
 <7hh980taqp.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7hh980taqp.fsf@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@baylibre.com>, Lina Iyer <lina.iyer@linaro.org>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, linux-pm@vger.kernel.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, rjw@rjwysocki.net, brendan.jackman@arm.com, Sudeep Holla <sudeep.holla@arm.com>, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 25/10/16 21:49, Kevin Hilman wrote:
> Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Update domain-idle-state binding to use "domain-idle-state" compatible
>> from Documentation/devicetree/bindings/arm/idle-states.txt.
>>
>> Cc: <devicetree@vger.kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/power/power_domain.txt | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> With no current users for this, I don't see the point of adding a
> compatible now.
>
> IMO, this should wait and be added with the identified user we can
> discuss it then.
>

No, IMO it needs to be used for the proposed SoC idle/genpd solution.

I understand the nodes that are "arm,idle-state" compatible can be used
for this new SoC hierarchical idle management, but it was never defined
for that use originally. So this new feature must be advertised by the 
firmware with the presence of "domain-idle-state".

Yes we might have other ways to detect that but I have already seen that 
broken on the reference platform, so we need alternate/DT way to specify 
that.

Not all existing "arm,idle-state" compatible nodes will be capable of
supporting this new SoC idle feature. It's just better and safer for a
new feature getting added that relies on DT to have a new compatible.

-- 
Regards,
Sudeep
