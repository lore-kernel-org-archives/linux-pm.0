From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Date: Thu, 9 May 2019 18:28:32 +0800
Message-ID: <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain>
 <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de>
 <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de>
 <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509095601.GA19041@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Mario Limonciello <Mario.Limonciello@dell.com>, Keith Busch <kbusch@kernel.org>, Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme <linux-nvme@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

at 17:56, Christoph Hellwig <hch@lst.de> wrote:

> On Thu, May 09, 2019 at 05:42:30PM +0800, Kai-Heng Feng wrote:
>>> That would be a set of 6 new suspend and resume callbacks, mind you,
>>> and there's quite a few of them already.  And the majority of drivers
>>> would not need to use them anyway.
>>
>> I think suspend_to_idle() and resume_from_idle() should be enough?
>> What are other 4 callbacks?
>>
>>> Also, please note that, possibly apart from the device power state
>>> setting, the S2I and S2R handling really aren't that different at all.
>>> You basically need to carry out the same preparations during suspend
>>> and reverse them during resume in both cases.
>>
>> But for this case, it’s quite different to the original suspend and
>> resume callbacks.
>
> Let's think of what cases we needed.
>
> The "classic" suspend in the nvme driver basically shuts down the
> device entirely.  This is useful for:
>
>  a) device that have no power management
>  b) System power states that eventually power off the entire PCIe bus.
>     I think that would:
>
>      - suspend to disk (hibernate)
>      - classic suspend to ram
>
> The we have the sequence in your patch.  This seems to be related to
> some of the MS wording, but I'm not sure what for example tearing down
> the queues buys us.  Can you explain a bit more where those bits
> make a difference?

Based on my testing if queues (IRQ) are not disabled, NVMe controller won’t  
be quiesced.
Symptoms can be high power drain or system freeze.

I can check with vendors whether this also necessary under Windows.

>
> Otherwise I think we should use a "no-op" suspend, just leaving the
> power management to the device, or a simple setting the device to the
> deepest power state for everything else, where everything else is
> suspend, or suspend to idle.

I am not sure I get your idea. Does this “no-op” suspend happen in NVMe  
driver or PM core?

>
> And of course than we have windows modern standby actually mandating
> runtime D3 in some case, and vague handwaving mentions of this being
> forced on the platforms, which I'm not entirely sure how they fit
> into the above picture.

I was told that Windows doesn’t use runtime D3, APST is used exclusively.

Kai-Heng
