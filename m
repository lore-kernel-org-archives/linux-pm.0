From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 0/2] Repair pci_restore_state when used with
	device resets
Date: Thu, 08 Mar 2007 13:26:12 -0700
Message-ID: <m1ejnz5vob.fsf@ebiederm.dsl.xmission.com>
References: <45ED8A12.5040803@intel.com>
	<m1ejo1elj6.fsf@ebiederm.dsl.xmission.com>
	<45EEE8CF.1060803@intel.com> <45EEEC2C.5090609@intel.com>
	<m1649cdfas.fsf@ebiederm.dsl.xmission.com>
	<20070307185317.5601d452.akpm@linux-foundation.org>
	<m1wt1s6x2p.fsf@ebiederm.dsl.xmission.com>
	<45EFDD8C.3070702@garzik.org>
	<m1abyn7iin.fsf@ebiederm.dsl.xmission.com>
	<m1tzwv5wz9.fsf_-_@ebiederm.dsl.xmission.com>
	<20070308200809.GA10088@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070308200809.GA10088@elte.hu> (Ingo Molnar's message of "Thu,
	8 Mar 2007 21:08:09 +0100")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Kok, Auke" <auke-jan.h.kok@intel.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Garzik <jeff@garzik.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, michael@ellerman.id.au, linux-pci@atrey.karlin.mff.cuni.cz, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> I have never have figured out how to get suspend/resume actually =

>> working on any of my machines [...]
>
> ouch! Are you interested in getting it work?

I haven't even seriously tried. I don't yet have a laptop and I like
staying logged.  The first time I rolled the jiffie counter it was a
happened after I had realized that if I kept my machine up for another
couple of months my jiffie counter would roll and I said why not  So
basically suspend hasn't been a feature I'm been interested in using.
I get more annoyed at my UPS failing..

I will probably get around to figuring out the whole suspend/resume
thing one of these days and it will probably take me a day or two.
But that doesn't result in bug fixes being delivered in a timely manner.

Eric
