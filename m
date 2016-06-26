From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Mon, 27 Jun 2016 00:35:17 +0200
Message-ID: <83b7648c-43d6-7a32-29bb-65f2606399fd@axentia.se>
References: <1466622436-27963-1-git-send-email-karl-heinz@schneider-inet.de>
 <1466622436-27963-2-git-send-email-karl-heinz@schneider-inet.de>
 <20160624175014.GA29990@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20160624175014.GA29990@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

On 2016-06-24 19:50, Rob Herring wrote:
> On Wed, Jun 22, 2016 at 09:07:15PM +0200, Karl-Heinz Schneider wrote:
>> This patch adds device tree documentation for the sbs-manager

*snip*

>> +
>> +From OS view the device is basically an i2c-mux used to communicate with up to
>> +four smart battery devices at address 0xb. The driver actually implements this
>> +behaviour. So standard i2c-mux nodes can be used to register up to four slave
>> +batteries. Channels will be numerated as 1, 2, 4 and 8.
>> +
>> +Example:
>> +
>> +batman@0a {
>> +    compatible = "sbs,sbs-manager";
>> +    reg = <0x0a>;
>> +    sbsm,i2c-retry-count = <3>;
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +
>> +    channel1@1 {
> 
> channel@1
> 
> Do we have a standard node name for mux nodes? If not, we should.

No name is enforced by the i2c mux support code, but I think "i2c"
dominates, and quite possibly it is the only documented name?

Cheers,
Peter
