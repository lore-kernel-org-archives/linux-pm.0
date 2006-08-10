From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: PowerOp core patch
Date: Thu, 10 Aug 2006 20:43:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0608102041510.6141@poirot.grange>
References: <44D8D45F.80209@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <44D8D45F.80209@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <dsingleton@mvista.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Aug 2006, David Singleton wrote:

> Here is the core patch for the PowerOp concept.  It adds the powerop  =

> struct
> for opertaing point support to linux/pm.h and adds support to transition =

> to supported operating points by
> setting their name into /sys/power/state.

Sorry, a stupid question - reboot, halt / poweroff (always wanted to know =

the difference...) are not power states, right?...

> The supported operating points are shown in a readonly sysfs file,
> /sys/power/supported_states.

Thanks
Guennadi
---
Guennadi Liakhovetski
