From: Andrew Watts <akwatts@ymail.com>
Subject: Re: [REGRESSION]: hibernate/sleep regression w/ bisection
Date: Fri, 4 Nov 2011 12:34:58 -0500
Message-ID: <20111104173441.GA2157__633.366211741482$1321058410$gmane$org@zeus>
References: <20111101124759.GA1326@zeus>
	<20111102054658.GA29035@core.coreip.homeip.net>
	<20111102160208.GA6657@zeus>
	<20111102163109.GA29430@core.coreip.homeip.net>
	<20111103155956.GG4417@google.com> <20111103184559.GA3295@zeus>
	<20111103213959.GP4417@google.com> <20111104134347.GA2480@zeus>
	<20111104161431.GZ4417@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111104161431.GZ4417@google.com>
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
Cc: David Airlie <airlied@linux.ie>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, j.glisse@gmail.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 04, 2011 at 09:14:31AM -0700, Tejun Heo wrote:
> Andrew, can you please kill the X server after the hang and see
> whether that brings the system back?  I think sshd should still work
> and if not you can write a script to kill the X server after 30secs
> after resume (and kill that script if resume succeeds).

Hi Tejun & Jerome.

Tejun: My script killed X after a small wait from a bad resume. I am returned 
to the funcioning calling console. I can then re-start X and all subsystems
seem to working fine.

Jerome: I posted a post-bad-resume dmesg snippet with a GPU lockup warning
and trace here:

   http://article.gmane.org/gmane.linux.kernel/1210057

Did you need to see more?

Thanks.

~ Andy
