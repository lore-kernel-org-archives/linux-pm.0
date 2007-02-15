From: "Mattia Dongili" <malattia@linux.it>
Subject: Re: [linux-pm] Suspend to RAM, Sony Vaio PCG-SRX51P, lcd stays off
Date: Thu, 15 Feb 2007 12:56:12 +0100 (CET)
Message-ID: <37556.85.47.20.193.1171540572.squirrel@picard.linux.it>
References: <45D43489.3060409@l4x.org> <20070215103639.GB27338@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070215103639.GB27338@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jan Dittmer <jdi@l4x.org>, stelian@popies.net, linux-acpi@vger.kernel.org, linux-pm@osdl.org, adaplas@pol.net, dawes@xfree86.org, Linux kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, February 15, 2007 11:36 am, Pavel Machek said:
> Hi!
>
>> I own an older Sony Vaio SRX51P, European Model, P3 based. s2ram
>> identifies it with
>>
>>     sys_vendor   = "Sony Corporation    "
>>     sys_product  = "PCG-SRX51P(DE)      "
>>     sys_version  = "01                  "
>>     bios_version = "R0232U2"
>>
>> Suspend to RAM by using "s2ram -v -m -f" actually works and the
>> laptop comes back to life, is accessible by network, etc. kudos
>> so far.
>> The only but serious problem is, that the lcd stays off after
>> resume. No matter what kind of options for s2ram I try, if I disable
>
> Is the _lcd_ off or the _backlight_ off? Use bright flashlight to
> tell.
>
>> framebuffer or suspend from X, the lcd always stays off. Only
>> a reboot fixes this. Note that the X driver also cannot dis-/enable
>> the lcd (xset dpms force off). It always stays lit. I also tried
>> with i810switch, but that also does not affect the lcd.
>> spicctrl -b42 neither.

(unrelated to your suspend problems) does the sony-laptop (formerly
sony_acpi) module helps controlling brightness?
(should appear soon or you can eventually grab it from the linux-acpi tree)

>> Latest kernel I tested is 2.6.20-git11 from today.

I read reports of successful suspends on that laptop, eg:
http://freenet-homepage.de/obauer/index.html

-- 
mattia
:wq!


