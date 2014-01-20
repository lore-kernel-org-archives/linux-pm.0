From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH RFC 04/10] base: power: Add generic OF-based power domain
 look-up
Date: Mon, 20 Jan 2014 18:32:53 +0100
Message-ID: <52DD5DC5.3000908@samsung.com>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-5-git-send-email-tomasz.figa@gmail.com>
 <20140116163409.GD25540@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20140116163409.GD25540@e102568-lin.cambridge.arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <Mark.Rutland@arm.com>, Pawel Moll <Pawel.Moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-pm@vger.kernel.org

Hi Lorenzo,

On 16.01.2014 17:34, Lorenzo Pieralisi wrote:
> Hi Tomasz,
>
> thank you for posting this series. I would like to use the DT bindings
> for power domains in the bindings for C-states on ARM:
>
> http://comments.gmane.org/gmane.linux.power-management.general/41012
>
> and in particular link a given C-state to a given power domain so that the
> kernel will have a way to actually check what devices are lost upon C-state
> entry (and for devices I also mean CPU peripheral like PMUs, GIC CPU IF,
> caches and possibly cpus, all of them already represented with DT nodes).
>
> I have a remark:
>
> -  Can we group device nodes under a single power-domain-parent so that
>     all devices defined under that parent won't have to re-define a
>     power-domain property (a property like interrupt-parent, so to speak)
>
> What do you think ?

Hmm, I can see potential benefits of such construct on platforms with 
clear hierarchy of devices, but to make sure I'm getting it correctly, 
is the following what you have in mind?

soc-domain-x@12340000 {
	compatible = "...";
	reg = <...>;
	power-domain-parent = <&power_domains DOMAIN_X>;

	device@1000 {
		compatible = "...";
		// inherits power-domain = <&power_domains DOMAIN_X>
	};

	device@2000 {
		compatible = "...";
		// inherits power-domain = <&power_domains DOMAIN_X>
	};
};

Best regards,
Tomasz
