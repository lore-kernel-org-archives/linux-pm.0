From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH 2/5] driver core: Functional dependencies tracking support
Date: Wed, 8 Jun 2016 22:48:23 +0200
Message-ID: <CAJZ5v0hmkX53N519oATHMx7V2uUbiZYWcQ=Fvc1TW__Kw2nbhA@mail.gmail.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <2576341.476ZsjkPgF@vostro.rjw.lan>
 <1816598.SuJvGrVRJK@vostro.rjw.lan> <20160608124844.GH7510@sirena.org.uk>
 <CAJZ5v0ipDXrgx3=cFuxzofkXLMzErETuqSSnf8ugo5jnB0ynNA@mail.gmail.com> <20160608183535.GP7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37614 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161862AbcFHUsZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 16:48:25 -0400
In-Reply-To: <20160608183535.GP7510@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

On Wed, Jun 8, 2016 at 8:35 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 08, 2016 at 08:12:34PM +0200, Rafael J. Wysocki wrote:
>> On Wed, Jun 8, 2016 at 2:48 PM, Mark Brown <broonie@kernel.org> wrote:
>> > On Thu, Jan 14, 2016 at 02:54:17AM +0100, Rafael J. Wysocki wrote:
>
>> >> + * A side effect of the link creation is re-ordering of dpm_list and the
>> >> + * devices_kset list by moving the consumer device and all devices depending
>> >> + * on it to the ends of those lists.
>
>> > How does this work in the scenario where a device instantiates a child
>> > device then uses services that child provides to complete the
>> > initializiation?  We do have that scenario currently for on chip
>> > regulators to allow external regulators to be used.
>
>> I'm not sure I understand the question correctly, but it that is the
>> parent and a child, we don't need an extra link entity to represent
>> that dependency, as parent-child dependencies are taken by the current
>> code into account already.
>
> A parent (especially a MFD) may create a child to fulfil a role that
> could also be filled by a non-parent device, if that happens then
> depending on what ends up creating these links (it's not 100% clear from
> this series) it's likely that the link creation will also end up
> registering a dependency unless we do something special.  Now I think
> about it this does depend on how we create the children though, it's
> less likely to be an issue if the dependencies are created by firmware
> code.

If that's a non-child device, I would expect it to exist beforehand
and then the link creation would only enforce the specific ordering of
certain operations (like runtime PM or async suspend/resume) between
the two devices linked by it.  That shouldn't be problematic in
principle.

Let me redo the series, though (that may take a couple of days realistically).
