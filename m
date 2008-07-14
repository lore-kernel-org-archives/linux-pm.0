From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] TAP (and TUN?) devices not working
	after resume
Date: Mon, 14 Jul 2008 18:12:44 +0200
Message-ID: <200807141812.45264.rjw__6385.23591119355$1216052088$gmane$org@sisk.pl>
References: <20080714154720.791f6640@symphony>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080714154720.791f6640@symphony>
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
To: James Le Cuirot <chewi@aura-online.co.uk>
Cc: suspend-devel@lists.sourceforge.net, netdev@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 14 of July 2008, James Le Cuirot wrote:
> Hi,

Hi,

> uswsusp works great on my machine except for one thing. I use a TAP
> device for QEMU and after resuming from suspend, it doesn't work
> anymore until I delete it and recreate it. This is rather annoying
> because if I have QEMU open, it means I have to close it before
> recreating the interface and then boot Windows up again. I use OpenVPN
> to create/delete the interface but I think that's all it does. The rest
> is done by the kernel. So I'm guessing something's up with the TUN/TAP
> driver or uswsusp itself. I'm using version 0.8. Sorry if this has
> already been fixed.

This is a kernel problem, adding kernel-related CCs.

Thanks,
Rafael
