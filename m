From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3][update] PM / sleep: Introduce command line
 argument for sleep state enumeration
Date: Wed, 30 Jul 2014 12:55:29 +0200
Message-ID: <20140730105529.GB12448@amd.pavel.ucw.cz>
References: <1817539.9KW2IGGbDV@vostro.rjw.lan>
 <3836835.YaZPGXsEQ2@vostro.rjw.lan>
 <34237308.7Kff3QYgup@vostro.rjw.lan>
 <2242480.eT2OxdNqLH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2242480.eT2OxdNqLH@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> For this reason I'm considering changing the defaul behavior going forward (so
> that "mem" is always present and means "the deepest sleep state available other
> than hibernation"), but I don't want to do that in one go.

Actually, I don't think that's good idea, at least on PC.

The way to wake up from S3 is power button. The way to wake up from
"echo freeze > state" is going to be different, right?

If I disable S3 in the BIOS and get different result from "echo mem >
state", that will be confusing.

Similar (but less severe) problem is there with S1, as it will
probably power down USB ports, etc.

So for example if I have system with S1, learn to do "echo mem >
state" and that it still charges my phone, then ACPI updates come and
"echo mem > state" now puts it in S3 and not charging my phone -- that
would be confusing.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
