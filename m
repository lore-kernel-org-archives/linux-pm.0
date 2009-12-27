From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Resume hanging on MSI motherboard
Date: Sun, 27 Dec 2009 11:20:53 +0100
Message-ID: <20091227102053.GD1478@ucw.cz>
References: <20091204081739.575b29d5@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091204081739.575b29d5@mjolnir.ossman.eu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <pierre-list@ossman.eu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri 2009-12-04 08:17:39, Pierre Ossman wrote:
> I have a MSI Neo2-Digital board that I'm trying to get suspend working
> on. I'm not having much luck though, so I need some pointers on how to
> debug this.
> 
> The symptoms are that the machine shuts down when suspend is triggered
> and wakes up when the power button is pressed or an usb device pokes
> it. Unfortunately it never gets back to a running state. It rattles a
> bit on the disk, powers up the fans and turns on the LEDs, but that's
> it.
> 
> Doing a suspend in Windows has entirely different behaviour. There it
> keeps all fans running, and doesn't do much in the way of saving power.
> It goes from 90 W to 67 W from idle to "standby". The [broken] state
> Linux puts the system in OTOH runs at 13 W ("off" is 10 W).

Well, if suspend (S3) does not even work on windows.....?

Try S1 in linux (echo 1 > proc/acpi/sleep), also try swsusp.

dmesg and askfor help on linux-acpi...?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
