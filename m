From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 13:28:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151325520.5498@g5.osdl.org>
References: <20060615083921.GB9423@elf.ucw.cz>
	<Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
	<20060615161446.GA23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150922200.5498@g5.osdl.org>
	<20060615182419.GA1711@elf.ucw.cz>
	<Pine.LNX.4.64.0606151219540.5498@g5.osdl.org>
	<20060615200333.GB1849@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615200333.GB1849@elf.ucw.cz>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Pavel Machek wrote:
> =

> Why? We are saving state to memory, we should not need any other
> devices to do that.

Hell no, we're not.

> Well, for devices that are so complex that userspace support is
> needed... yes, you are right, separate pass would be
> needed. Fortunately, such devices are not too common.

"Not too common"?

Having a graphical console is a hell of a lot more common than just about =

any other device I can imagine, with the possible exception of USB these =

days.

> Well, doing half-switch would be cleaner in s2ram case, agreed. For
> s2disk, having console to write on is actually very nice.

The thing is, splitting up save and suspend woul dget exactly that. The =

only thing you couldn't see is the very final suspend, but that should =

also be the part that literally does the least.

In fact, done right, if you know the machine powers off, the final suspend =

should literally not be needed. "Remove power globally" is actually a very =

good suspend/shutdown mechanism that doesn't even need any driver support ;)

		Linus
