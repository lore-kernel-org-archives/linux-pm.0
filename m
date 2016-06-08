From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH 2/5] driver core: Functional dependencies tracking support
Date: Wed, 8 Jun 2016 20:12:34 +0200
Message-ID: <CAJZ5v0ipDXrgx3=cFuxzofkXLMzErETuqSSnf8ugo5jnB0ynNA@mail.gmail.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <2576341.476ZsjkPgF@vostro.rjw.lan>
 <1816598.SuJvGrVRJK@vostro.rjw.lan> <20160608124844.GH7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608124844.GH7510@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 8, 2016 at 2:48 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jan 14, 2016 at 02:54:17AM +0100, Rafael J. Wysocki wrote:
>
>> + * A side effect of the link creation is re-ordering of dpm_list and the
>> + * devices_kset list by moving the consumer device and all devices depending
>> + * on it to the ends of those lists.
>
> How does this work in the scenario where a device instantiates a child
> device then uses services that child provides to complete the
> initializiation?  We do have that scenario currently for on chip
> regulators to allow external regulators to be used.

I'm not sure I understand the question correctly, but it that is the
parent and a child, we don't need an extra link entity to represent
that dependency, as parent-child dependencies are taken by the current
code into account already.

This series was supposed to help with dependencies that aren't of the
parent-child type.
