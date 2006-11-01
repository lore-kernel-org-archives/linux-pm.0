From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 21:33:33 +0200
Message-ID: <20061101193333.GC9085@mellanox.co.il>
References: <Pine.LNX.4.64.0611011003270.25218@g5.osdl.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611011003270.25218@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Ernst Herzberg <earny@net4u.de>, Andi Kleen <ak@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Adrian Bunk <bunk@stusta.de>, Martin Lorenz <martin@lorenz.eu.org>
List-Id: linux-pm@vger.kernel.org

Quoting r. Linus Torvalds <torvalds@osdl.org>:
> Subject: Re: 2.6.19-rc <-> ThinkPads
> =

> =

> =

> On Wed, 1 Nov 2006, Andi Kleen wrote:
> >
> > Ok please revert the i386 patch for now then if it fixes the ThinkPads. =

> > The x86-64 version should be probably fixed too, but doesn't cleanly. I=
 will =

> > send you later a patch to fix this there properly.
> =

> Actually, I should have just fixed the ordering. I did some cleanups too, =

> but those are unrelated (except in the sense that I wanted to look at the =

> assembly code, and the cleanups made the code generation at least half-wa=
y =

> sane!)
> =

> I've pushed out the changes, but here is the part that may or may not =

> matter for anybody who wants to test it if they don't use git or if it =

> hasn't mirrored out yet. Michael? Martin?

I pulled the latest git, and seems to work for me, thanks.
This still could be a false negative (happened already) so I'll
continue using this, and will post the results.

> Andi: I think the patches should work pretty much as-is for x86-64 too, =

> since all the issues would seem to be similar. =

> =

> I'm not entirely happy with "ioapic_write_entry()" now either (if we =

> change an entry that was already unmasked, we should probably mask it =

> first by writing the low word with the mask bit set, then write the high =

> word, and then write the low word again), but =

> =

>  - this makes us match the ordering we _used_ to have, so if the cleanup =

>    broke things for people, this should unbreak it, and at least not be =

>    any worse than it used to be.
> =

>  - when we write new unmasked entries, they all _should_ have been masked =

>    before, so hopefully the "change a unmasked entry while it's unmasked" =

>    case doesn't actually ever happen. But I didn't actually _check_.
> =

> Somebody should look into that case. Does anybody feel like they want to =

> learn more about the IO-APIC? Halloween is over and gone, but if you want =

> to scare small children _next_ year, telling them about the IO-APIC is =

> likely a good strategy.
> =

> 		Linus

Hmm, sounds interesting :)
Is this a good place to start (I'm feeling lucky hit for IO-APIC)?
http://www.intel.com/design/chipsets/datashts/290566.htm

-- =

MST
