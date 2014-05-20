From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC 2/2] PM / OPP: extend DT parsing to allow voltage ranges
Date: Tue, 20 May 2014 11:09:58 -0500
Message-ID: <CAGo_u6pyU1O0uv-3CJc6OPoJ+bkcpNJ9_26JL3DxugX7dJhZfA@mail.gmail.com>
References: <1400596060-5330-1-git-send-email-l.stach@pengutronix.de>
	<1400596060-5330-3-git-send-email-l.stach@pengutronix.de>
	<537B6782.5080505@ti.com>
	<1400596877.4853.16.camel@weser.hi.pengutronix.de>
	<CAGo_u6qTFzVMhcWrk0L5Z4zykfLTMrkph0b4AJNEX7SS7pvWxQ@mail.gmail.com>
	<1400598429.4853.29.camel@weser.hi.pengutronix.de>
	<CAGo_u6ru5OgwCbJRrMNXUzeNLFMUvW=j8su6AAC4vmy3GOSM2g@mail.gmail.com>
	<CAGo_u6omOyuXvpDcirm36AnreGfa4nxisQ8BqZ8p2AVmWjfwbA@mail.gmail.com>
	<1400600908.4853.41.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36972 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbaETQJ7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 12:09:59 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so1250714wib.13
        for <linux-pm@vger.kernel.org>; Tue, 20 May 2014 09:09:58 -0700 (PDT)
In-Reply-To: <1400600908.4853.41.camel@weser.hi.pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, May 20, 2014 at 10:48 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Dienstag, den 20.05.2014, 10:29 -0500 schrieb Nishanth Menon:
>> On Tue, May 20, 2014 at 10:23 AM, Nishanth Menon <nm@ti.com> wrote:

[...]
>> If you need to handle PMIC accuracy, use voltage-tolerance.
>>
> And that's exactly one of the issues of the current binding, the
> tolerance isn't stable, but rather per OPP.
>
> As an example look at two operating points of the i.MX5:
>
> /*  kHz min(uV) nom(uV) max(uV) */
>  166666  850000  900000 1400000
> 1200000 1300000 1350000 1400000
>
> So for the 1,2GHz OPP the voltage tolerance is just 3,7% as anything
> bigger would exceed the absolute maximum rating, but for the 166MHz OPP
> it is already 64,7%.
>
> I agree that I could just cap the rail at 1,4V and give a max voltage
> equal to that as max_volt to the regulator API, but actually the device
> doesn't even know it's tolerance as it has no max defined. It makes
> having a max_volt in the regulator API kind of senseless, as connected
> devices don't know their maximum rating.

Is'nt that(voltage-tolerance binding) a different problem that needs a
different solution rather than creating a new binding for OPP - which
actually makes no description sense (since the max is absolute max)?

How can we address that? should we add some logic that says:

if voltage tolerance == 0, then try min_uV to max_opp_uV?
OR
introduce a new binding that says absolute-max-voltage (this is what I
was planning on doing with voltage domain btw).. and ensure that that
is used?

Personally, I never liked voltage-tolerance binding precisely for the
same reason as you bring up.. but that is a ABI now and we need to see
if the requirements can match with it, or define a new one keeping the
old ABI alive..

Regards,
Nishanth Menon
