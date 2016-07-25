From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v3 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Mon, 25 Jul 2016 12:33:20 +0200
Message-ID: <dfc8249b-08ec-888d-7a11-7c6033a1ab64@axentia.se>
References: <1bIiDr-0004G1-0P>
 <1468349295-4935-1-git-send-email-karl-heinz@schneider-inet.de>
 <1468349295-4935-2-git-send-email-karl-heinz@schneider-inet.de>
 <20160719041432.GB1640@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20160719041432.GB1640@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org

On 2016-07-19 06:14, Wolfram Sang wrote:
>> +batman@0a {
>> +    compatible = "lltc,ltc1760";
>> +    reg = <0x0a>;
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +
>> +    i2c@1 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
> 
> Rob, aren't those two lines inherited from above?

I too think they are inherited, but am a bit undecided whether I want
that fact to be explored or not, as they just happen to match. They do
not express the same thing (it is for the i2c-mux number in the parent,
and for the i2c device address in the children).

But the repetitions are indeed tedious when there are many muxed
buses...

Cheers,
Peter
