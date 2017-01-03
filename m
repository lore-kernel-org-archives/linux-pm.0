From: Roger Shimizu <rogershimizu@gmail.com>
Subject: Re: [PATCH v3 2/3] DT: bingdings: power: reset: add linkstation-reset
 doc
Date: Tue, 3 Jan 2017 23:11:19 +0900
Message-ID: <CAEQ9gEnKSDefeF_5WVRiu8pw5gnBWRoqYgMufoowox1ArD6e7w@mail.gmail.com>
References: <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161227070611.14852-1-rogershimizu@gmail.com>
 <20161227070611.14852-3-rogershimizu@gmail.com>
 <519e07d0-9b73-4445-ec5e-7ea2cbc1b814@gmail.com>
 <20170103131256.GB30197@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170103131256.GB30197@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ryan Tandy <ryan@nardis.ca>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dear Florian, Andrew,

Thanks for your comments!

On Tue, Jan 3, 2017 at 10:12 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> > +
>> > +Required Properties:
>> > +- compatible: Should be "linkstation,power-off"
>> > +- reg: Address and length of the register set for UART1
>>
>> Humm, should we instead have a phandle to the uart1 node?
>
> Probably. Again, this is to do with copying the QNAP driver. I was
> young, new to device tree, and i just did a logical conversion of the
> existing code, and did not at the time understand phandles, etc.

Can you tell me where should I place this document?
or simply remove it?

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
