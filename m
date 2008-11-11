From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Subject: Re: [Bugme-new] [Bug 11717] New: Pressing suspend button
	suspends, but does not wakes up
Date: Tue, 11 Nov 2008 07:37:58 -0200
Message-ID: <20081111093758.GA18786__48862.2018522166$1226396585$gmane$org@ime.usp.br>
References: <20081106194724.GB15366@ime.usp.br>
	<20081107014535.GA19201@ime.usp.br>
	<1226044855.4913f5b7f2f45@webmail.ime.usp.br>
	<20081108075008.GA8177@ime.usp.br>
	<dd18b0c30811080020i23418742xc6388a5942456566@mail.gmail.com>
	<20081109024514.GA11744@ime.usp.br>
	<20081109113332.GD6094@elf.ucw.cz>
	<dd18b0c30811092117mc7bd310kaac33f5b1ff0a61d@mail.gmail.com>
	<20081110074516.GB707@atrey.karlin.mff.cuni.cz>
	<dd18b0c30811100700y7922ce37y8ba39ba7b43031b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <dd18b0c30811100700y7922ce37y8ba39ba7b43031b3@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: rbrito@ime.usp.br, linux-kernel@vger.kernel.org, yakui.zhao@intel.com, Pavel Machek <pavel@suse.cz>, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@lists.linux-foundation.org, bugzilla@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi, all.

On Nov 10 2008, Justin Mattock wrote:
> using the manual(echo mem > /sys/power/state)
> approach is not so good though
> i.g. black screen when waking up
> for a few seconds, then a automatic reboot.

To answer Zhang Rui's question, what I get is an approximation of what
Justin's posted here.

Zhang Rui wrote:
> let's focus on the suspend/resume problem in this bug entry.
> So please stop using suspend button or lid button to do suspend/resume
> test.
> You can use "echo mem > /sys/power/state" to suspend and use power button
> to resume to see how suspend/resume works on your laptop.

What I get when I use this is that the notebook goes to suspend state and
the only button that it has (power button) has a blue light that starts
blinking.

When I press the power button, as per your instructions, the machine powers
itself off and then, suddenly, it powers itself on again! (yes, that's
strange).

I'm filming this so that you can see for yourselves. The movie is at
<http://www.ime.usp.br/~rbrito/linux/notebook-02.mp4>.


Thanks for all your help, Rog=E9rio Brito.

-- =

Rog=E9rio Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
