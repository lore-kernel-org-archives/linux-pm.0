From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 07:54:35 +0200
Message-ID: <20061101055435.GB4933@mellanox.co.il>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
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

> On Wed, 1 Nov 2006, Ernst Herzberg wrote:
> > =

> > still bisecting, will report the result.
> =

> Figuring out what caused an apparent change of behaviour is definitely a =

> good idea - it might give us some clue to what really is going on.

I've been bisecting ACPI/suspend thinkpad issue myself and I seem to get
eea0e11c1f0d6ef89e64182b2f1223a4ca2b74a2 good,
cf4c6a2f27f5db810b69dcb1da7f194489e8ff88 bad.

At least this makes some sense since the log speaks about suspend.  Problem=
 is,
ACPI issues are in rare cases going away for a while for me so this needs m=
ore
testing before I can say for sure about the good part - I already had one f=
alse
negative.  What I plan to do is using eea0e11c1f0d6ef89e64182b2f1223a4ca2b7=
4a2
for a couple of days and see how this works out.

-- =

MST
