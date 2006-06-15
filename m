From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 10:41:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151035320.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<1150324014.21941.23.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606141537570.5498@g5.osdl.org>
	<20060614224436.GF7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
	<20060614235713.GA24859@elf.ucw.cz>
	<Pine.LNX.4.64.0606141702300.5498@g5.osdl.org>
	<20060615161721.GB23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150931190.5498@g5.osdl.org>
	<20060615165909.GE23859@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615165909.GE23859@elf.ucw.cz>
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
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 15 Jun 2006, Pavel Machek wrote:
> =

> To have DMAs stopped, you need to "freeze" the devices.

No you don't. =


You need to stop the high-level _queues_, but that's something totally =

different from actually stopping the _devices_.

So, for example, you want to make sure that nobody is writing to the disk =

cache, or reading from the disk, or writing to it (apart from the thing =

that writes the image, of course) any more.

But that's fundamental: and it has absolutely zero to do with device =

suspend (although you do want to tell the device about it - a number of =

devices that do polling even in the absense of user input should probably =

take the hint from "save your state").

The fact that you equate "suspend the devices" with "stop doing IO" shows =

how you think at the wrong level.

The "stop doing IO" is at a much higher level.

			Linus
