From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/7] PM / devfreq: exynos: Add the detailed correlation for
 Exynos5422 bus
Date: Fri, 15 Apr 2016 15:08:25 +0900
Message-ID: <57108559.5010102@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-3-git-send-email-cw00.choi@samsung.com>
 <20160411154514.GA29936@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20160411154514.GA29936@rob-hp-laptop>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, rjw@rjwysocki.net, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 2016=EB=85=84 04=EC=9B=94 12=EC=9D=BC 00:45, Rob Herring wrote:
> On Fri, Apr 08, 2016 at 02:00:41PM +0900, Chanwoo Choi wrote:
>> This patch adds the detailed corrleation between sub-blocks and powe=
r line
>> for Exynos5422.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  .../devicetree/bindings/devfreq/exynos-bus.txt        | 19 ++++++++=
+++++++++++
>>  1 file changed, 19 insertions(+)
>=20
> This belongs with your previous series. Probably, all of this should =
be=20
> 1 DT patch rather than piecemeal. Any division should be by h/w block=
,=20
> not as a driver is using features.

On previous patch-set[1] didn't support the Exynos5420 and include any =
information
about Exynos542x SoC because Exynos5420 must need the specific device d=
river
which is NoC (Network On Chip) Probe device. Only this patch-set suppor=
t
the NoC Probe device. So, I make this separate patch on this patch-set.

[1] http://www.spinics.net/lists/arm-kernel/msg495976.html
- [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency drive=
r and new passive governor

Best Regards,
Chanwoo Choi
