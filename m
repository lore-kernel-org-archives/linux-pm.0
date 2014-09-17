From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH 0/3] PM / clock_ops: allow to specify custom pm_clk_notifier
 callback
Date: Wed, 17 Sep 2014 19:04:50 +0300
Message-ID: <5419B122.3010509@ti.com>
References: <1406313096-29761-1-git-send-email-grygorii.strashko@ti.com>	<7hr3zln692.fsf@linaro.org>	<540F0381.7010500@ti.com> <CAMuHMdUJzXNep14ny24R=FhA4WzsWU9401ZU-nnZ_CkkJqxSsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUJzXNep14ny24R=FhA4WzsWU9401ZU-nnZ_CkkJqxSsA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Grant Likely <grant.likely@secretlab.ca>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On 09/17/2014 06:03 PM, Geert Uytterhoeven wrote:
> 
> On Tue, Sep 9, 2014 at 3:41 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>>> Since you're essentially gutting clock_ops, have you considered
>>> migrating to genpd and having your own pm_domain ops that manage your clocks?
>>
>> Yes. I've thought about using genpd. But:
>> - PM domain is not merged in 3.17 and I don't know if it will be merged in 3.18 :(
>> http://www.spinics.net/lists/arm-kernel/msg357003.html
> 
> Let's wait and see...
> 
>> - To switch using PM domains I will need to create PM domain node PER EACH device,
>> (if I understand PM domain bindings right). For example:
>>
>> +power_netcp: power-controller@0 {
>> +               compatible = "keystone,power-controller";
>> +               #power-domain-cells = <0>;
>> +               clocks = <&clkcpgmac>, <&clkpa>, <&chipclk12>;
>> +       };
>>
>> netcp: netcp@2090000 {
>>                  reg = <0x2620110 0x8>;
>> +               power-domains = <&power_netcp>;
>> ...
>> }
> 
> I think you can have one power-controller, and add the clocks and
> power-domains properties to the individual device nodes.
> 
> Then the power-controller driver can use the attach callback
> introduced in "[PATCH/RFC v2 04/12] PM / Domains: Add genpd attach/detach
> callbacks" (https://lkml.org/lkml/2014/9/16/429) to set up the clocks?

Thanks for the advice. I saw your series :)
Unfortunately, I think, It can't be used as is, because there still no way
 to separate "functional" and "optional" clocks for the device in DT.
So, I'll need to define some sort of "fck-clocks" or "pm-clocks" properties for each device -
but, it seems to be mostly impossible to obtain the approval of such a decision  :(
 (taking into account current state of discussion
  https://lkml.org/lkml/2014/6/12/441).

There no such problems with Gen PD, but, as drawback:
- I have to define one Gen PD per-device.
- some CLK data duplication is present if Driver code need
  to operate with clocks in legacy way (for example to get current
  CLK  frequency).

Actually, I've done RFC implementation already and I hope to post it soon.
My DT looks like:
+               netcp_domain: netcp_pm_controller {
+                       compatible = "ti,keystone-pm-controller";
+                       clocks = <&clkpa>, <&clkcpgmac>, <&chipclk12>;
+                       #power-domain-cells = <0>;
+               };
+
                netcp: netcp@2090000 {
                        reg = <0x2620110 0x8>;
                        reg-names = "efuse";
@@ -229,6 +252,7 @@
                        #address-cells = <1>;
                        #size-cells = <1>;
                        ranges;
+                       power-domains = <&netcp_domain>;
 
                        clocks = <&clkpa>, <&clkcpgmac>, <&chipclk12>;
                        dma-coherent;


By the way, looks like you did the same thing as I:
I've hacked cock_ops, You - Generic PD ;P
but the goal is the same - add hooks for platform's specific initialization code
to workaround imperfection of clock_ops framework :)

regards,
-grygorii
