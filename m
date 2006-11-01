From: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 16:36:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611011616460.6462@blonde.wat.veritas.com>
References: <20061029231358.GI27968@stusta.de>
	<20061030135625.GB1601@mellanox.co.il>
	<20061101030126.GE27968@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061101030126.GE27968@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, linux-pm@osdl.org, linux-acpi@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Linus Torvalds <torvalds@osdl.org>, Martin Lorenz <martin@lorenz.eu.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Nov 2006, Adrian Bunk wrote:
> =

> Subject    : Thinkpad R50p: boot fail with (lapic && on_battery)
> References : http://lkml.org/lkml/2006/10/31/333
> Submitter  : Ernst Herzberg <earny@net4u.de>
> Status     : submitter was asked to bisect
> =

> It seems to be completely unrelated (except that it's also a ThinkPad), =

> but it might be worth a try whether a (non-SMP) kernel without APIC =

> support fixes the issues after resume.
> =

> Hugh, your laptop seems to be a non-SMP laptop.

That's right.

> Do you have APIC enabled, and if yes does disabling help?

Yes, I do.  But I've just tried booting with "noapic" and with "nolapic"
and with "noapic nolapic", but none of those make any difference.

(That is, they make no difference to the FnF4-ineffective-after-resume
behaviour that I'm finding fairly easy to reproduce at will today on
2.6.19-rc4; whereas yesterday it was seeming to me that -rc4 was much
better than -rc3 in this regard.  Something I have learnt today is that
the key is ineffective "for a while", but may become effective later.
It's conceivable that the behaviour I'm reproducing today is not quite
the same as what I was experiencing earlier with real-life suspends.)

More to the point, with great hope in my heart, I've tried backing
out Andi's git-cf4c6a2f27f5db810b69dcb1da7f194489e8ff88.patch
to arch/i386/kernel/io_apic.c, the one which Michael and Linus have
homed in on.  But sadly that makes no difference for me: I'd better
get down to my own bisection.

Hugh
