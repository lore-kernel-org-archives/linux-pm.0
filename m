From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [PATCH] Bluetooth node manager causes up to ~3.25s
 delay in freezing tasks.
Date: Tue, 09 Dec 2008 22:37:15 +1100
Message-ID: <1228822635.6681.19.camel__40883.980858098$1228822731$gmane$org@nigel-laptop>
References: <1228809311.6681.12.camel@nigel-laptop>
	<1228821843.19553.3.camel@violet.holtmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1228821843.19553.3.camel@violet.holtmann.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

On Tue, 2008-12-09 at 12:24 +0100, Marcel Holtmann wrote:
> Hi Nigel,
> 
> > The bluetooth nodemanager function "nodemgr_host_thread" contains a loop
> > that calls try_to_freeze near the top of the loop, but then delays for
> > up to 3.25 seconds (plus time to do work) before getting back to the top
> > of the loop. When starting a cycle post-boot, this doesn't seem to bite,
> > but it is causing a noticeable delay at boot time, when freezing
> > processes prior to starting to read the image.
> 
> I don't wanna disappoint you, but IEEE1394 is actually Firewire and not
> Bluetooth :)

Aww. Sorry. All these newfangled technologies confuse an old-timer like
me. Oh, wait. I'm not even 40 yet.

I'll try the right list this time, I hope!

Nigel
