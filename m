From: Andrew Watts <akwatts@ymail.com>
Subject: Re: [REGRESSION]: hibernate/sleep regression w/ bisection
Date: Tue, 22 Nov 2011 06:40:21 -0500
Message-ID: <20111122114019.GA20081__7300.62488369203$1322500050$gmane$org@zeus>
References: <20111103155956.GG4417@google.com> <20111103184559.GA3295@zeus>
	<20111103213959.GP4417@google.com> <20111104134347.GA2480@zeus>
	<20111104161431.GZ4417@google.com> <20111104173441.GA2157@zeus>
	<CAH3drwaXcUy1vz8bvHwE2_iga5WUsWn_Dp0oe_0r3UacV0vT_A@mail.gmail.com>
	<20111104230758.GA7332@zeus> <20111121210908.GJ25776@google.com>
	<CAH3drwbtWJcPOixW0gze0e0jbTn_uY0x5E=KY8N-WDcb1t8h2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAH3drwbtWJcPOixW0gze0e0jbTn_uY0x5E=KY8N-WDcb1t8h2w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jerome Glisse <j.glisse@gmail.com>
Cc: David Airlie <airlied@linux.ie>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 21, 2011 at 04:29:23PM -0500, Jerome Glisse wrote:
> On Mon, Nov 21, 2011 at 4:09 PM, Tejun Heo <tj@kernel.org> wrote:
> >
> > Out of curiosity, did it get somewhere?
> >
> > Thanks.
> >
> > --
> > tejun
> >
> 
> Yeah i am pretty sure i know what's going wrong but there is no easy
> fix, there is a deadlock in the kernel when gem wait ioctl is call on
> scanout buffer and that a gpu reset happen
> 
> Cheers,
> Jerome

Tejun, I was about to send a similar email asking about this; many thanks
for sharing my interest.

Jerome, sounds encouraging that you think you know what the issue is. What
are the next steps? Please let me know how I can assist on my end (code 
validation, etc.).

~ Andy
