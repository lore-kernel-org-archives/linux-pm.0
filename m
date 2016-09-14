From: Leo Li <pku.leo@gmail.com>
Subject: Re: [PATCH V2 1/7] dt-bindings: Update QorIQ TMU thermal bindings
Date: Wed, 14 Sep 2016 11:40:46 -0500
Message-ID: <CADRPPNQ+hikr1qNK1wPbLnhudUrU1bN_2iuYyRQnqCN4Zwh83Q@mail.gmail.com>
References: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com> <20160608195241.GA6805@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608195241.GA6805@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, rui.zhang@intel.com
Cc: Jia Hongtao <hongtao.jia@nxp.com>, devicetree@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>, Scott Wood <scott.wood@nxp.com>, Eduardo Valentin <edubezval@gmail.com>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 8, 2016 at 2:52 PM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jun 07, 2016 at 11:27:34AM +0800, Jia Hongtao wrote:
>> For different types of SoC the sensor id and endianness may vary.
>> "#thermal-sensor-cells" is used to provide sensor id information.
>> "little-endian" property is to tell the endianness of TMU.
>>
>> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
>> ---
>> Changes for V2:
>> * Remove formatting chnages.
>>
>>  Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>
> Acked-by: Rob Herring <robh@kernel.org>

Hi Zhang Rui,

Since you have applied the driver patch, can you also apply the
binding patch?  The binding is supposed to go with the driver.

Regards,
Leo
