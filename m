From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Thu, 19 Feb 2009 21:35:39 -0800
Message-ID: <d6200be20902192135y166eb90bt895c97c7b381c44c__12339.8289819763$1235108290$gmane$org@mail.gmail.com>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
	<20090216145948.6fea81c3@infradead.org>
	<200902170019.40599.rjw@sisk.pl>
	<20090216232329.GA15678@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090216232329.GA15678@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 16, 2009 at 3:23 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrot=
e:
> On Tue, Feb 17, 2009 at 12:19:38AM +0100, Rafael J. Wysocki wrote:
>
>> This, again, seems to be a bit x86-centric. :-)  The Android people are =
telling
>> us that on the hardware they deal with it does make sense to put the ent=
ire
>> system to sleep even for relatively short periods of time, since the lat=
encies
>> involved are not too bad.
>
> Arve said that the power state was equivalent in idle and suspend, but
> that they preferred suspend because it stopped any periodic timers. I'd
> be more interested in making sure that unnecessary timers aren't running
> than focusing on automatically entering system-wide suspend - Nokia have
> been managing this since 2005 with good results.

I'm sure you can build a product with acceptable battery life without
suspend. The average power draw on the G1 while idle with everything
off is less than the power draw was in suspend on our previous
hardware. However, on the same hardware you get 40 days standby using
suspend versus 20 days using idle. If you turn on the radio and use
the device every day, this starts to become irrelevant since you are
lucky to get more than a few days standby time. However, if you
install an application that wakes up 60 times a second (to check if it
need to draw something on the screen) the difference between idle and
suspend becomes 10 hours versus 40 days, or 10 hours versus 3 days
with my use.

-- =

Arve Hj=F8nnev=E5g
