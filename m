From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add some basic resume trace facilities
Date: Fri, 16 Jun 2006 11:49:13 +1000
Message-ID: <1150422553.7725.92.camel@localhost.localdomain>
References: <5389061B65D50446B1783B97DFDB392D01623F6F@orsmsx411.amr.corp.intel.com>
	<Pine.LNX.4.64.0606131551210.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606131551210.5498@g5.osdl.org>
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
Cc: linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2006-06-13 at 15:59 -0700, Linus Torvalds wrote:

> The Apple Mac Mini I can't even get to _beep_, which is really annoying. =

> It's a wonderful debug sequence ("oh, I head 15 beeps, it got to point =

> X"). Or rather, it's "wonderful" compared to something that gives you jus=
t =

> one single piece of data after the reboot ;)

No magic GPIO or ACPU command you can use to tweak the front led ?

> The real-time clock was literally the only thing I could find that didn't =

> get cleared, and that obviously has some serious limitations size-wise.

What about vram ? the entire of it gets cleared or only the displayed
part ?

Ben.
