From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: How to power gate a specific single device from outside?
Date: Wed, 25 Oct 2017 00:56:35 +0100
Message-ID: <20171025005635.57f1b926@alans-desktop>
References: <CAHKzcEP6dQ1PxB35yCW_R1W8yZCCsJN_HqiZ6uq2d+sZp_9EYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHKzcEP6dQ1PxB35yCW_R1W8yZCCsJN_HqiZ6uq2d+sZp_9EYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> I could not find anything standard that let me power gate single
> device from userland. Perhaps it's considered as a too risky operation
> to expose to the user. I don't want to touch drivers too much as well
> not to make them dependant on extra system feature. Better to have a
> separate module that handles this system mode and forces some drivers
> to unload/power gate their HW.
> 
> Are there already some proven solutions/ideas around the kernel that
> can be used straight away?

For a lot of devices if you close it then it will try and put the device
into a low power state. If a driver isn't doing that then (unless there
are hardware constraints preventing it) it would make sense to fix it.

There are some things entirely in your control - big ones. In particular
the brightness of laptop panels, pulling everything off one CPU socket,
disabling the nmi watchdog, hard disk power settings, stopping processes
that wake up a lot.

Many of those you can set anyway for best power behaviour (see powertop).

Alan
