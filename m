From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm] Make swsusp work on i386 with PAE
Date: Thu, 2 Nov 2006 11:31:19 +0100
Message-ID: <20061102103119.GG1990@elf.ucw.cz>
References: <200610221548.48204.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200610221548.48204.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> The purpose of the appended patch is to make swsusp work on i386 with PAE,
> but it should also allow i386 systems without PSE to use swsusp.
> =

> The patch creates temporary page tables located in resume-safe page frames
> during the resume and uses them for restoring the suspend image (the same
> approach is used on x86-64).
> =

> It has been tested on an i386 system with PAE and survived several
> suspend-resume cycles in a row, but I have no systems without PSE, so that
> requires some testing.
> =

> Comments welcome.

Just a short update. I actualy tried it, and it seems to work
ok. Thanks!
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
