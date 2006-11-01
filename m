From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 11:44:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611011141450.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0611011003270.25218@g5.osdl.org>
	<20061101193333.GC9085@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061101193333.GC9085@mellanox.co.il>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Ernst Herzberg <earny@net4u.de>, Andi Kleen <ak@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Hugh Dickins <hugh@veritas.com>, Adrian Bunk <bunk@stusta.de>, Martin Lorenz <martin@lorenz.eu.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 1 Nov 2006, Michael S. Tsirkin wrote:

> > I've pushed out the changes, but here is the part that may or may not =

> > matter for anybody who wants to test it if they don't use git or if it =

> > hasn't mirrored out yet. Michael? Martin?
> =

> I pulled the latest git, and seems to work for me, thanks.
> This still could be a false negative (happened already) so I'll
> continue using this, and will post the results.

Ok, thanks.

> > Somebody should look into that case. Does anybody feel like they want t=
o =

> > learn more about the IO-APIC? Halloween is over and gone, but if you wa=
nt =

> > to scare small children _next_ year, telling them about the IO-APIC is =

> > likely a good strategy.
> =

> Hmm, sounds interesting :)
> Is this a good place to start (I'm feeling lucky hit for IO-APIC)?
> http://www.intel.com/design/chipsets/datashts/290566.htm

Yeah, that's the datasheet. Note that a lot of the IO-APIC complexity is =

not so much in the programming interfaces themselves, but in keeping track =

of how the heck the thing is connected (ie ExtINT vs SCI vs "normal apic =

interrupt" etc).

		Linus
