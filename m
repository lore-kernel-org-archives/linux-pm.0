From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend hangs since 2.6.34
Date: Thu, 10 Jun 2010 01:42:12 +0200
Message-ID: <201006100142.13131.rjw__6853.64954774759$1276127245$gmane$org@sisk.pl>
References: <20100609175356.GA17332@x61.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100609175356.GA17332@x61.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tino Keitel <tino.keitel+xorg@tikei.de>
Cc: intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 09, 2010, Tino Keitel wrote:
> Hi,
> 
> as of kernel 2.6.34 I sometimes get a strange hang during suspend to
> RAM. After echo mem > /sys/power/state, the suspend script hangs, Xorg
> eats 100% CPU, and the desktop is frozen. I can kill the script and the
> computer will then suspend and resume fine. The kernel log shows
> nothing interesting when the hang happens:
> 
> usblp0: removed
> usbcore: deregistering interface driver dvb_usb_vp7045
> dvb-usb: Twinhan USB2.0 DVB-T receiver (TwinhanDTV Alpha/MagicBox II)
> successfully deinitialized and disconnected.
> PM: Syncing filesystems ... done.
> 
> Is this a known problem?

No, it's not.

> I had rock stable suspend with 2.3.33.x. The
> computer is a Mac mini Core2 Duo with i945 graphics. I use KMS. I will
> compile a kernel with suspend debug to get more information if the hang
> happens next time.

Yes,  please try to get more information.

Rafael
