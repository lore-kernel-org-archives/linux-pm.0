From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC] Migrate to Hz resolution for OPP binding
Date: Thu, 22 May 2014 08:27:39 -0500
Message-ID: <CAL_Jsq+1_W_d1WWkMUsHZYKXV=t9MN70iR25bnA8Emzh8zb2mg@mail.gmail.com>
References: <672dd8e9-2857-49fb-848f-d38d38b23c9b@BN1BFFO11FD024.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <672dd8e9-2857-49fb-848f-d38d38b23c9b@BN1BFFO11FD024.protection.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

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

Add this to the list of issues with the current OPP binding and define
a new binding, not a band-aid.

> As plan B, I was thinking to add the property 'operating-points-hz'..=
=2E
>
> Any better ideas?

=46ix clk_round_rate to specify how you want to round. There are
usecases for both rounding up and down. Don't you have the same
rounding problem with hz? Assume the person filling in OPP values
knows nothing about the kernel and you could have values rounded both
ways.

Rob
