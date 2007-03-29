From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ PATCH] Add suspend/resume for HPET was: Re: [3/6]
 2.6.21-rc4: known regressions
Date: Wed, 28 Mar 2007 22:08:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703282203550.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<200703281701.23876.maximlevitsky@gmail.com>
	<Pine.LNX.4.64.0703280931520.6730@woody.linux-foundation.org>
	<200703290641.20236.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703290641.20236.maximlevitsky@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim <maximlevitsky@gmail.com>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 29 Mar 2007, Maxim wrote:
>
> 	I am sending here a patch that as was discussed here adds hpet to list o=
f system devices
> 	and adds suspend/resume hooks this way.
> 	I tested it and it works fine.

Ok, it certainly looks better, but it *also* looks like it just assumes =

the HPET is there. Which would work in testing _with_ a HPET, but would =

likely break on hardware without one, no?

Shouldn't there be at least something like a

	if (!is_hpet_capable())
		return 0;

at the top of that init routine? I'd also expect that you'd need to check =

that "hpet_virt_address" is valid or something?

(Or, better yet, shouldn't we set "boot_hpet_disable" when we decide not =

to use the HPET, and set hpet_virt_address to NULL?)

		Linus
