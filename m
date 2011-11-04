From: Jerome Glisse <j.glisse@gmail.com>
Subject: Re: [REGRESSION]: hibernate/sleep regression w/ bisection
Date: Fri, 4 Nov 2011 13:35:53 -0400
Message-ID: <CAH3drwaXcUy1vz8bvHwE2_iga5WUsWn_Dp0oe_0r3UacV0vT_A__3109.23155998371$1321058415$gmane$org@mail.gmail.com>
References: <20111101124759.GA1326@zeus>
	<20111102054658.GA29035@core.coreip.homeip.net>
	<20111102160208.GA6657@zeus>
	<20111102163109.GA29430@core.coreip.homeip.net>
	<20111103155956.GG4417@google.com> <20111103184559.GA3295@zeus>
	<20111103213959.GP4417@google.com> <20111104134347.GA2480@zeus>
	<20111104161431.GZ4417@google.com> <20111104173441.GA2157@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20111104173441.GA2157@zeus>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Watts <akwatts@ymail.com>
Cc: David Airlie <airlied@linux.ie>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 4, 2011 at 1:34 PM, Andrew Watts <akwatts@ymail.com> wrote:
> On Fri, Nov 04, 2011 at 09:14:31AM -0700, Tejun Heo wrote:
>> Andrew, can you please kill the X server after the hang and see
>> whether that brings the system back? =A0I think sshd should still work
>> and if not you can write a script to kill the X server after 30secs
>> after resume (and kill that script if resume succeeds).
>
> Hi Tejun & Jerome.
>
> Tejun: My script killed X after a small wait from a bad resume. I am retu=
rned
> to the funcioning calling console. I can then re-start X and all subsyste=
ms
> seem to working fine.
>
> Jerome: I posted a post-bad-resume dmesg snippet with a GPU lockup warning
> and trace here:
>
> =A0 http://article.gmane.org/gmane.linux.kernel/1210057
>
> Did you need to see more?
>
> Thanks.
>
> ~ Andy
>
>

I need full dmesg

Cheers,
Jerome
