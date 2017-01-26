From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: Add TI SCI PM Domains
Date: Thu, 26 Jan 2017 10:00:32 -0600
Message-ID: <CAL_JsqLQrJkJ6Z6fTRdZyxoefDaxistsipf6smt8eG-Lue0Q9A@mail.gmail.com>
References: <20170104205536.15963-1-d-gerlach@ti.com>
 <7bd282d9-df6f-f4c6-1f7f-c8ed81c78af3@ti.com>
 <CAL_JsqKxU4c=KSn0=xX9kmbk498fhqpiXMeGjcoe8Ah48FAzUg@mail.gmail.com>
 <3bb89649-fd2a-acc6-6968-e54a00842ce2@ti.com>
 <CAL_JsqL+L1oHAOv7tLevzbtRFSKRs9J01SgF=HR_vNNqNV+4+Q@mail.gmail.com>
 <84d7d49b-933b-8b26-f18a-3a5054738cb1@ti.com>
 <CAL_JsqJ9RitNC7ihC8ckJgV+49kaHk=W9tgdNBSjEfydhQS46A@mail.gmail.com>
 <0eaa9914-83f1-7716-cf04-1e3dd44df647@ti.com>
 <4cb25cf9-216f-2e18-f45d-ef7e48fa6c5e@ti.com>
 <m2ziip2puf.fsf@baylibre.com>
 <CAL_Jsq+Vp8iYrAUmuSRzeeY_G6CUqFqG6XB6erDxo1RYo3g4=g@mail.gmail.com>
 <CAPDyKFqzs59N5bc89X-96Fgy9b=_+s8zYmHHshQeDrJCnaqprA@mail.gmail.com>
 <58821CA2.4050701@ti.com>
 <CAPDyKFpTyn2isNahywmOOSWiZKov9xsudyWi_i-FejXjC+1AZw@mail.gmail.com>
 <ec2f1697-4c60-fd88-6593-2a69ca7f5c83@ti.com>
 <CAPDyKFq3zjyubxf3wc1V+F2W3rbnjj4ObFnHFvda+wCs4rBtnw@mail.gmail.com>
 <23936395-d653-56c8-13f9-6dfeb6e9257b@ti.com>
 <CAL_Jsq+9oEJJtHC4Gp_mWy_wJMLXsv2jgqKCMK8jm1MSWT-LRg@mail.gmail.com>
 <fec2e1b2-df90-e9ba-4925-ecdc12d696b9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <fec2e1b2-df90-e9ba-4925-ecdc12d696b9@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>, Kevin Hilman <khilman@baylibre.com>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Keerthy <j-keerthy@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 26, 2017 at 9:09 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
> On 01/25/2017 04:32 PM, Rob Herring wrote:
>>
>> On Wed, Jan 25, 2017 at 10:59 AM, Dave Gerlach <d-gerlach@ti.com> wrote:

[...]

>>> because genpd_xlate_simple only checks that the phandle is zero so that
>>> it
>>> can fail if it is not, but there's no functional reason it needs to do
>>> this.
>>> The genpd framework works as it did before no matter what the cells are
>>> set
>>> to if using of_genpd_add_provider_simple. Then in the attach_dev callback
>>> inside the ti_sci_pm_domains driver instead of doing
>>>
>>>         ret = of_property_read_u32(np, "ti,sci-id", &idx);
>>>
>>> to read the ti,sc-id for a device into idx we can now do:
>>>
>>>        ret = of_parse_phandle_with_args(np, "power-domains",
>>>                                    "#power-domain-cells", 0, &pd_args);
>>>        idx = pd_args.args[0];
>>>
>>> or even simpler from within our driver
>>>
>>>         ret = of_property_read_u32_index(np, "power-domains", 1, &idx);
>>
>>
>> This you should not be doing. The client driver shouldn't care how
>> many cells or what their values are.
>
>
> Client drivers in other places use xlate functions, like in the
> drivers/reset framework, to interpret the cells. Is doing it this way really
> that different?

Oh, I was thinking the client driver, not the power domain controller
driver. NM.

Rob
