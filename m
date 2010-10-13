From: Sundar <sunder.svit@gmail.com>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 23:30:22 +0530
Message-ID: <AANLkTin0cLmmCyWuQS=OyrOVp-wTEmW65PRqR7S_ez4b__4530.32383597947$1286992886$gmane$org@mail.gmail.com>
References: <AANLkTi=ouKDuPgUgLOwfBPhWKM=RCoh8hb0tY3h53i2r@mail.gmail.com>
	<Pine.LNX.4.44L0.1010131335580.2311-100000@iolanthe.rowland.org>
	<AANLkTikqNNY=gNC96ZEo5ar+Adw80h=M3_XGe3A--unu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikqNNY=gNC96ZEo5ar+Adw80h=M3_XGe3A--unu@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 13, 2010 at 11:12 PM, Sundar <sunder.svit@gmail.com> wrote:
> On Wed, Oct 13, 2010 at 11:07 PM, Alan Stern <stern@rowland.harvard.edu> =
wrote:
>>
>> Sorry, I don't quite understand your question. =A0I think it would be
>> okay to add an interface for userspace to cut short a runtime-suspend
>> delay, but I don't think anything more is needed.
>>
>
> I was just confirming that it is agreed by all that we can definitely wrap
> this up via the standard PM helpers; through the accelerated suspend
> if no one has any other reservations.
>

And I forgot one more point. Since this switch feature was one of the
requirements for the Meego framework, wouldnt it be nice if the Meego
people also put out their opinions on this newer solution?

Cheers!
