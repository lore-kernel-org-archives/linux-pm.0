From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: intel-pstate driver not clocking down on Atom Z8750
Date: Sun, 25 Jun 2017 23:24:55 +0200
Message-ID: <13898444.q12oX9ZNe5@aspire.rjw.lan>
References: <CAAYJcCWViZ0DTj6e9XxN1xkiBR5CAbFA6R73jg=o8d2J6Z2raA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58538 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751343AbdFYVcT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2017 17:32:19 -0400
In-Reply-To: <CAAYJcCWViZ0DTj6e9XxN1xkiBR5CAbFA6R73jg=o8d2J6Z2raA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Christopher Williamson <home@chrisaw.com>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Sunday, June 25, 2017 03:39:11 PM Christopher Williamson wrote:
> Hi there,
> 
> I've just purchased a device called a "GPD Pocket" (more info at
> indiegogo.com/projects/gpd-pocket-7-0-umpc-laptop-ubuntu-or-win-10-os-laptop--2/x/7959405)
> but in short - one of the major problems I have with the device is that the
> included Intel Atom Z8750 never clocks below the turbo boost speed meaning
> it overheats very quickly and crashes.
> 
> I have managed to avoid this behaviour in two ways:
> 
> 1.) Disable turbo boost - the device then sits firmly at 1.6GHz and refuses
> to clock below that.
> 
> 2.) Disable the intel_pstate driver and the CPU then clocks properly but
> cannot turbo boost at all so I lose that capability.
> 
> I'm really just reaching out to you fine folks to find out where best to
> discuss this issue. I'm happy to raise a kernel bug report if that helps
> and also happy to provide command outputs as needed.
> 
> I have included Hans de Goede in the CC list on this email since he has
> been a great help getting to this point - this device has a few strange
> quirks to work through but this is a fairly serious one.

What kernel versions have you tried?

Thanks,
Rafael
