From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 01 Nov 2006 17:35:55 -0500
Message-ID: <4549214B.1000103@tmr.com>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>	<20061101055435.GB4933@mellanox.co.il>
	<Pine.LNX.4.64.0610312206390.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610312206390.25218@g5.osdl.org>
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
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Martin Lorenz <martin@lorenz.eu.org>, linux-acpi@vger.kernel.org, Ernst Herzberg <earny@net4u.de>, Hugh Dickins <hugh@veritas.com>, Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Linus Torvalds wrote:

> I wonder if the order matters more, though. Andi? We _used_ to write the =

> high word first, and I think the order matters. The low word contains the =

> enable bit, for example, so when enabling an interrupt, you should write =

> the low word last, when you disable it you should write the low word =

> first.
> =

Although you can argue that anyone coding here should be a guru, in =

practice things this subtle really would be helped by a comment in the =

initial code. I don't agree that "if it was hard to write it should be =

hard to understand." Clearly several competent people missed this =

dependency, or the patch would not have gone in.

-- =

Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
