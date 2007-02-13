From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/12] power management: no valid states w/o
	pm_ops + docs
Date: Tue, 13 Feb 2007 13:12:49 +0100
Message-ID: <20070213121249.GJ18101@elf.ucw.cz>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124612.176570000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070207124612.176570000@sipsolutions.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> This patch changes /sys/power/state to not advertise any valid states
> (except for disk if SOFTWARE_SUSPEND is enabled) when no pm_ops have been
> set so userspace can easily discover what states should be available.
> =

> Also, because the pm ops in powermac are obviously not using them as
> intended, I added documentation for it in kernel-doc format.
> =

> Reordering the fields in struct pm_ops not only makes the output of
> kernel-doc make more sense but also removes a hole from the structure on
> 64-bit platforms.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-pm@lists.osdl.org
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Pavel Macheck <pavel@ucw.cz>

Looks okay to me.
										Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
