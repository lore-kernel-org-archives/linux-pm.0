From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [6/6] 2.6.21-rc3: known regressions
Date: Wed, 14 Mar 2007 12:31:33 +0100
Message-ID: <20070314113133.GA18731@stusta.de>
References: <Pine.LNX.4.64.0703062050570.5963@woody.linux-foundation.org>
	<20070313125025.GW18731@stusta.de>
	<1173816328.13341.101.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1173816328.13341.101.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Tejun Heo <htejun@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Emil Karlson <jkarlson@cc.hut.fi>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephane Casset <sept@logidee.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 13, 2007 at 09:05:28PM +0100, Thomas Gleixner wrote:
> On Tue, 2007-03-13 at 13:50 +0100, Adrian Bunk wrote:
> > Subject    : hrtimer_switch_to_hres():
> >              wrong tick_init_highres() return value handling
> > References : http://lkml.org/lkml/2007/3/6/262
> > Submitter  : Linus Torvalds <torvalds@linux-foundation.org>
> > Caused-By  : Thomas Gleixner <tglx@linutronix.de>
> >              commit 54cdfdb47f73b5af3d1ebb0f1e383efbe70fde9e
> > Handled-By : Thomas Gleixner <tglx@linutronix.de>
> > Status     : unknown
> =

> Linus merged the original patch, which solved the real problem. =

> =

> He just gave me a lesson how to do it right next time.

Sorry, my fault.

> 	tglx

cu
Adrian

-- =


       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
