From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend to RAM and disk
Date: Mon, 16 Jan 2006 21:06:41 +0100
Message-ID: <200601162106.42512.rjw@sisk.pl>
References: <20060116114037.GA26986@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060116114037.GA26986@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: seife@suse.de, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, 16 January 2006 12:40, Pavel Machek wrote:
> In good old days of Pentium MMX, when ACPI was not yet born and APM
> ruled the world, I had and thinkpad 560X notebook. And that beast
> supported suspend-to-both: It stored image on disk, but then suspended
> to RAM, anyway. I think I want that feature back.
> 
> [Advantage was, that suspend/resume was reasonably fast for common
> case, yet you did not loose your opened applications if your battery
> ran flat. Speed advantage will be even greater these days -- boot of
> "resume" kernel takes most of time.]
> 
> Unfortunately, suspend-to-RAM is not in quite good state these
> days. It tends to work -- after you setup your video drivers according
> to video.txt, with some scripting needed. Unfortunately, after we
> suspended to disk, system is frozen -- we may not run scripts.
> 
> I guess the solution is to create userland application that will parse
> the DMI, look into table, and if it is neccessary do the vbe
> saving/restoring itself. (We may not run external binaries on frozen
> system; everything has to be pagelocked.) I guess that will include
> quite a lot of cut-copy-and-paste from various project, but I see no
> other way :-(.

Yes, I think we could embed the s2ram preparation in the suspending
application, and program it to operate like that:
1) freeze
2) call atomic snapshot
3) save the image
4) prepare s2ram
5) suspend to RAM
6) sleep
7) wake up (this would unfreeze processes too, if successful)
8) zap the image header

This would play some ping-pong with devices that would be suspended,
woken up and then suspended again before s2ram, but I don't think that's
avoidable in the current state of things.

Greetings,
Rafael
