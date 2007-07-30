From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 2/2] Introduce CONFIG_SUSPEND
Date: Sun, 29 Jul 2007 22:47:57 -0400
Message-ID: <094CE21F-9AB6-4DD5-AF89-3A72116887E6__24242.4328033396$1185763771$gmane$org@mac.com>
References: <200707251238.50218.lenb@kernel.org>
	<200707292317.21419.rjw@sisk.pl> <20070729211824.GL16817@stusta.de>
	<200707292336.55588.rjw@sisk.pl> <1185744640.2295.4.camel@work>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1185744640.2295.4.camel@work>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Richard Hughes <hughsient@gmail.com>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Jul 29, 2007, at 17:30:40, Richard Hughes wrote:
> So are you guys using:
>
> "standby" = idle state, ~0.5 seconds
> "suspend" = sleep to ram, ~10 seconds
> "hibernate" = sleep to disk, ~30 seconds
>
> If so - you rock. This is the common nomenclature I've been pushing  
> for
> a few months now in GNOME, KDE and general userspace. I've written  
> up a
> spec here:
> http://cvs.gnome.org/viewcvs/*checkout*/gnome-power-manager/docs/ 
> sleep-names.html

Well, those times don't quite work for my PowerBook.  If we fixed  
suspend-to-RAM to reinitialize devices in parallel then it would  
easily hit 0.5 second transition times, but even now it's only at  
most 2 seconds.  Also once in a while I'll be too hasty plugging my  
USB devices and manage to hardlock one of the USB busses, but that's  
an isolated USB driver suspend issue.

And it's certainly not called "standby", because the box can  
literally remain asleep for 7 days on a full charge, versus about 5  
hours when just idle with wireless, backlight, and HDD off.

Cheers,
Kyle Moffett
