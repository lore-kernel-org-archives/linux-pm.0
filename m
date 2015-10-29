From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Functional dependencies between devices
Date: Thu, 29 Oct 2015 10:31:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510291024190.1647-100000@iolanthe.rowland.org>
References: <CAAObsKARL=mG8bsvdU7AJSosDd3aw7CuH+OiLsi0Umc2B-L+nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKARL=mG8bsvdU7AJSosDd3aw7CuH+OiLsi0Umc2B-L+nQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Good grief, don't you guys ever trim unwanted material from your 
emails?  I had to erase more than 4 screens worth of useless stuff 
before getting to the relevant portions.

On Thu, 29 Oct 2015, Tomeu Vizoso wrote:

> >> Also, have you considered that not only drivers request resources? For
> >> example, the on-demand probing series would probe a device that is
> >> needed by an initcall, simplifying synchronization.

Did Rafael ever say that only drivers could create these functional
dependencies?  I don't recall seeing that anywhere.  Presumably any
part of the kernel will be allowed to do it.

> > You really need to explain what you mean here or maybe give an example.
> 
> There are initcalls that assume that a given resource is available.
> Because of async probes, or because the resource's driver being built
> as a module, or because the resource's driver gained a dependency
> (direct or not), those initcalls break unexpectedly at times.
> 
> If resource getters could probe dependencies on-demand, those
> initcalls would be more robust to changes in other parts of the
> codebase.
> 
> AFAIUI, your proposal would help with a device's dependencies being
> there when it's probed, but initcalls could still run into unfulfilled
> dependencies.

One possible approach is to have a "wait_for_driver" flag, along with a
timeout value (or perhaps using a fixed timeout value).  When a
dependency gets registered with this flag set, the function call
wouldn't return until the target device is bound to a driver or the
timeout has elapsed.

This would make it easy to insert dependencies at probe time without 
relying on deferred probing.

Alan Stern
