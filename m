From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH 0/5] Functional dependencies between devices
Date: Wed, 8 Jun 2016 19:24:15 +0200
Message-ID: <CAJZ5v0ggk6433uM2Xx=0krgjvVrr28tPg1a+LSs6bW0M_t_rFQ@mail.gmail.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <2576341.476ZsjkPgF@vostro.rjw.lan>
 <20160608121517.GG7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608121517.GG7510@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 8, 2016 at 2:15 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jan 14, 2016 at 02:52:11AM +0100, Rafael J. Wysocki wrote:
>
>> What follows is my prototype implementation of this.  It took some time
>> to develop (much more than I was hoping for), but here it goes at last.
>
> Might be worth posting this outside the thread with CCs to people
> working on system integration like SoC maintainers - I'd completely
> missed this as it was buried and looked like the middle of an old
> discussion.

OK

I can resend it afresh, but need to do some rework due to some changes
that happened in the meantime.
