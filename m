From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Functional dependencies between devices
Date: Sat, 31 Oct 2015 11:22:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1510311118550.9118-100000@netrider.rowland.org>
References: <3097692.FmXPBhB5oa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3097692.FmXPBhB5oa@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 31 Oct 2015, Rafael J. Wysocki wrote:

> > One possible approach is to have a "wait_for_driver" flag, along with a
> > timeout value (or perhaps using a fixed timeout value).  When a
> > dependency gets registered with this flag set, the function call
> > wouldn't return until the target device is bound to a driver or the
> > timeout has elapsed.
> > 
> > This would make it easy to insert dependencies at probe time without 
> > relying on deferred probing.
> 
> I'm not sure about this to be honest.  It seems like implementing it might
> be sort of tricky.

Well, clearly it wouldn't work if probes were serialized and one driver
was dependent on another that was going to be probed later.  But if
probes are asynchronous then it ought to be okay (unless there is a
dependency cycle, in which case the situation is hopeless anyway).

Alan Stern
