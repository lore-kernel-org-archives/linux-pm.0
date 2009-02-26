From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Wed, 25 Feb 2009 20:24:03 -0800
Message-ID: <d6200be20902252024ie529433r9790f5d5ec7b8b5a__14109.6029467464$1235622615$gmane$org@mail.gmail.com>
References: <200902221837.49396.rjw@sisk.pl>
	<d6200be20902251813o3ff4a065nb0a54321e27c512d@mail.gmail.com>
	<alpine.LFD.2.00.0902251848120.3111@localhost.localdomain>
	<20090226030050.GA3361@elte.hu>
	<d6200be20902251931lf563c2aw43d5266e9677e168@mail.gmail.com>
	<alpine.LFD.2.00.0902251935190.3111@localhost.localdomain>
	<d6200be20902251950l34d5968q4b553ce8305ebd4b@mail.gmail.com>
	<alpine.LFD.2.00.0902251956450.3111@localhost.localdomain>
	<d6200be20902252013v366ce771w8a129e9f3b75927f@mail.gmail.com>
	<m1y6vtkewc.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1y6vtkewc.fsf@fess.ebiederm.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 25, 2009 at 8:20 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Arve Hj=F8nnev=E5g <arve@android.com> writes:
>
>> We only have one gpio input driver, but I don't think is good to loose
>> any wakeup interrupts. Any driver that needs an edge triggered wakeup
>> interrupt will have problems if the hardware does not regenerate the
>> interrupt when the host does not respond.
>
> We are not loosing interrupts. =A0The normal implementation of disable
> is a software disable and sets IRQ_PENDING to ensure we don't loose
> interrupts when the interrupt is disabled.

We loose the wakeup, but yes, the interrupt will be delivered if the
system wakes up for any other reason.

-- =

Arve Hj=F8nnev=E5g
