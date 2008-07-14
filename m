From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: [Suspend-devel] TAP (and TUN?) devices not working
	after resume
Date: Mon, 14 Jul 2008 09:31:01 -0700
Message-ID: <2c0942db0807140931j53d53bb8oae4f1b442fbc7018__6731.65484699911$1216053195$gmane$org@mail.gmail.com>
References: <20080714154720.791f6640@symphony> <200807141812.45264.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807141812.45264.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel@lists.sourceforge.net, netdev@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, James Le Cuirot <chewi@aura-online.co.uk>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 14, 2008 at 9:12 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, 14 of July 2008, James Le Cuirot wrote:
>> uswsusp works great on my machine except for one thing. I use a TAP
>> device for QEMU and after resuming from suspend, it doesn't work
>> anymore until I delete it and recreate it. This is rather annoying
>> because if I have QEMU open, it means I have to close it before
>> recreating the interface and then boot Windows up again. I use OpenVPN
>> to create/delete the interface but I think that's all it does. The rest
>> is done by the kernel. So I'm guessing something's up with the TUN/TAP
>> driver or uswsusp itself. I'm using version 0.8. Sorry if this has
>> already been fixed.
>
> This is a kernel problem, adding kernel-related CCs.

Oh, hmm. I noticed this about a year ago after a kernel upgrade, and
threw the below into /etc/acpi/resume.d/91-openvpn.sh to fix the issue
on resume. It was supposed to be temporary until I could track down
whether this was a kernel issue or whatnot, but then I sorta, uhm,
forgot to report it. But yeah, I see the same issue -- after resume,
the TUN device has disappeared, and openvpn needs to be told to close
and reopen for it to work again.

#!/bin/sh
# poke openvpn to rebuild the tunnel
if pidof openvpn > /dev/null; then
	killall -SIGHUP openvpn
fi
