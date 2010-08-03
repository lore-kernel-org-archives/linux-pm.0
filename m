From: Mike Turquette <mturquette@ti.com>
Subject: Re: [linux-pm] Power management minisummit at Linux Plumbers Conference
 (November	3-5)
Date: Tue, 03 Aug 2010 15:30:56 -0500
Message-ID: <4C587C80.3040207@ti.com>
References: <20100803182746.GA32276@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20100803182746.GA32276@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Matthew Garrett wrote:
> I'm planning on finalising the schedule for the power management 
> minisummit at the Linux Plumbers Conference by the end of this week. If 
> anyone has topics that they'd like to discuss (or be discussed, if you 
> can't make it) then please let me know or register at 
> http://www.linuxplumbersconf.org/2010/ocw/events/proposals/ and file a 

That link did not really work for me, but I think I found the right 
place after a few clicks.

> proposal there. We're likely to be concentrating on userspace/kernel 
> interaction rather than pure kernel topics, so if you've got anything to 
> say about how we can handle application requirements without 
> compromising on our power savings then we'd love to hear from you.

Just FYI, I proposed a discussion on the issues that create such a large 
power gap between a CPUIdle-only system and a system with suspend (with 
the assumption that the lowest C-state can be hit by both).

I don't really want to present a formal lecture on it, but it would be 
nice to discuss with the group what can be done to shrink that gap a 
little in kernel space (badly behaving timers in platform-independent 
code) and in userspace (power-aware timers, coalescing timers, etc).

This is not intended to be another suspend-blocker discussion, but more 
of a discussion on what it takes to get CPUIdle to be more effective.

Regards,
Mike
