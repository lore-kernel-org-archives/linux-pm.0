From: Matthew Locke <matt@nomadgs.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 15:08:54 -0700
Message-ID: <b4472ec8030a7a1b6ced6e13396cdb15@nomadgs.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<450530BD.8090101@gmail.com> <20060911193637.GA11901@elf.ucw.cz>
	<c728abebb17f975089390dd3f87069af@nomadgs.com>
	<20060911200636.GC11901@elf.ucw.cz>
	<20060911220007.GB12176@linux.intel.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060911220007.GB12176@linux.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: mgross@linux.intel.com
Cc: Preece Scott-PREECE <scott.preece@motorola.com>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


On Sep 11, 2006, at 3:00 PM, Mark Gross wrote:

> On Mon, Sep 11, 2006 at 10:06:36PM +0200, Pavel Machek wrote:
>> No, I'm not ready to ACK. Actually I'd describe it as "broken piece of
>> code noone needs". And IIRC Greg's last question was "what is it good
>> for?". Dave Jones was not too pleased with cpufreq/powerop
>> integration. Intel people explained you broke centrino
>> speedstep. Shall I continue?
>>
>
> Those where directed to the other patch that David Singleton posted.
>

Right.

  Pavel and others,  I know its confusing having the two.  Let's focus =

on just PowerOP.  The PowerOP patches are just powerop and do not =

affect other subsystems or existing PM code.  The other stuff (cpufreq =

integration, suspend/resume integration) can come later.   Nothing in =

PowerOP prevents us from adding more later.

>
>> 								Pavel
>> -- =

>> (english) http://www.livejournal.com/~pavelmachek
>> (cesky, pictures) =

>> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
