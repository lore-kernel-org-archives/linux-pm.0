From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Tue, 31 Oct 2006 21:26:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
References: <20061029231358.GI27968@stusta.de>
	<20061101030126.GE27968@stusta.de>
	<200610312215.44454.len.brown@intel.com>
	<200611010611.30445.earny@net4u.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200611010611.30445.earny@net4u.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ernst Herzberg <earny@net4u.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, linux-pm@osdl.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Hugh Dickins <hugh@veritas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Martin Lorenz <martin@lorenz.eu.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org



On Wed, 1 Nov 2006, Ernst Herzberg wrote:
> =

> still bisecting, will report the result.

Figuring out what caused an apparent change of behaviour is definitely a =

good idea - it might give us some clue to what really is going on.

(Or it might not. Sometimes the patch that triggers changes really doesn't =

seem to have anything to do with anything, and it literally was just a =

latent bug that just happened to be exposed by something that had nothing =

to do with anything at all but perhaps timing. But that's pretty rare in =

the end. It happens, but it's definitely not the common case at all, and I =

think it's great that you're bisecting even if there is a possibility =

that we'll be left with a big "Huh? Whaa?" as the end result ;^)

		Linus
