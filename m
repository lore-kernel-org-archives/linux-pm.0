From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC] Migrate to Hz resolution for OPP binding
Date: Tue, 20 May 2014 18:11:33 -0500
Message-ID: <CAGo_u6rftjYAEy0wSFA6aqCDNsriC9r-cMVSqeX1xqKCVBqe7g@mail.gmail.com>
References: <672dd8e9-2857-49fb-848f-d38d38b23c9b@BN1BFFO11FD024.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:63017 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbaETXLf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 19:11:35 -0400
In-Reply-To: <672dd8e9-2857-49fb-848f-d38d38b23c9b@BN1BFFO11FD024.protection.gbl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, lkml <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, dt list <devicetree@vger.kernel.org>

On Tue, May 20, 2014 at 5:30 PM, S=C3=B6ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> Hi,
>
> I guess this is just to evaluate how big the lynch mob will be. Anywa=
y:
> Triggered by this discussion https://lkml.org/lkml/2014/5/15/46, I
> looked a little into what it would take to migrate everybody to Hz
> frequency resolutions to avoid all the conversions between cpufreq, C=
CF,
> OPPs, etc.
> Turns out, OPPs are already stored in Hz resolution in the kernel, bu=
t the DT
> bindings use kHz resolution to specify them in DT. So, code-wise ther=
e
> is just a removal of a multiplication in the OPP parser (see below), =
but
> then there are the DT bindings...

Yep :( unfortunately, so :(

>
> As plan B, I was thinking to add the property 'operating-points-hz'..=
=2E
>
> Any better ideas?

property operating-points-hz as a bool perhaps -> that modifies the
description and maintains legacy dtb support sounds OK to me if DT
folks and Rafael are ok with it as well.

Regards,
Nishanth Menon
