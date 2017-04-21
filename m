From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH V5 4/7] ARM: pxa: Use - instead of @ for DT OPP entries
Date: Fri, 21 Apr 2017 18:02:32 +0200
Message-ID: <874lxhkauf.fsf@belgarion.home>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
 <cover.1492685450.git.viresh.kumar@linaro.org>
 <741bc9af28d6968e6a9409f94681066db5d1228b.1492685450.git.viresh.kumar@linaro.org>
 <87a87a7s66.fsf@belgarion.home> <20170421053041.GB26900@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170421053041.GB26900@vireshk-i7> (Viresh Kumar's message of
 "Fri, 21 Apr 2017 11:00:41 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, linaro-kernel@lists.linaro.org, arm@kernel.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 20-04-17, 22:14, Robert Jarzmik wrote:
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>> 
>> > Compiling the DT file with W=1, DTC warns like follows:
>> >
>> > Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
>> > unit name, but no reg property
>> >
>> > Fix this by replacing '@' with '-' as the OPP nodes will never have a
>> > "reg" property.
>> >
>> > Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>> > Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> > Acked-by: Rob Herring <robh@kernel.org>
>> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Thanks. But I need you to pick it up for your pull request for arm-soc.
Sure, let me take it through my tree, no problem.

Cheers.

-- 
Robert
