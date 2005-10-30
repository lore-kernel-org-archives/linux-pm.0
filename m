From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 0/6] swsusp: rework swap handling
Date: Sun, 30 Oct 2005 13:17:20 +0100
Message-ID: <20051030121719.GA19134@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <20051029230515.GE14209@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932143AbVJ3MRg@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051029230515.GE14209@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org, ast@domdv.de
List-Id: linux-pm@vger.kernel.org

Hi!

> > I have divided the changes into some more or less logical steps for clarity.
> > Although the code has been designed as proof-of-concept, it is functional
> > and has been tested on x86-64, except for the cryptographic functionality
> > and error paths.
> 
> Don't worry about crypto paths too much. It is my fault, I should not
> have taken them in the first place. Just ask ast for testing when you
> are reasonably confident it will work.

We exchanged few emails with ast, and he'll probably not kill me if I
remove crypto swsusp support. That's good news ;-).
								Pavel
-- 
Thanks, Sharp!
