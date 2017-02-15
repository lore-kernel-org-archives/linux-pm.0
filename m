From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v3 01/18] dt-bindings: power: battery: add
 constant-charge-current property
Date: Wed, 15 Feb 2017 09:53:40 +0100
Message-ID: <6a678b03-124a-76b3-066e-858731fc6c80@free-electrons.com>
References: <20170215004646.23607-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170215004646.23607-1-liam@networkimprov.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Breck <liam@networkimprov.net>, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, bonbons@linux-vserver.org, icenowy@aosc.xyz, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 15/02/2017 01:46, Liam Breck wrote:
> 
> On Tue, 14 Feb 2017 10:40:55 +0100 Quentin Schulz wrote:
>> This adds the constant-charge-current property to the list of optional
>> properties of the battery.
>>
>> The constant charge current is critical for batteries as they can't
>> handle all charge currents.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>
>> added in v3
>>
>>  Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++
> 
> Is constant-charge-current dependent on the battery (e.g. capacity, nominal voltage, etc) or the 
> system (charger chip, input current/voltage, etc)?
> 
> It belongs in Doc.../power/supply/battery.txt if it's a characteristic of the battery.
> 
> Note, this page asserts that constant-current charging applies to NiMH batteries:
> http://power-topics.blogspot.com/2016/05/constant-voltage-constant-current.html
> 
> Related properties to be added to battery.txt near-future in a patchset for the BQ24190 
> charger are as follows. These are not currently in enum power_supply_property, so the actual names 
> are still to be decided.
> 
> precharge-current-microamp:
>    maximum charge current during precharge phase (typically 20% of battery capacity)
> 
> termination-current-microamp (or endcharge-current):
>    a charge cycle terminates when the battery voltage is above recharge threshold,
>    and the current is below this setting (typically 10% of battery capacity)
> 

We have a client with a board whose battery accepts a maximum of 300mA
for charging. So depending on the battery, we cannot have any charging
current we want. The AXP PmMICs set constant charge current in a range
of 300mA-1800mA, so it is enforced by the charger but needs to be
adapted depending on the battery present in the system.

The AXP PMICs charge battery with constant current (Ichrg) between the
trickle voltage (Vtrkl which is ~3.0V) and the targeted voltage (Vtrgt;
which seems to be the voltage telling the battery is fully charged).

So if I understand correctly, "my" constant-charge-current would be
located in the charging cycle between your precharge-current-microamp
and the termination-current-microamp as it is the current for the
charging process as a whole.

See here[1] for the explanation in the datasheet (page 20).

That would definitely match what is explained in your link for constant
current.

[1] http://dl.linux-sunxi.org/AXP/AXP209_Datasheet_v1.0en.pdf

Let me know if something seems odd,
Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
