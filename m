From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 14:02:39 +0200
Message-ID: <20061101120239.GA7679@mellanox.co.il>
References: <20061101093320.GA18641@elf.ucw.cz>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061101093320.GA18641@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Ernst Herzberg <earny@net4u.de>, Andi Kleen <ak@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>, Adrian Bunk <bunk@stusta.de>, Martin Lorenz <martin@lorenz.eu.org>
List-Id: linux-pm@vger.kernel.org

Quoting Pavel Machek <pavel@ucw.cz>:
> > > What I plan to do is using eea0e11c1f0d6ef89e64182b2f1223a4ca2b74a2
> > > for a couple of days and see how this works out.
> > =

> > Ugh. Unfortunately in that kernel version, the e1000 driver says
> > the eeprom checksum is bad (works fine with 2.6.19-rc3).
> > So, I tried some suspends/resumes and things seem to work, but
> > I won't be able to test it under real use conditions.
> =

> Just comment out the eeprom checksum check...
> =


Right, that worked, thanks.
I'm running on eea0e11c1f0d6ef89e64182b2f1223a4ca2b74a2 now, seems to be fi=
ne
so far.

-- =

MST
