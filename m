From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Date: Fri, 6 Jan 2006 00:46:29 +0100
Message-ID: <20060105234629.GA7298@isilmar.linta.de>
References: <d120d5000512271355r48d476canfea2c978c2f82810@mail.gmail.com> <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net> <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net> <20060105215528.GF2095@elf.ucw.cz> <20060105221334.GA925@isilmar.linta.de> <20060105222338.GG2095@elf.ucw.cz> <20060105222705.GA12242@isilmar.linta.de> <20060105230849.GN2095@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752304AbWAEXqc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060105230849.GN2095@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 06, 2006 at 12:08:49AM +0100, Pavel Machek wrote:
> Ok, so lets at least add value-checking to .../power file, and prevent
> userspace see changes to PM_EVENT_SUSPEND value. 2 and 0 are now
> "arbitrary cookies". I'd like to use "on" and "off", but pcmcia
> apparently depends on "2" and "0", so...
> 
> Any objections?

Sorry, but yes -- the same as before, minus the PCMCIA breakage.

	Dominik
