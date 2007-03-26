From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [3/5] 2.6.21-rc4: known regressions (v2)
Date: Mon, 26 Mar 2007 20:48:57 +0200
Message-ID: <20070326184857.GD16477@stusta.de>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<200703261200.25587.marcus@better.se>
	<20070326143433.GC16477@stusta.de>
	<200703261942.52126.marcus@better.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703261942.52126.marcus@better.se>
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
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-pci@atrey.karlin.mff.cuni.cz, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 26, 2007 at 07:42:51PM +0200, Marcus Better wrote:
> Adrian Bunk wrote:
> > > > Subject    : ThinkPad R60: suspend to disk broken
> =

> > Does setting CONFIG_PCI_MSI=3Dn make any difference?
> =

> Yes, it does. The hanging resume problem went away. =


Thanks for testing.

If you enable it again, does the patch from [1] also fix it?

> (The display corruption and the instant resume were not affected.)

Not a surprise - it's currently quite common that people run into =

several distinct suspend regressions...

> Marcus

cu
Adrian

[1] http://lkml.org/lkml/2007/3/24/136 [2]
[2] x86_64 uses arch/i386/pci/common.c

-- =


       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
