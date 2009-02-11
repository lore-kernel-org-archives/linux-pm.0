From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: non-racy examples,
	please (was Re: [PATCH 01/13] PM: Add wake 	lock api.)
Date: Tue, 10 Feb 2009 19:12:36 -0800
Message-ID: <d6200be20902101912r5b753b62rbf8a7de31f4a4d9b@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<20090205091132.GG2077@elf.ucw.cz>
	<d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
	<20090208221747.GM6369@elf.ucw.cz>
	<d6200be20902081440y6c25a01cw1aae1c47b04bfd03@mail.gmail.com>
	<20090208231413.GV6369@elf.ucw.cz>
	<d6200be20902081535u689bfd58xe5aef77c5a4e6bd8@mail.gmail.com>
	<20090210111530.GB4636@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090210111530.GB4636@atrey.karlin.mff.cuni.cz>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 10, 2009 at 3:15 AM, Pavel Machek <pavel@ucw.cz> wrote:

>> I think a high priority sleep (like someone suggested) make more sense
>> than a forced sleep for this situation. The wakelock code could deal
>> with this as another wakelock type, and ignore normal wakelocks when a
>> high priority sleep is requested. We cannot necessarily ignore all
>> wakelocks since some may be used to manage the battery and charger.
>
> Now.. that's a differnce from PC. But...if you shutdown -h now, what
> happens to battery and charger?

If shutdown -h performs a poweroff and not just halt, the system will
power off if no charger is connected, or it will reboot and stay
bootloader (with the screen off) if the charger is connected. If you
halt and stop processing events, the other core will panic and reboot
the system.


-- =

Arve Hj=F8nnev=E5g
