From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 2/5] swsusp: Use memory bitmaps
	during resume
Date: Wed, 9 Aug 2006 13:51:06 +0200
Message-ID: <200608091351.06596.rjw@sisk.pl>
References: <200608091152.49094.rjw@sisk.pl> <200608091304.35746.rjw@sisk.pl>
	<20060809113335.GP3308@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060809113335.GP3308@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday 09 August 2006 13:33, Pavel Machek wrote:
]--snip--[
> =

> I'm still not sure if highmem support is worth the complexity -- I
> hope highmem dies painful death in next 3 weeks or so.

metoo, but currently quite a lot of Core Duo-based notebooks with 1 GB of R=
AM
and more are still being sold, let alone the Celerons, Semprons etc.

The patch is designed so that the higmem-related parts are just dropped by =
the
compiler if CONFIG_HIGHMEM is not set.  That makes it a bit larger, but then
they don't get in the way when they are not needed.

[Well, I've been using 64-bit machines only for quite some time anyway, but
I thought it would be nice to do something for the others, too. ;-) ]

Rafael
