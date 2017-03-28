From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [RFC 4/8] regulator: core: Check enabling bypass respects
 constraints
Date: Tue, 28 Mar 2017 22:49:55 +0300
Message-ID: <1490730595.15830.1.camel@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
         <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
         <20170324125212.vikgekqxsnu7htzl@sirena.org.uk>
         <1490704781.3546.57.camel@nxp.com>
         <20170328164754.z2c2ttovs3sxbcos@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-sn1nam01on0084.outbound.protection.outlook.com ([104.47.32.84]:38079
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752637AbdC1TuF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Mar 2017 15:50:05 -0400
In-Reply-To: <20170328164754.z2c2ttovs3sxbcos@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2017-03-28 at 17:47 +0100, Mark Brown wrote:
> On Tue, Mar 28, 2017 at 03:39:41PM +0300, Leonard Crestez wrote:
> > On Fri, 2017-03-24 at 12:52 +0000, Mark Brown wrote:

> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.

Sorry, still messing around with Evolution and Exchange.

> > > to the supply.  Usually bypass is used for low power retention modes
> > > with different settings to those used in normal operation that wouldn't
> > > be desired in normal operation, if we were going to have constraints for
> > > this I'd expect a separate set used during bypass.
> > 
> > In this particular case it's not possible to set constraints on the parent
> > regulator so that both ldo-enable and ldo-bypass modes work. The maximum allowed
> > voltage for ldo-bypass is lower than the minimum required to support the chip at
> > max frequency wit ldo-enable.
> 
> If things are really so sensitive that you can't bypass without lowering
> the voltage then it's hard to see how you can safely transition into and
> out of bypass mode.

The CPU frequency is set to the minimum value so that when bypass mode
is entered and voltage rises (because the dropout goes away) it is
still low enough. Transitioning out of bypass mode is not implemented
but you would presumably have to go to the minimum frequency again,
raise the voltage above what is required and the flip the switch.

> > I'm not sure I understand why you are against applying constraints to the parent
> > when in bypass mode, it seems like the obvious thing to do if you want to
> > support flexible configuration. The check I introduced is probably not enough to
> > cover all cases, for example it would still be possible to explicitly change
> > parent voltage afterwards.
> 
> To repeat what I said previously the whole point of bypassing is to not
> do regulation and generally the constraints in the unregulated idle case
> are substantially more relaxed.  This would break use cases relying on
> the existing behaviour which wouldn't expect to affect the parent
> voltage at all, either stopping things working or making them less
> efficient by needlessly regulating the voltage down which defeats the
> main point of bypassing.

So what you want is to prevent voltage changes unless strictly
required, even lowering? What I want is to get the minimum voltage in
the SOC because that's where power is being consumed.

It's not at all obvious that in bypass mode the output constraints of a
regulator need not be respected by the core. I expected the opposite,
this is something that should be documented.

But if the bypassed regulator has a downstream consumer then it's
requirements should definitely still be met in bypass mode, right? I
could set my maximum voltage directly from cpufreq in that case.

Or should a bypassed regulator ignore all other requests? One of the
behaviors that this patch series relies on is that calling set_voltage
on a bypassed regulator propagates this request to the supply and picks
the minimum voltage there. An alternative implementation would be to
call set_voltage directly on the supply regulator by changing the
"{arm,soc,pu}-supply" references in DT to point to the PMIC instead.
Would that be better?

Both approaches work. Relying on propagation feels like it is the
"right way" to handle this, even if it's harder to get right and the
regulator core does not entirely support it. But it's possible that
this is based on a misunderstanding of what "bypass" is actually
supposed to do.

-- 
Regards,
Leonard
