From: Jerome Glisse <j.glisse@gmail.com>
Subject: Re: [REGRESSION]: hibernate/sleep regression w/ bisection
Date: Mon, 21 Nov 2011 16:29:23 -0500
Message-ID: <CAH3drwbtWJcPOixW0gze0e0jbTn_uY0x5E=KY8N-WDcb1t8h2w__37120.5983371057$1321933367$gmane$org@mail.gmail.com>
References: <20111102160208.GA6657@zeus>
	<20111102163109.GA29430@core.coreip.homeip.net>
	<20111103155956.GG4417@google.com> <20111103184559.GA3295@zeus>
	<20111103213959.GP4417@google.com> <20111104134347.GA2480@zeus>
	<20111104161431.GZ4417@google.com> <20111104173441.GA2157@zeus>
	<CAH3drwaXcUy1vz8bvHwE2_iga5WUsWn_Dp0oe_0r3UacV0vT_A@mail.gmail.com>
	<20111104230758.GA7332@zeus> <20111121210908.GJ25776@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20111121210908.GJ25776@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Airlie <airlied@linux.ie>, Andrew Watts <akwatts@ymail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 21, 2011 at 4:09 PM, Tejun Heo <tj@kernel.org> wrote:
> On Fri, Nov 04, 2011 at 06:08:20PM -0500, Andrew Watts wrote:
>> On Fri, Nov 04, 2011 at 01:35:53PM -0400, Jerome Glisse wrote:
>> >
>> > I need full dmesg
>> >
>> > Cheers,
>> > Jerome
>>
>> Hi. Just noticed I attached a gzip of my dmesg last time by mistake.
>>
>> Here goes as text/plain.
>
> Out of curiosity, did it get somewhere?
>
> Thanks.
>
> --
> tejun
>

Yeah i am pretty sure i know what's going wrong but there is no easy
fix, there is a deadlock in the kernel when gem wait ioctl is call on
scanout buffer and that a gpu reset happen

Cheers,
Jerome
