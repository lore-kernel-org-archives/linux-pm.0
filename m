From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Auto reboot when CPU at full load with X86_ACPI_CPUFREQ
Date: Sun, 11 Nov 2012 22:00:53 +0100
Message-ID: <20121111210053.GA6436@elf.ucw.cz>
References: <CAJiejCRAZjNWGyJipfprHGptR2051Fdqf-10OkO0Yks7C2dQ0A@mail.gmail.com>
 <CAJiejCT8F18fH9yrtTDfHydFi6TDNdDWf8Ny7OATokf7EM-X1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJiejCT8F18fH9yrtTDfHydFi6TDNdDWf8Ny7OATokf7EM-X1g@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> I'm using Intel Xeon X5570 x2 with Asus Z8PE-D18, and experiencing
> auto reboot when CPU full loaded for minutes, like building kernel
> with "make -j17". After a lot of bisecting of config file, I found the
> option leads to the reboot: X86_ACPI_CPUFREQ, both configed
> X86_ACPI_CPUFREQ as a module or built in will lead to reboot.
> 
> Config file finally bisected appended, config-3.7.0-rc3+-bad is the
> one leads to reboot, config-3.7.0-rc3+-ok works OK. Hardware info also
> appended.
> 
> I think it is a bug, anything I can do? When the bug triggered, the
> screen blanked immediately, any advice for me to debug? Happy to match
> to code :-)
> 
> This bug is CPU specific, with Xeon E5606 or E5620 it's all fine, just
> triggered with Xeon X5570, or maybe all Xeon X serial.
> 
> Tested kernel version: 3.1.x, 3.3.x, 3.5.x, 3.6.x, 3.7*, they are all affected.

What does temperature do during those runs? 
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
