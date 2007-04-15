From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [3/3] 2.6.21-rc6: known regressions
Date: Mon, 16 Apr 2007 07:08:45 +0800
Message-ID: <1176678525.16909.3.camel@daplas>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<20070414003808.GU5907@stusta.de> <1176515823.4807.7.camel@daplas>
	<200704151826.33837.marcus@better.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704151826.33837.marcus@better.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcus Better <marcus@better.se>
Cc: linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-04-15 at 18:26 +0200, Marcus Better wrote:
> Antonino A. Daplas wrote:
> > A screen with blinking green blocks implies that your display is in text
> > mode, not in graphics mode.
> =

> Yes, it happens when I suspend from text mode.

Just for clarification, do you suspend from VESA framebuffer console or
from VGA text console? If from the latter, that's actually worse from
the user's point of view, but I can modify vgacon so that it saves its
state on suspend and restore it on resume.


> > If the above does not work, also try
> >
> > acpi_sleep=3Ds3_bios,s3_mode
> =

> Will try, but I'm using "s2ram -f -a3" which should mean precisely the ab=
ove =

> IIUC.

Okay.

Tony
