From: Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: gpio-charger: Add
 status-gpios property
Date: Tue, 26 Feb 2019 15:40:38 +0100
Message-ID: <780b0ff3bb738ab36a5e729f74e6cfb2@artur-rojek.eu>
References: <20190205190316.19296-1-contact@artur-rojek.eu>
 <20190225215316.GA10117@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225215316.GA10117@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pm@vger.kernel.org

Hi Rob.

Thanks for the review.

On 2019-02-25 22:53, Rob Herring wrote:
> On Tue, Feb 05, 2019 at 08:03:15PM +0100, Artur Rojek wrote:
>> Add documentation for the "status-gpios" property.
>> 
>> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>> ---
>>  .../devicetree/bindings/power/supply/gpio-charger.txt         | 4 
>> ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt 
>> b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
>> index adbb5dc5b6e9..b98a05a4973c 100644
>> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
>> @@ -14,12 +14,16 @@ Required properties :
>>       usb-cdp (USB charging downstream port)
>>       usb-aca (USB accessory charger adapter)
>> 
>> +Optional properties:
>> + - status-gpios: GPIO indicating the charger status
> 
> So when it is asserted it has 'status'? What does status mean?
It is a GPIO indicating whether a battery is charging.
I shall make the description more clear.
> 
>> +
>>  Example:
>> 
>>  	usb_charger: charger {
>>  		compatible = "gpio-charger";
>>  		charger-type = "usb-sdp";
>>  		gpios = <&gpf0 2 0 0 0>;
>> +		status-gpios = <&gpf0 3 0 0 0>;
> 
> Humm, not sure what the thinking for 'gpios' was, but it's wrong and 
> you
> just copied it. If we follow the normal cell encoding with 2 cells, 
> this
> means the property takes 3 gpios (though the last 2 are marked not
> present with 0).
I will replace both of those properties with a valid example.

Artur
> 
> Rob
