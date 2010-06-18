From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] RFC: /sys/power/policy_preference
Date: Fri, 18 Jun 2010 01:56:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006180149120.7628@localhost.localdomain>
References: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
 <0F1C0B07-60D6-405B-890B-F9C320820CA5@gmail.com>
 <alpine.LFD.2.00.1006171500260.4214@localhost.localdomain>
 <AANLkTimWfE0WXr558sOnjZFptxpP4k6IvMWriR3seIKu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1548819180-1276840588=:7628"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <AANLkTimWfE0WXr558sOnjZFptxpP4k6IvMWriR3seIKu@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Victor Lowther <victor.lowther@gmail.com>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1548819180-1276840588=:7628
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 17 Jun 2010, Victor Lowther wrote:

> > The idea here is to not require user-space to need updating
> > whenever a future knob is invented.  We can do a great job
> > at documenting the past, but a poor job of documenting the future:-)
> 
> Well, I would suggest that the habit of not documenting what is
> happening with power management in the kernel needs to change, then.

Actually some of the knobs I showed in the examples
have been documented for *years*, yet are ignored
by user-space today.  I don't want to insult user-space
programmers, but the reality is that simpler is usually better.

> Having the documentation and example code for how to tweak the various
> power management settings from userspace is inherently more flexible
> than trying to expose a single knob from the kernel to userspace for
> power management, with little loss of flexibility.

Yes, the ultimate in flexibility is to update user-space whenever
some new driver or new knob appears in the kernel.  I'm not proposing
that ability be taken away.  I'm proposing that in many cases it
is unnecessary.

The idea is to have the ability to add something to the 
kernel and avoid the need to make any change to user-space.

thanks,
-Len Brown, Intel Open Source Technology Center

--8323328-1548819180-1276840588=:7628--
