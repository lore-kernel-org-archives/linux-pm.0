From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [3/3] 2.6.22-rc3: known regressions v2
Date: Fri, 01 Jun 2007 14:21:08 +0200
Message-ID: <46600F34.8010404__12782.7742755928$1180705818$gmane$org@googlemail.com>
References: <465FED20.3090206@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <465FED20.3090206@googlemail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@bitplanet.net>, "art@usfltd.com" <art@usfltd.com>, linux-usb-devel@lists.sourceforge.net, discuss@x86-64.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Marcus Better <marcus@better.se>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux1394-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, Ioan Ionita <opslynx@gmail.com>, Andi Kleen <ak@suse.de>
List-Id: linux-pm@vger.kernel.org

Hi all,

Here is a list of some known regressions in 2.6.22-rc3.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Suspend

Subject    : 2.6.22-rc1 suspend to RAM problem
References : http://permalink.gmane.org/gmane.linux.power-management.gene=
ral/5819
Submitter  : Marcus Better <marcus@better.se>
Handled-By : Stefan Richter <stefanr@s5r6.in-berlin.de>
             Kristian H=C3=B8gsberg <krh@bitplanet.net>
Status     : caused by fw-ohci module



USB

Subject    : usb hotplug/udev cannot correctly register usb/scanners
References : http://lkml.org/lkml/2007/5/15/205
Submitter  : art@usfltd.com <art@usfltd.com>
Status     : Unknown



x86-64

Subject    : x86-64 2.6.22-rc2 random segfaults
References : http://lkml.org/lkml/2007/5/24/275
Submitter  : Ioan Ionita <opslynx@gmail.com>
Status     : Unknown



Regards,
Michal

--
"Najbardziej brakowa=C5=82o mi twojego milczenia."
-- Andrzej Sapkowski "Co=C5=9B wi=C4=99cej"
