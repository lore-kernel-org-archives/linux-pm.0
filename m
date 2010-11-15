From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.37-rc1+: hibernate regression,
	claims not enough swap space
Date: Mon, 15 Nov 2010 23:26:44 +0100
Message-ID: <201011152326.44357.rjw__4991.38589152626$1289860134$gmane$org@sisk.pl>
References: <20101114052138.GB2189@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101114052138.GB2189@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, November 14, 2010, Pavel Machek wrote:
> Hi!

Hi,

> ...but there's enough -- or at least it was enough to fit previous
> versions. 32-bit machine, so it has highmem.
> 
> System is in console mode, very lightly loaded.
> 
> Mem:   2054716k total,   736548k used,  1318168k free,    15368k buffers
> Swap:   779148k total,     2360k used,   776788k free,   546388k cached

Well, the swap is rather in short supply.  Below the 50% of RAM recommendation.

> thinkpad_acpi: ACPI backlight control delay disabled
> PM: thaw of devices complete after 539.577 msecs
> PM: writing image.
> PM: Free swap pages: 194166
> PM: Not enough free swap
> Restarting tasks ...
> 
> Aha, and it is the new default /sys/power/image_size .. setting it to
> 0 lets machine hibernate. I guess the new default is very wrong for
> highmem machine...

The old default did the wrong thing for everyone with sufficient swap (it made
the OOM code trigger every time while preparing to create an image), so I think
the new one it's better overall.

Thanks,
Rafael
